include "common.thrift"

namespace py baa_messages.messages.algorithm.alert_resource
namespace cpp baa_messages.messages.algorithm.alert_resource
namespace java org.baa_messages.messages.algorithm.alert_resource

enum ResourceType {
    mp4_thumb,
    gif_animated,
    color_lidar,
    alert_package,
    kml,
    n42,
    potree,
    mp4_thumb_front,
    mp4_thumb_back,
    mp4_thumb_left,
    mp4_thumb_right,
    alert_detail_synced,
    alert_detail_no_sync,
    auto_hires_snapshot
}

struct MP4MetaData {
    1: optional i64 start_time,
    2: optional i64 stop_time,
    3: optional i64 duration,
    4: optional i64 number_of_frames,
    5: optional i64 frames_per_second,
    6: optional list<i64> frame_times,
    7: optional string codec
}

struct GIFMetaData {
    1: optional i64 start_time,
    2: optional i64 stop_time,
    3: optional i64 duration,
    4: optional i64 number_of_frames,
    5: optional i64 frames_per_second,
    6: optional string camera
}

union MetaData {
    1: MP4MetaData mp4_thumb,
    2: GIFMetaData gif_animated
}

struct Reading {
    1: optional MetaData metadata,
    2: optional string alert_id,
    3: optional string resource_location,
    4: optional ResourceType resource_type
}
