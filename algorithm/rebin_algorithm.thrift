namespace py baa_messages.messages.algorithm.rebin


struct Reading {
    1: required i32 sensor_id,
    2: optional list<double> energies,
    3: required list<double> rebinned_spectra,
    4: optional double duration,
    5: optional string calibration_uuid,
    6: optional string data_acq_uuid,
    7: optional i64 data_start_time
}

struct Setting {
    1: optional i32 sensor_id,
    2: optional list<double> desired_energies
}
