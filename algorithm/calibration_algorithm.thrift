namespace py baa_messages.messages.algorithm.calibration


struct Characterization {
    1: optional list<double> channel_peaks_fit,
    2: optional list<double> channel_cal_uncertainty,
    3: optional list<double> energy_fit,
    4: optional double reference_channel,
    5: optional double reference_energy,
    6: optional list<double> resolution_coefficients
}


struct Reading {
    1: required i32 sensor_id,
    2: required string status,
    3: required double start_time,
    4: required double end_time,
    5: optional double reference_energy,
    6: optional double reference_channel,
    7: optional double reference_channel_uncertainty,
    8: optional list<double> bin_energies,
    9: optional list<i32> sum_spectrum,
    10: optional double integration_time,
    11: required string calibration_uuid
}

struct Setting {
    1: optional i32 sensor_id,
    2: optional list<double> initial_bin_energies,
    3: optional Characterization characterization,
    4: optional double reference_channel,
    5: optional double nominal_range,
    6: optional double integration_time_limit,
    7: optional list<i32> peak_chan_bounds,
    8: optional list<i32> bad_peak_chan_bounds,
    9: optional list<i32> count_range,
    10: optional list<double> width_bounds,
    11: optional list<double> bad_width_bounds,
    12: optional list<double> peak_size_bounds,
    13: optional double reference_energy,
    14: optional double message_age,
    16: optional list<double> init_bin_energies
}

