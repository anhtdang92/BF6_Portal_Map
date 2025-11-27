class_name ScatterGenerator
extends Node3D

@export var debris_mesh_source: PackedScene # Assign a prefab that contains a MeshInstance3D
@export var count: int = 2000
@export var area_extents: Vector3 = Vector3(200, 0, 200)

func generate_debris() -> void:
	if not debris_mesh_source:
		return

	# 1. Extract the Mesh resource from the PackedScene
	var temp_instance = debris_mesh_source.instantiate()
	var source_mesh_instance = _find_mesh_instance(temp_instance)
	
	if not source_mesh_instance:
		push_error("ScatterGenerator: No MeshInstance3D found in debris prefab.")
		temp_instance.queue_free()
		return
		
	var mesh_resource = source_mesh_instance.mesh
	temp_instance.queue_free() # Cleanup temp

	# 2. Create MultiMesh
	var mm = MultiMesh.new()
	mm.transform_format = MultiMesh.TRANSFORM_3D
	mm.use_colors = true # Enable color variation
	mm.mesh = mesh_resource
	mm.instance_count = count
	
	# 3. Populate Instances
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for i in range(count):
		var pos = Vector3(
			rng.randf_range(-area_extents.x, area_extents.x),
			0, # Adjust for terrain height here using a RayCast or HeightMap
			rng.randf_range(-area_extents.z, area_extents.z)
		)
		
		var instance_basis = Basis(Vector3.UP, rng.randf() * TAU) # Random Y rotation
		var scale_val = rng.randf_range(0.8, 1.2)
		var instance_transform = Transform3D(instance_basis * scale_val, pos)
		
		mm.set_instance_transform(i, instance_transform)
		
		# Optional: Darken wet debris slightly using vertex color
		var col = Color(0.6, 0.6, 0.6) # Base grime
		mm.set_instance_color(i, col)

	# 4. Create the Node
	var mmi = MultiMeshInstance3D.new()
	mmi.multimesh = mm
	mmi.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	# Optimization: Stop rendering debris past 100 meters
	mmi.visibility_range_end = 100.0 
	add_child(mmi)

func _find_mesh_instance(node: Node) -> MeshInstance3D:
	if node is MeshInstance3D: return node
	for child in node.get_children():
		var res = _find_mesh_instance(child)
		if res: return res
	return null
