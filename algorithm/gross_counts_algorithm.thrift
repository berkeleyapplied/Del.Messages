include "common.thrift"

namespace py baa_messages.messages.algorithm.gross_counts
namespace cpp baa_messages.messages.algorithm.gross_counts
namespace java org.baa_messages.messages.algorithm.gross_counts

struct MetaData {
    1: optional common.DetectorElementMapping detector_mapping,
    2: optional i64 timestamp_us,
    3: optional string acquisition_uuid
}

struct Setting {
    1: optional double src_time,
    2: optional double bkg_time,
    3: optional double gap_time,
}

struct Reading {
    1: required double anomaly_metric,
    2: optional MetaData metadata,
    3: optional double gross_cps,
    4: optional double bkg_cps,
    5: optional double sigma_bkg_ps,
    6: optional double bkg_acq_time,
    7: optional double fg_acq_time
}

