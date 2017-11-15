include "common.thrift"
namespace py baa_messages.messages.algorithm.ssc

//Create enumeration for detector_elements and ssc_energy_bins

struct SSCEnergyBin {
    1: required string bin_name,
    2: required double exponent
}

struct TimeWindowSpec {
    1: required double foreground,
    2: required double gap,
    3: required double background
}

struct MetaData {
    1: required TimeWindowSpec time_window,
    2: required SSCEnergyBin energy_bin,
    3: required common.DetectorElementMapping detector_mapping,
    4: optional i64 timestamp_us,
    5: optional string publish_uuid
}

struct Reading {
    1: required MetaData metadata,
    2: required double semi_norm_value
}

struct InitialLeftBinEnergiesStruct {
    1: required i32 sensor_id,
    2: required list<double> left_bin_energies
}

struct CountLowerLimitsStruct {
    1: required common.DetectorElementMapping detector_mapping,
    2: required list<i32> count_lower_limit
}

struct Setting {
    1: optional list<common.DetectorElementMapping> sum_structure,
    2: optional list<InitialLeftBinEnergiesStruct> initial_bin_structures,
    3: optional list<CountLowerLimitsStruct> count_lower_limits,
    4: optional double measurement_timeout,
    5: optional double alert_cooldown,
    6: optional double max_alert_period,
    7: optional double time_buffer_length
}
