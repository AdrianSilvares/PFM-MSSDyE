# Copyright (c) Microsoft. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for
# full license information.

import json
import time
import os
import sys
import asyncio
from six.moves import input
import threading
from azure.iot.device.aio import IoTHubModuleClient

async def main():
    try:
        if not sys.version >= "3.5.3":
            raise Exception( "The sample requires python 3.5.3+. Current version of Python: %s" % sys.version )
        print ( "IoT Hub Client for Python" )

        # The client object is used to interact with your Azure IoT hub.
        module_client = IoTHubModuleClient.create_from_edge_environment()

        # connect the client.
        await module_client.connect()

        # define behavior for receiving an input message on input1
        async def receive_data(module_client):
            while True:
                try:
                    input_message = await module_client.receive_message_on_input("data_input")  # blocking call
                    message = input_message.data
                    size = len(message)
                    message_text = message.decode('utf-8')
                    print ( "    Data: <<<%s>>> & Size=%d" % (message_text, size) )
                    custom_properties = input_message.custom_properties
                    print ( "    Properties: %s" % custom_properties )
                    await module_client.send_message_to_output(input_message, "data_output")
                except Exception as ex:
                    print ( "Unexpected error in stram analytics module: %s" % ex )

        def stdin_listener():
            while True:
                try:
                    selection = input("")
                    if selection == "Q" or selection == "q":
                        print("Quitting...")
                        break
                except:
                    time.sleep(30)

        # Schedule task for C2D Listener
        listeners = asyncio.gather(receive_data(module_client))

        loop = asyncio.get_event_loop()
        user_finished = loop.run_in_executor(None, stdin_listener)

        await user_finished

        # Cancel listening
        listeners.cancel()

        # Finally, disconnect
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