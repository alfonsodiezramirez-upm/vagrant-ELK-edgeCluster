import json
import random
import time
import paho.mqtt.client as mqtt
import uuid
from datetime import datetime
import csv

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
#Bucle recorriendo el fichero para leer los datos del csv, variandolos y enviadolos a MQTT
with open("./weather_madrid_LEMD_1997_2015.csv", "r") as csv_file:
    reader = csv.reader(csv_file)
    for row in reader:
        datetime_object = datetime.strptime(row[0], '%Y-%m-%d')
        tempModification = random.randint(-5, 5)
        humModification = random.randint(-10, 10)
        windModification = random.randint(-10, 10)
        message = {
            "deviceId": str(deviceId),
            "maxTemperature": int(row[1])+tempModification,
            "meanTemperature":int(row[2])+tempModification,
            "minTemperature":int(row[3])+tempModification,
            "maxHumidity":max(0,min(100,int(row[7])+humModification)),
            "meanHumidity":max(0,min(100,int(row[8])+humModification)),
            "minHumidity":max(0,min(100,int(row[9])+humModification)),
            "maxWind":max(0,int(row[16])+windModification),
            "meanWind":max(0,int(row[17])+windModification),
            "isEnable": 1,
            "timestamp": datetime_object.strftime("%Y-%m-%dT%H:%M:%SZ")
        }  

        # Convertir el diccionario a formato JSON
        message_json = json.dumps(message)
        # Conectamos al broker MQTT con tiempo de conexión de 30 segundos
        client.connect(broker, port, keepalive=60)

        # Publicamos el mensaje en el topic MQTT
        client.publish(topic, message_json)
        print(message_json + " on topic "+ topic)
        # Esperamos 60 segundos para no bombardear al broker
        time.sleep(10)
    
