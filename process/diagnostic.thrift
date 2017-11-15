namespace py baa_messages.messages.process.diagnostic

enum DiagnosticCode {
    INVALID = 0,
    OK = 211,
    HARDWARE_ERROR = 401,
    PROCESS_TIMEOUT = 501,
    CONNECTION_TIMEOUT = 502
}

enum DiagnosticLevel {
    INVALID = 0,
    DEBUG = 10,
    INFO = 20,
    WARNING = 30,
    ERROR = 40,
    CRITICAL = 50
}

struct DiagnosticMessage {
    1: optional DiagnosticCode code,
    2: optional DiagnosticLevel level,
    3: optional string description
}
