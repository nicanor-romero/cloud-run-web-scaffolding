import flask
import os

app = flask.Flask(__name__)


@app.route('/')
@app.route('/<path:path>')
def serve_files(path="index.html"):
    if path.endswith('.html'):
        return flask.render_template(path)
    return flask.send_from_directory('static', path)


if __name__ == "__main__":
    app.run(debug=True, host="localhost", port=int(os.environ.get("PORT", 8080)), ssl_context='adhoc')
