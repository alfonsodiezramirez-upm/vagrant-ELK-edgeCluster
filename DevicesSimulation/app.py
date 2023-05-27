import json
import random
import time
import paho.mqtt.client as mqtt
import uuid
from datetime import datetime

#Generamos un id único, basado en uuid
deviceId = uuid.uuid4()
# Configuración del cliente MQTT
broker = "192.168.22.20"  # Dirección del broker MQTT
port = 1883  # Puerto del broker MQTT
topic = "dispositivos/"+str(deviceId)  # Topic MQTT al que se enviará el mensaje, generamos una jerarquia para mejorar el tratamiento

# Callback que se ejecuta al conectarse al broker MQTT
def on_connect(client, userdata, flags, rc):
    print("Conectado al broker MQTT")
    # Suscribirse al topic después de la conexión
    client.subscribe(topic)

# Callback que se ejecuta al publicar un mensaje MQTT
def on_publish(client, userdata, mid):
    print("Mensaje publicado con éxito")

# Creamos la instancia de MQTT
client = mqtt.Client()

# Configuramos los callbacks
client.on_connect = on_connect
client.on_publish = on_publish
#Bucle infinito para enviar los mensajes de forma ilimitada
while True:
    # Generar un diccionario con múltiples campos que simulen ser un dispositivo
    now = datetime.now()
    message = {
        "deviceId": str(deviceId),
        "temperature": random.randint(1, 100),
        "isEnable": random.uniform(0, 1),
        "timestamp": now.strftime("%Y-%m-%dT%H:%M:%S.%fZ")
    }
    # Convertir el diccionario a formato JSON
    message_json = json.dumps(message)
    # Conectamos al broker MQTT con tiempo de conexión de 30 segundos
    client.connect(broker, port, keepalive=60)

    # Publicamos el mensaje en el topic MQTT
    client.publish(topic, message_json)
    print(message_json + " on topic "+ topic)
    # Esperamos 60 segundos para no bombardear al broker
    time.sleep(60)
    
