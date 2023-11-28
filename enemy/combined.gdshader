shader_type canvas_item;

// Uniforms from Shader 1
uniform vec4 flash_color : source_color = vec4(0.0);
uniform float flash_modifier : hint_range(0.0, 1.0) = 1.0;

// Uniforms from Shader 2
uniform float death_progress : hint_range(0, 1) = 0.0;
uniform float particle_speed = -1.0;

void vertex() {
    // Displace the vertex based on the death progress
    VERTEX.x += sin(death_progress * PI) * particle_speed;
    VERTEX.y += cos(death_progress * PI) * particle_speed;
}

void fragment() {
    // Fragment code from Shader 1
    vec4 color = texture(TEXTURE, UV);
    color.rgb = mix(color.rgb, flash_color.rgb, flash_modifier);
	color.rgb += flash_color.rgb * flash_modifier;

    // Interpolate between the original color and a grayscale color based on death_progress
    vec3 grayscale_color = vec3(0.5, 1.8, 1.11) * color.rgb; // Convert to grayscale
    vec3 final_color = mix(color.rgb, grayscale_color, death_progress);

    // Set the final color
    COLOR = vec4(final_color, color.a);
}
