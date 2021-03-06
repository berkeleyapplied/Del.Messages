namespace py baa_messages.messages.sensor.neutron
namespace cpp baa_messages.messages.sensor.neutron
namespace java org.baa_messages.messages.sensor.neutron

struct NeutronReading {
    1: optional double counts,
    2: optional i32 num_channels,
    3: optional map<i32,i32> adc_channel_counts,
    4: optional map<double,double> channel_energies,
    5: optional i64 start_time,
    6: optional double duration,
    7: optional double live_time,
    8: optional string acquisition_uuid
}

struct NeutronSetting {
    1: optional double sample_frequency,
    2: optional double voltage
}
