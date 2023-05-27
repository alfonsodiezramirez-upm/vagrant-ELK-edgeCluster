import paho.mqtt.client as mqtt

# MQTT broker details
broker = "192.168.22.20"  # MQTT broker address
port = 1883  # MQTT broker port
topic = "dispositivos/#"  # Topic to subscribe to

# Callback function that is called when the client connects to the MQTT broker
def on_connect(client, userdata, flags, rc):
    print("Connected to MQTT broker")
    # Subscribe to the topic after connection is established
    client.subscribe(topic)

# Callback function that is called when a message is received
def on_message(client, userdata, msg):
    print("Received message: " + msg.payload.decode())

# Create an MQTT client instance
client = mqtt.Client()

# Set up the callback functions
client.on_connect = on_connect
client.on_message = on_message

# Connect to the MQTT broker
client.connect(broker, port, keepalive=60)

# Start the network loop to process MQTT messages
client.loop_start()

# Keep the program running to receive messages
while True:
    pass