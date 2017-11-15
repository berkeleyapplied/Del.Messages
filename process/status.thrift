include "node.thrift"
include "diagnostic.thrift"

namespace py baa_messages.messages.process.status
namespace cpp baa_messages.messages.process.status
namespace java org.baa_messages.messages.process.status

enum HealthStatus {
    INVALID = 0,
    OK,
    WARNING,
    ERROR
}

enum RunStatus {
    INVALID = 0,
    NOT_RUNNING,
    STARTUP,
    IDLE,
    RUNNING,
    SHUTDOWN
}

struct StatusMessage {
    1: optional node.NodeInfo node_info,
    2: optional list<node.NodeInfo> subnodes,
    3: optional HealthStatus health_status,
    4: optional RunStatus run_status,
    5: optional list<diagnostic.DiagnosticMessage> diagnostics
}
