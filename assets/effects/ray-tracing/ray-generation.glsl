// See: https://www.khronos.org/blog/ray-tracing-in-vulkan
#version 460 core
#extension GL_EXT_ray_tracing : enable
layout(location = 0) rayPayloadEXT vec4 payload;
layout(binding = 0, set = 0) uniform accelerationStructureEXT acc;
layout(binding = 1, rgba32f) uniform image2D img;
layout(binding = 2, set = 0) uniform rayParams
{
    vec3 rayOrigin;
    vec3 rayDir;
    uint sbtOffset;
    uint sbtStride;
    uint missIndex;
};
void main() {
    traceRayEXT(acc, gl_RayFlagsOpaqueEXT, 0xff, sbtOffset,
                sbtStride, missIndex, rayOrigin, 0.0,
                rayDir, 100.0f, 0 /* payload */);
    imageStore(img, ivec2(gl_LaunchIDEXT), payload);
}
