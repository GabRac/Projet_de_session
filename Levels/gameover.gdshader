shader_type canvas_item;

// Uniforms
uniform float time : hint_range(0, 10) = 0.0; // Time parameter for animation
uniform float highlight_speed : hint_range(0, 1) = 1; // Speed of the highlight animation

// Gold color
const vec3 gold_color = vec3(0.5, 0.2, 0.2);

void fragment() {
    // Calculate the distance from the current pixel to the highlight position
    float distance_to_highlight = abs(fract(UV.x - time * highlight_speed) - 0.5) * 2.0;

    // Create a smooth transition for the highlight effect
    float highlight_factor = smoothstep(0.4, 0.6, distance_to_highlight);

    // Mix the original color with the gold color based on the highlight factor
    vec4 original_color = texture(TEXTURE, UV);
    vec3 final_color = mix(original_color.rgb, gold_color, highlight_factor);

    // Set the final color
    COLOR = vec4(final_color, original_color.a);
}
