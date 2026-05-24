 # Start from official Python 3.12 slim image
 # "slim" = minimal OS, smaller image size (~50MB vs ~900MB for full)
 FROM python:3.12-slim
 
 # Set working directory inside the container
 # All commands below run from this folder
 WORKDIR /app
 
 # Copy ONLY requirements.txt first — why? Docker caching.
 # If requirements don't change, Docker reuses this layer (faster builds)
 COPY requirements.txt .
 
 # Install dependencies
 RUN pip install --no-cache-dir -r requirements.txt
 
 # Now copy the rest of the app code
 COPY . .
 
 # Tell Docker which port this app listens on (documentation only — doesn't open it)
 EXPOSE 8080
 
 # Command to run when container starts
 # Use list format (not string) — best practice, avoids shell interpretation issues
 CMD ["python", "app.py"]