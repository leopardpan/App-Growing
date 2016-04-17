from flask import Flask
from flask.ext.restful import reqparse, abort, Api, Resource

app = Flask(__name__)
api = Api(app)

class TodoList(Resource):
    def get(self):
        file_object = open('test.json')
        return file_object.read( )

api.add_resource(TodoList, '/todos')

if __name__ == '__main__':
    app.run(host = '0.0.0.0', port = 4000, debug = True)
