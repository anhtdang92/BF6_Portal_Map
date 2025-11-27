extends SceneTree

func _init():
	print("Starting LevelDirector Test...")
	
	# 1. Setup Mocks
	var director = LevelDirector.new()
	var weather = WeatherController.new()
	var scatter = ScatterGenerator.new()
	var camera = Camera3D.new()
	
	director.weather_controller = weather
	director.scatter_system = scatter
	director.intro_camera = camera
	
	# Add to tree to trigger _ready
	root.add_child(director)
	director.add_child(weather)
	director.add_child(scatter)
	director.add_child(camera)
	
	# 2. Verify Initial State
	await get_tree().process_frame
	if director._current_state == null:
		print("FAIL: Initial state is null")
	else:
		print("PASS: Initial state set")
		
	# 3. Test State Transition
	var signal_emitted = false
	director.match_started.connect(func(): signal_emitted = true)
	
	print("Testing transition to Infiltration...")
	director._change_state("Infiltration")
	
	if signal_emitted:
		print("PASS: match_started signal emitted")
	else:
		print("FAIL: match_started signal NOT emitted")
		
	# 4. Cleanup
	director.queue_free()
	print("Test Complete.")
	quit()
