namespace py baa_messages.messages.sensor.camera
namespace cpp baa_messages.messages.sensor.camera
namespace java org.baa_messages.messages.sensor.camera

struct CameraReading {
    1: optional i32 frame_number,
    2: optional i64 bus_time_us,
    3: optional binary jpeg_image
}

struct CameraSetting {
    1: optional double frame_rate
}
