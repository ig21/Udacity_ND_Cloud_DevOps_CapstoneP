from flask import Flask

app = Flask(__name__)


@app.route("/")
def home():
    html = "<h3>Hello Udacity!</h3><p>This is my Capstone project nano application. </p> \
             <p><font color=green>Code change can be seen in blue/green deployment approach.</font></p>"
    return html.format(format)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)  # specify port=80
