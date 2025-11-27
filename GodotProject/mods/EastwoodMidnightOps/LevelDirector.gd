class_name LevelDirector
extends Node3D

# ═══════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════
@export_group("Systems")
@export var weather_controller: WeatherController
@export var scatter_system: ScatterGenerator
@export var intro_camera: Camera3D

@export_group("Game Loop")
@export var match_duration: float = 1200.0 # 20 minutes

# Signals for global listeners (UI, Audio System)
signal match_started
signal storm_warning_issued
signal match_ended(final_score: Dictionary)

# State Machine Variables
var _current_state: LevelState
var _states: Dictionary = {}

func _ready() -> void:
	print_rich("[color=green]Initializing Eastwood Systems...[/color]")
	
	# 1. Initialize Sub-Systems
	if weather_controller: weather_controller.initialize_environment()
	if scatter_system: scatter_system.generate_debris()
	
	# 2. Build State Map
	_register_states()
	
	# 3. Start the Machine
	_change_state("Intro")

func _process(delta: float) -> void:
	if _current_state:
		_current_state.update(delta)

# ═══════════════════════════════════════════════════════════
# STATE MACHINE LOGIC
# ═══════════════════════════════════════════════════════════
func _register_states() -> void:
	_states["Intro"] = StateIntro.new(self)
	_states["Infiltration"] = StateInfiltration.new(self)
	_states["Storm"] = StateStorm.new(self)
	# Added missing state class if needed, or just use these three for now

func _change_state(state_name: String) -> void:
	if not _states.has(state_name):
		push_error("State not found: %s" % state_name)
		return
		
	if _current_state:
		_current_state.exit()
	
	_current_state = _states[state_name]
	print_rich("[b]Transitioning to State:[/b] %s" % state_name)
	_current_state.enter()

# ═══════════════════════════════════════════════════════════
# BASE STATE CLASS
# ═══════════════════════════════════════════════════════════
class LevelState:
	var director: LevelDirector
	func _init(d: LevelDirector): director = d
	func enter(): pass
	func exit(): pass
	func update(_delta: float): pass

# ═══════════════════════════════════════════════════════════
# CONCRETE STATES
# ═══════════════════════════════════════════════════════════
class StateIntro extends LevelState:
	func enter():
		# Ensure camera is positioned correctly
		if director.intro_camera:
			director.intro_camera.current = true
			# Map center is around (-145, 230, -35) based on HQ positions
			# Position camera at an angle (not directly above) to avoid colinear warning
			var map_center = Vector3(-145, 230, -35)
			# Position camera high up, slightly offset to avoid colinear vectors
			var camera_pos = Vector3(-145, 450, 50)  # High up, offset forward
			
			# Set camera position and make it look at the map
			# Use RIGHT as up vector (perpendicular to vertical look direction)
			director.intro_camera.position = camera_pos
			director.intro_camera.look_at(map_center, Vector3.RIGHT)
			
		# Immediately transition to gameplay
		director._change_state("Infiltration")

class StateInfiltration extends LevelState:
	func enter():
		director.match_started.emit()
		# Set calm night weather
		if director.weather_controller:
			director.weather_controller.transition_weather("ClearNight", 5.0)
		
	func update(delta):
		# Trigger the storm if a random condition is met or time passes
		if randf() < 0.0001: # Rare random trigger
			director._change_state("Storm")

class StateStorm extends LevelState:
	func enter():
		director.storm_warning_issued.emit()
		if director.weather_controller:
			director.weather_controller.transition_weather("HeavyStorm", 10.0)
		# Global wetness is handled by WeatherController
		# No need to set it directly here
