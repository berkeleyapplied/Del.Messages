include "common.thrift"
namespace py baa_messages.messages.algorithm.pcs

struct MetaData {
    1: required string isotope,
    2: required common.DetectorElementMapping detector_mapping,
    3: optional i64 timestamp_us,
    4: optional string acquisition_uuid
}

struct Reading {
    1: required MetaData metadata,
    2: required double detection_confidence
}

struct Setting {
    1: optional i32 n_isotopes,
    2: optional i32 n_detectors,
    3: optional list<string> isotope_names,
    4: optional list<string> isotope_alarms
}
