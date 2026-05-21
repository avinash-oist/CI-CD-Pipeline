#!/bin/bash
 set -euo pipefail
 
 # ─────────────────────────────────────────────
 # Zantac POC - Full deployment orchestrator
 # Usage: ./scripts/deploy.sh [apply|destroy]
 # ─────────────────────────────────────────────
 
 ACTION="${1:-apply}"
 TERRAFORM_DIR="terraform/environments/dev"
 ANSIBLE_DIR="ansible"
 
 # Colours for output
 RED='\033[0;31m'
 GREEN='\033[0;32m'
 YELLOW='\033[1;33m'
 NC='\033[0m' # No Colour
 
 log()    { echo -e "${GREEN}[INFO]${NC}  $1"; }
 warn()   { echo -e "${YELLOW}[WARN]${NC}  $1"; }
 error()  { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
 
 # ── 1. Pre-flight checks ──────────────────────
 log "Checking prerequisites..."
 command -v terraform >/dev/null 2>&1 || error "terraform not found. Install it first."
 command -v ansible-playbook >/dev/null 2>&1 || error "ansible-playbook not found. Install Ansible first."
 command -v aws >/dev/null 2>&1 || error "aws CLI not found."
 
 aws sts get-caller-identity --output text --query 'Account' >/dev/null 2>&1 \
   || error "AWS credentials not configured. Run 'aws configure' first."
 
 log "Prerequisites OK"
 
 # ── 2. Terraform ─────────────────────────────
 cd "$TERRAFORM_DIR"
 
 if [[ "$ACTION" == "destroy" ]]; then
   warn "Destroying all infrastructure..."
   terraform destroy -auto-approve
   log "Infrastructure destroyed. Billing stopped."
   exit 0
 fi
 
 log "Initialising Terraform..."
 terraform init -upgrade
 
 log "Planning..."
 terraform plan -out=tfplan
 
 log "Applying infrastructure..."
 terraform apply tfplan
 rm -f tfplan
 
 # Capture ALB DNS from outputs
 ALB_DNS=$(terraform output -raw alb_dns_name)
 log "ALB DNS: $ALB_DNS"
 
 # ── 3. Wait for EC2 instances to be running ───
 log "Waiting for EC2 instances to register with ASG..."
 sleep 30  # Give ASG time to launch instances
 
 log "Waiting for instances to pass health checks..."
 aws elbv2 wait target-in-service \
   --target-group-arn "$(terraform output -raw alb_dns_name 2>/dev/null || echo '')" \
   --region ap-south-1 2>/dev/null || warn "Could not wait on TG - continuing anyway"
 
 sleep 60  # Extra wait for user_data (Apache install takes ~30s)
 
 # ── 4. Ansible ────────────────────────────────
 cd - > /dev/null
 cd "$ANSIBLE_DIR"
 
 log "Running Ansible to configure webservers..."
 ansible-playbook site.yml -v
 
 cd - > /dev/null
 
 # ── 5. Smoke test ────────────────────────────
 log "Running smoke test..."
 HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://${ALB_DNS}" --max-time 10 || echo "000")
 
 if [[ "$HTTP_CODE" == "200" ]]; then
   log "✅ Smoke test PASSED - HTTP $HTTP_CODE"
   echo ""
   echo -e "${GREEN}═══════════════════════════════════════${NC}"
   echo -e "${GREEN}  POC DEPLOYED SUCCESSFULLY${NC}"
   echo -e "${GREEN}  URL: http://${ALB_DNS}${NC}"
   echo -e "${GREEN}═══════════════════════════════════════${NC}"
 else
   warn "Smoke test returned HTTP $HTTP_CODE - ALB may still be warming up"
   echo "  Try: curl http://${ALB_DNS}"
 fi