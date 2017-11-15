include "common.thrift"
namespace py baa_messages.messages.algorithm.source_location

struct MetaData {
    1: optional string alert_uuid,
    2: optional i64 alert_start_time,
    3: optional i64 alert_stop_time,
    4: optional bool cooldown
    5: optional string PCS1_isotope,
    6: optional string PCS2_isotope,
    7: optional string PCS3_isotope
}

struct Reading {
    1: optional MetaData metadata,
    2: optional double source_latitude,
    3: optional double source_lat_uncertainty,
    4: optional double source_longitude,
    5: optional double source_long_uncertainty
}

struct Setting {
    1: optional i32 n_detectors
}

