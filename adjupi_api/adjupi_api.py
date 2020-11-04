from flask import Flask
from flask_cors import CORS
from flask_restplus import Api, Resource
import paho.mqtt.client as mqtt


app = Flask(__name__)
CORS(app)
api = Api(app)
swagger_api = api.namespace('adjupi', description='OpenAPI for Adjupi')


@swagger_api.route('/')
class MainRoute(Resource):

    def get(self):
        """returns information about the project"""
        print("Route '/' has been requested.")
        return {
            'project': 'hpi',
            'name': 'Homepi Smart-Home System',
            'version': 0.1,
            'author': 'Steffen Karcher'
        }


@swagger_api.route('/switch_<string:command>_<string:id>')
class SwitchRoute(Resource):

    def get(self, command, id):
        """sets switch on or off and return success or failure"""
        client = mqtt.Client()
        client.connect(BROKER_ADDRESS)
        print(f"Route '/switch_{command}' has been requested.")
        client.publish(f'zigbee2mqtt/{id}/set/state', command.upper())
        return {'status': 'test successful'}


if __name__ == '__main__':
    BROKER_ADDRESS = "localhost"

    app.run(host='0.0.0.0', debug=False)  # starts development server
