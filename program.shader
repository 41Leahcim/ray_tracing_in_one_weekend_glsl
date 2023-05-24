// Version 4.60 of GLSL, set the GLSL version at the start of every shader
#version 460

// The number of invocations per dimension per work group (at least 32, at most 64)
// z is 1 for 2-dimensional arrays, but can be higher for 3-dimensional arrays
layout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;

// A descriptor of an image2D with the name img, which has 4 channels of 8 bits per pixel
// Bound as the first binding of the first descriptor set
layout(set = 0, binding = 0, rgba8) uniform writeonly image2D img;

// Main function
void main(){
    // Normalize the coordinates
    vec2 image_size = vec2(imageSize(img));

    float red = gl_GlobalInvocationID.x / (image_size.x - 1);
    float green = gl_GlobalInvocationID.y / (image_size.y - 1);
    float blue = 0.25;

    // The closer c is to the set, the higher i will be, so use i for the current pixel
    vec4 to_write = vec4(red, green, blue, 1.0);

    // Write to_write to the pixel with imageStore, to make sure correct type is written to the pixel
    imageStore(img, ivec2(gl_GlobalInvocationID.xy), to_write);
}