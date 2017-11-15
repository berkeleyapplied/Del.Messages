namespace py baa_messages.messages.sensor.gps
namespace cpp baa_messages.messages.sensor.gps
namespace java org.baa_messages.messages.sensor.gps

enum GpsFixType
{
    NO_FIX,
    TIME_ONLY,
    FIX_2D,
    FIX_3D
}

struct GpsReading {
    // Position is specified using GPS convention as a geodetic position
    // on the WGS-84 ellipsoid and height above that ellipsoid
    1: optional double latitude,    // degrees
    2: optional double longitude    // degrees
    3: optional double altitude,    // meters

    // Orientation is specified using the aerospace convention as the rotation 
    // from the vehicle frame to the the local NED (north/east/down) frame.
    //
    // The vehicle frame is the right-handed coordinate frame where the X axis 
    // points towards the front of the vehicle, the Y axis points to the right 
    // (starboard/passenger-side), and Z points down.
    //
    // The local NED frame is the right-handed coordinate frame where the 
    // origin is the current position and thedb X axis points north, Y axis 
    // points east, and Z axis points down.
    // 
    // In this setup:
    // a 90 degree heading points east,
    // a positive roll is to the right (driver's perspective)
    // a positive pitch is upwards (driver's perspective)
    //
    4: optional double heading,
    5: optional double pitch,
    6: optional double roll,

    7: optional i64 timestamp_us,   // UNIX epoch time in microseconds, as provided by the GPS

    8: optional i32 num_satellites,
    9: optional GpsFixType gps_fix,     // GPS fix status

    // Estimated position error in the local NED frame
    10: optional double position_error_x; // meters
    11: optional double position_error_y; // meters
    12: optional double position_error_z; // meters
    13: optional double position_error;  // meters

    // Estimated velocity error in the local NED frame
    14: optional double velocity_error_x; // meters per second
    15: optional double velocity_error_y; // meters per second
    16: optional double velocity_error_z; // meters per second
    17: optional double speed_error;  // meters per second

    // Estimated orientation error in the local NED frame
    18: optional double pitch_error;   // degrees
    19: optional double roll_error;    // degrees
    20: optional double heading_error; // degrees

    // Estimated time error
    21: optional i64 time_error; // nanoseconds
}

struct GpsSetting {
    1: optional double poll_frequency
    2: optional double null_value
}
