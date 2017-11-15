/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

include "core.thrift"
include "algorithm/gross_counts_algorithm.thrift"
include "algorithm/kedge_algorithm.thrift"
include "algorithm/ssc_algorithm.thrift"
include "algorithm/pcs_algorithm.thrift"
include "algorithm/alert_algorithm.thrift"
include "algorithm/calibration_algorithm.thrift"
include "algorithm/rebin_algorithm.thrift"
include "algorithm/direction_algorithm.thrift"
include "algorithm/source_location_algorithm.thrift"
include "algorithm/alert_resource_algorithm.thrift"
include "algorithm/neutron_algorithm.thrift"
namespace py baa_messages.messages.algorithm

union AlgorithmReading {
    1: gross_counts_algorithm.Reading gross_counts,
    2: kedge_algorithm.Reading kedge,
    3: ssc_algorithm.Reading ssc,
    4: pcs_algorithm.Reading pcs,
    5: alert_algorithm.Reading alert,
    6: calibration_algorithm.Reading calibration,
    7: rebin_algorithm.Reading rebin,
    8: direction_algorithm.Reading direction,
    9: source_location_algorithm.Reading source_location,
    10: alert_resource_algorithm.Reading alert_resource,
    11: neutron_algorithm.Reading neutron_algorithm
}

union AlgorithmSetting {
    1: gross_counts_algorithm.Setting gross_counts,
    2: kedge_algorithm.Setting kedge,
    3: ssc_algorithm.Setting ssc,
    4: pcs_algorithm.Setting pcs,
    5: alert_algorithm.Setting alert,
    6: calibration_algorithm.Setting calibration,
    7: rebin_algorithm.Setting rebin,
    8: direction_algorithm.Setting direction,
    9: source_location_algorithm.Setting source_location,
    10: neutron_algorithm.Setting neutron_algorithm
}

struct AlgorithmReport {
    1: required core.BAAContext context,
    2: list<AlgorithmReading> readings,
    3: list<AlgorithmSetting> settings
}
