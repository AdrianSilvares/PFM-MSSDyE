resource "azurerm_stream_analytics_job" "stream_analytics" {
  name                                     = "${var.project_name}-stream-analytics"
  location                                 = data.azurerm_resource_group.rg.location
  resource_group_name                      = data.azurerm_resource_group.rg.name
  compatibility_level                      = "1.0"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3

  tags = var.tags

  transformation_query = <<QUERY
SELECT bateria, temperatura, humedad, latitud, longitud, EventEnqueuedUtcTime as time
INTO powerbi1
FROM iothub TIMESTAMP BY EventEnqueuedUtcTime
WHERE IoTHub.IoTHub.ConnectionDeviceId='iotedge1';

SELECT bateria, temperatura, humedad, latitud, longitud, EventEnqueuedUtcTime as time
INTO powerbi2
FROM iothub TIMESTAMP BY EventEnqueuedUtcTime
WHERE IoTHub.IoTHub.ConnectionDeviceId='iotedge2';

SELECT bateria, temperatura, humedad, latitud, longitud, EventEnqueuedUtcTime as time
INTO powerbi3
FROM iothub TIMESTAMP BY EventEnqueuedUtcTime
WHERE IoTHub.IoTHub.ConnectionDeviceId='iotedge3';
  QUERY
}

