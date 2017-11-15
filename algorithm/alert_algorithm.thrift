include "gross_counts_algorithm.thrift"
include "kedge_algorithm.thrift"
include "ssc_algorithm.thrift"
include "pcs_algorithm.thrift"

namespace py baa_messages.messages.algorithm.alert
namespace cpp baa_messages.messages.algorithm.alert
namespace java org.baa_messages.messages.algorithm.alert

union AlertMetaData {
    1: gross_counts_algorithm.MetaData gross_counts,
    2: kedge_algorithm.MetaData kedge,
    3: ssc_algorithm.MetaData ssc,
    4: pcs_algorithm.MetaData pcs
}

struct AlgorithmAlert {
    1: required string algorithm_id,
    2: optional i64 start_time,
    3: optional i64 stop_time,
    4: optional AlertMetaData metadata
}

struct Reading {
    1: required string alert_id, // this MUST be a uuid or otherwise guaranteed unique id
    2: optional i64 start_time,
    3: optional i64 stop_time,
    4: optional list<AlgorithmAlert> algorithm_alerts,
    5: optional bool cooldown
}

struct Setting {
    1: optional bool disable_alerts
}
