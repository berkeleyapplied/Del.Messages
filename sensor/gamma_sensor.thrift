namespace py baa_messages.messages.sensor.gamma
namespace cpp baa_messages.messages.sensor.gamma
namespace java org.baa_messages.messages.sensor.gamma

struct GammaReading {
    1: required i64 start_time,
    2: required double duration,
    3: required double live_time,
    4: required i32 num_channels,
    5: required map<i32,i32> adc_channel_counts,
    6: optional map<double,double> channel_energies,
    7: optional double gross_counts,
    8: optional string acquisition_uuid
}

struct GammaSetting {
    1: optional double sample_frequency,
    2: optional double fine_gain,
    3: optional double high_voltage,
    4: optional double lld,
    5: optional double uld
}
