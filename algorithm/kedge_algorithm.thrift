include "common.thrift"
namespace py baa_messages.messages.algorithm.kedge

struct MetaData {
    1: required i32 sensor_id,
    2: optional i64 timestamp_us,
    3: optional string acquisition_uuid
}

struct Reading {
    1: required MetaData metadata, // this is the context of the original measurement
    2: required double k_sigma,
    3: required double k_edge_energy
}

struct Setting {
    1: optional double src_filter_time,
    2: optional double bkg_filter_time,
    3: optional double gap_time,
    4: optional i32 array_length,
    5: optional i32 lld,
    6: optional double snr_threshold
}
