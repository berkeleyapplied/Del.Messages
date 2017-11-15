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
include "process/control.thrift"
include "process/status.thrift"
include "process/diagnostic.thrift"

namespace py baa_messages.messages.process
namespace cpp baa_messages.messages.process
namespace java org.baa_messages.messages.process

union ProcessType {
    1: control.ControlMessage control,
    2: status.StatusMessage status,
    3: diagnostic.DiagnosticMessage diagnostic
}

struct ProcessMessage {
    1: optional core.BAAContext context,
    2: optional string message_class,
    3: optional string message_key,
    4: optional ProcessType message
}
