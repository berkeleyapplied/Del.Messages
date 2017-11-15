include "node.thrift"
include "status.thrift"

namespace py baa_messages.messages.process.control
namespace cpp baa_messages.messages.process.control
namespace java org.baa_messages.messages.process.control

enum Command {
    INVALID = 0,
    SPAWN,
    START,
    PAUSE,
    STOP,
    KILL,
    RESET,
    STATUS,
    SUBSCRIBE
}

enum ResultCode {
    INVALID = 0,
    SUCCESS = 211,
    NOT_FOUND,
    NOT_READY,
    TIMEOUT,
    UNKNOWN_COMMAND
}

struct ControlMessage {
    1: optional node.NodeInfo node_info,
    2: optional Command command,
    3: optional ResultCode result_code,
    4: optional status.StatusMessage status
}
