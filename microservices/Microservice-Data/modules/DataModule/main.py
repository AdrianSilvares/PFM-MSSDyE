# Copyright (c) Microsoft. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for
# full license information.

import json
import random
import time
import os
import uuid
import sys
import asyncio
from six.moves import input
import threading
from azure.iot.device.aio import IoTHubModuleClient
from azure.iot.device import Message

BATTERY_CAPACITY = 100

async def main():
    try:
        if not sys.version >= "3.5.3":
            raise Exception( "The sample requires python 3.5.3+. Current version of Python: %s" % sys.version )
        print ( "IoT Hub Client for Python" )

        # The client object is used to interact with your Azure IoT hub.
        module_client = IoTHubModuleClient.create_from_edge_environment()

        # connect the client.
        await module_client.connect()

        async def send_data():
            global BATTERY_CAPACITY
            while BATTERY_CAPACITY > 0:

                mensaje = {
                "bateria": BATTERY_CAPACITY,
                "temperatura": random.randint(35, 100), 
                "humedad": random.randint(0, 100),
                "latitud": round(random.uniform(40.400000, 40.450000), 6),
                "longitud": round(random.uniform(-3.800000, -3.700000), 6)
                }

                BATTERY_CAPACITY -= 1

                msg = Message(json.dumps(mensaje))
                msg.message_id = uuid.uuid4()
                msg.correlation_id = "tfmId"

                if mensaje.get("temperatura") > 95:
                    msg.custom_properties["fire"] = "yes"
                else: 
                    msg.custom_properties["fire"] = "no"
                    
                print("Sending data: ", msg)
                await module_client.send_message_to_output(msg, "data_output")
                time.sleep(0.5)

        await asyncio.gather(send_data())

        await module_client.disconnect()

    except Exception as e:
        print ( "Unexpected error %s " % e )
        raise

if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
    loop.close()

    # If using Python 3.7 or above, you can use following code instead:
    # asyncio.run(main())