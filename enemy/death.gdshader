shader_type canvas_item;

// Uniforms
uniform float death_progress : hint_range(0, 1) = 0.0;
uniform float particle_speed = -1.0;

void vertex() {
    // Displace the vertex based on the death progress
    VERTEX.x += sin(death_progress * PI) * particle_speed;
    VERTEX.y += cos(death_progress * PI) * particle_speed;
}

void fragment() {
    // Interpolate between the original color and a grayscale color based on death_progress
    vec4 original_color = texture(TEXTURE, UV);
    vec3 grayscale_color = vec3(0.5, 1.8, 1.11) * original_color.rgb; // Convert to grayscale
    vec3 final_color = mix(original_color.rgb, grayscale_color, death_progress);

    // Set the final color
    COLOR = vec4(final_color, original_color.a);
}
