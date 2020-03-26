from flask import Flask
from flask_cors import CORS
from flask_restplus import Api, Resource
from mqtt_client import MqttClient


app = Flask(__name__)
CORS(app)
api = Api(app)
swagger_api = api.namespace('homepi', description='OpenAPI for HomePi')

client = MqttClient()


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


@swagger_api.route('/switch_<string:command>')
class SwitchRoute(Resource):

    def get(self, command):
        """sets switch on or off and return success or failure"""
        print(f"Route '/switch_{command}' has been requested.")
        client.publish('zigbee2mqtt/0x84182600000d7f89/set/state', command.upper())
        return {'status': 'test successful'}


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=False)  # starts development server
