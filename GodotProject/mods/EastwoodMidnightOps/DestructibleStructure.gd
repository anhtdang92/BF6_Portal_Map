class_name DestructibleStructure
extends Node3D

@export var health: float = 1000.0
@export var pristine_model: Node3D
@export var fractured_model: Node3D
@export var collapse_sfx: AudioStreamPlayer3D
@export var dust_particles: GPUParticles3D

var _is_destroyed: bool = false

func _ready() -> void:
	if fractured_model:
		fractured_model.hide()
		# Disable collision on fractured parts initially to save physics cost
		_set_collision_enabled(fractured_model, false)

func apply_damage(amount: float) -> void:
	if _is_destroyed: return
	
	health -= amount
	if health <= 0:
		_trigger_collapse()

func _trigger_collapse() -> void:
	_is_destroyed = true
	
	# 1. Swap Models
	if pristine_model:
		pristine_model.hide()
		pristine_model.process_mode = Node.PROCESS_MODE_DISABLED # Disable logic
	
	if fractured_model:
		fractured_model.show()
		_set_collision_enabled(fractured_model, true)
		
		# 2. Apply Impulse (Explosive force)
		# Assumes fractured_model contains RigidBody3D children
		for child in fractured_model.get_children():
			if child is RigidBody3D:
				# Push pieces outward from center
				var dir = (child.global_position - global_position).normalized()
				child.apply_central_impulse(dir * 15.0)
	
	# 3. FX
	if dust_particles: dust_particles.emitting = true
	if collapse_sfx: collapse_sfx.play()
	
	# 4. Bake Navigation (Optional, expensive)
	# NavigationServer3D.map_changed(get_world_3d().navigation_map)

func _set_collision_enabled(root: Node, enabled: bool) -> void:
	for child in root.get_children():
		if child is CollisionShape3D or child is CollisionPolygon3D:
			child.disabled = !enabled
		_set_collision_enabled(child, enabled)
