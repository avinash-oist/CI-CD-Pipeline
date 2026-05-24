from flask import Flask, render_template, request, jsonify
 
app = Flask(__name__)
 
 
@app.route("/")
def home():
     return render_template("index.html")
 
 
@app.route("/calculate", methods=["POST"])
def calculate():
     data = request.get_json()
     expression = data.get("expression", "")
 
     try:
         # eval() computes a math string like "10+5*2"
         # We restrict it to safe characters only
         allowed = set("0123456789+-*/.() ")
         if not all(c in allowed for c in expression):
             return jsonify({"result": "Error: invalid input"})
 
         result = eval(expression)
 
         # Round to avoid floating point ugliness like 0.1+0.2 = 0.30000000004
         result = round(result, 10)
         return jsonify({"result": result})
 
     except ZeroDivisionError:
         return jsonify({"result": "Error: ÷ by zero"})
     except Exception:
         return jsonify({"result": "Error"})
 
if __name__ == "__main__":
     app.run(host="0.0.0.0", port=8080, debug=False)
