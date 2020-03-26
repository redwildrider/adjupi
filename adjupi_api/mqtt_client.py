import paho.mqtt.client as mqtt


BROKER_ADDRESS = "localhost"


class MqttClient:
    def __init__(self):
        self.client = mqtt.Client()
        self.client.connect(BROKER_ADDRESS)

    def publish(self, topic, payload):
        self.client.publish(topic, payload)


# mosquitto_pub -m "OFF" -t 'zigbee2mqtt/0x84182600000d7f89/set/state'
# {"state":"ON","linkquality":73}
