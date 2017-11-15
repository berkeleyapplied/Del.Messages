namespace py baa_messages.messages.algorithm.direction
namespace cpp baa_messages.messages.algorithm.direction
namespace java org.baa_messages.messages.algorithm.direction

struct MetaData {
    1: required string acquisition_uuid,
    2: optional i64 timestamp_us
}

struct Reading {
    1: required MetaData metadata, // retains context of the original measurement
    2: required double direction,
    3: optional i64 uncertainty,
    4: optional i64 weight,
}

struct Setting {
    1: optional i32 number_of_detectors,
    2: optional double background_buffer_length,
    3: optional double middle_buffer_length,
    4: optional double event_buffer_length,
    5: optional double snr_min,
    6: optional double snr_max,
    7: optional double gross_counts_filter_length,
    8: optional double gross_counts_delay_length
}
