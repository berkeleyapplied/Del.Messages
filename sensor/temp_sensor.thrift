
namespace py baa_messages.messages.sensor.temperature
namespace cpp baa_messages.messages.sensor

struct TemperatureReading {
    1: required double temperature
}

struct TemperatureSetting {
    1: optional double poll_frequency
    2: optional double null_value
}