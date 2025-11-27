class_name WeatherController
extends Node

@export_group("Environmental Nodes")
@export var world_env: WorldEnvironment
@export var sun_light: DirectionalLight3D
@export var rain_particles: GPUParticles3D

# Settings for different weather profiles
const PROFILES = {
	"ClearNight": {
		"fog_density": 0.01,
		"fog_albedo": Color(0.05, 0.05, 0.1),
		"light_energy": 0.2,
		"wetness": 0.1
	},
	"HeavyStorm": {
		"fog_density": 0.15, # High density for volumetric obstruction
		"fog_albedo": Color(0.02, 0.02, 0.05),
		"light_energy": 0.0, # Almost pitch black, relies on lightning
		"wetness": 1.0
	}
}

func initialize_environment() -> void:
	# Ensure Global Shader Parameter exists for all materials
	# (You must add 'global_wetness' in Project Settings -> Shader Globals first!)
	# Use call_deferred to avoid runtime errors
	call_deferred("_set_global_wetness", 0.0)

func transition_weather(profile_name: String, duration: float) -> void:
	if not PROFILES.has(profile_name):
		push_error("Weather profile not found: %s" % profile_name)
		return

	var target = PROFILES[profile_name]
	var tween = create_tween().set_parallel(true)
	
	# Tween Volumetric Fog
	if world_env and world_env.environment:
		tween.tween_property(world_env.environment, "volumetric_fog_density", target.fog_density, duration)
		tween.tween_property(world_env.environment, "volumetric_fog_albedo", target.fog_albedo, duration)
	
	# Tween Light
	if sun_light:
		tween.tween_property(sun_light, "light_energy", target.light_energy, duration)
	
	# Tween Global Wetness (Custom method needed for shader params)
	tween.tween_method(_set_global_wetness, _get_current_wetness(), target.wetness, duration)
	
	# Handle Rain Particles
	if rain_particles:
		if profile_name == "HeavyStorm":
			rain_particles.emitting = true
			rain_particles.amount_ratio = 1.0
		else:
			rain_particles.emitting = false

func _set_global_wetness(value: float) -> void:
	# Only set shader parameter if in editor, otherwise skip to avoid performance issues
	# In exported/runtime builds, shader parameters should be set via materials
	if Engine.is_editor_hint():
		RenderingServer.global_shader_parameter_set("global_wetness", value)
	else:
		# In runtime, we can't safely set global shader parameters
		# This would need to be handled via material uniforms instead
		# For now, we'll skip this in runtime builds
		pass

func _get_current_wetness() -> float:
	# Only get shader parameter if in editor
	if Engine.is_editor_hint():
		var val = RenderingServer.global_shader_parameter_get("global_wetness")
		if val == null:
			return 0.0
		return val as float
	else:
		# In runtime, return a default value
		return 0.0
