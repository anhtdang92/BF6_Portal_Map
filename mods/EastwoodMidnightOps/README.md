# Eastwood Midnight Ops - Mod Documentation

## Overview

**Eastwood Midnight Ops** is a night mode mod for the Battlefield 6 Portal Eastwood map that transforms the daytime environment into a dynamic nighttime experience with weather transitions and atmospheric effects.

- **Version**: 1.0.0
- **Author**: User
- **Map**: MP_Eastwood
- **Type**: Gameplay & Environmental Mod

## Features

### Core Features
- **Dynamic Weather System**: Transitions between clear night and heavy storm conditions
- **State-Based Gameplay**: Three-phase state machine (Intro → Infiltration → Storm)
- **Atmospheric Effects**: Volumetric fog, dynamic lighting, rain particles, and wetness shaders
- **Environmental Scatter**: Procedurally generated debris and environmental objects
- **Destructible Structures**: Buildings and objects that can be destroyed with physics-based collapse

### Gameplay Phases

1. **Intro Phase** (5 seconds)
   - Cinematic camera introduction
   - Initial environment setup
   - Smooth transition to gameplay

2. **Infiltration Phase** (Main gameplay)
   - Clear night weather with low fog
   - Dim ambient lighting
   - Normal gameplay conditions
   - Transitions to Storm phase after 5 minutes or random trigger

3. **Storm Phase** (Dynamic weather)
   - Heavy storm conditions
   - High-density volumetric fog
   - Rain particle effects
   - Near-pitch black lighting
   - Maximum wetness shader effects

## Architecture

### Dual Implementation

The mod exists in two versions:

1. **TypeScript/Portal Version** (`mods/EastwoodMidnightOps/`)
   - Runtime gameplay logic for Battlefield 6 Portal
   - Compiled to JavaScript for Portal upload
   - Handles game mode events and state transitions

2. **GDScript/Godot Version** (`GodotProject/mods/EastwoodMidnightOps/`)
   - Editor-time systems for level design
   - Visual effects and environmental setup
   - Scene composition and asset management

## Components

### LevelDirector
**Location**: `GodotProject/mods/EastwoodMidnightOps/LevelDirector.gd`

The main state machine controller that orchestrates the entire mod experience.

**Responsibilities**:
- Manages state transitions (Intro → Infiltration → Storm)
- Coordinates sub-systems (weather, scatter, camera)
- Emits signals for UI and audio systems
- Controls match duration and timing

**Key Methods**:
- `_change_state(state_name: String)` - Transitions between game states
- `_register_states()` - Initializes state machine
- `_process(delta)` - Updates current state

**State Classes**:
- `StateIntro` - Handles intro camera and initial setup
- `StateInfiltration` - Main gameplay phase with clear night weather
- `StateStorm` - Heavy storm phase with weather effects

### WeatherController
**Location**: `GodotProject/mods/EastwoodMidnightOps/WeatherController.gd`

Manages all weather-related effects and transitions.

**Weather Profiles**:
- **ClearNight**: Low fog (0.01), dim lighting (0.2 energy), minimal wetness (0.1)
- **HeavyStorm**: High fog (0.15), darkness (0.0 energy), maximum wetness (1.0)

**Features**:
- Smooth tweened transitions between weather states
- Volumetric fog density and color control
- Directional light energy adjustment
- Global shader parameter management (wetness)
- Rain particle system control

**Key Methods**:
- `initialize_environment()` - Sets up initial weather state
- `transition_weather(profile_name, duration)` - Smoothly transitions between weather profiles

### ScatterGenerator
**Location**: `GodotProject/mods/EastwoodMidnightOps/ScatterGenerator.gd`

Procedurally generates environmental debris and objects across the map.

**Features**:
- MultiMesh-based instancing for performance
- Random position, rotation, and scale variation
- Configurable count and area extents
- Color variation for visual diversity
- Distance-based culling (100m visibility range)

**Configuration**:
- Default: 2000 instances
- Area: 200x200 units
- Scale range: 0.8-1.2x
- Random Y-axis rotation

### DestructibleStructure
**Location**: `GodotProject/mods/EastwoodMidnightOps/DestructibleStructure.gd`

Handles destructible buildings and objects with physics-based collapse.

**Features**:
- Health-based destruction system
- Model swapping (pristine → fractured)
- Physics impulse application on destruction
- Particle effects (dust)
- Audio feedback (collapse sounds)
- Collision management for performance

**Key Methods**:
- `apply_damage(amount)` - Reduces health and triggers collapse at 0
- `_trigger_collapse()` - Swaps models, applies physics, plays FX

### TypeScript Game Logic
**Location**: `mods/EastwoodMidnightOps/night_eastwood.ts`

Runtime gameplay scripting for Portal.

**Components**:
- `LevelDirector` class - State machine implementation
- `GameState` enum - Defines three game phases
- `OnGameModeStarted()` - Portal entry point
- `GameLoop()` - Async update loop (0.1s intervals)

**State Transitions**:
- Intro → Infiltration: After 5 seconds
- Infiltration → Storm: After 5 minutes or random trigger
- Displays messages on state changes

## File Structure

### TypeScript/Portal Files
```
mods/EastwoodMidnightOps/
├── night_eastwood.ts          # Main TypeScript logic
├── night_eastwood.js          # Compiled JavaScript (in dist/)
├── night_eastwood.spatial.json # Exported level data
├── night_eastwood_flat.spatial.json # Flat version
├── night_eastwood.tscn        # Godot scene file
├── mod.json                   # Mod metadata
├── tsconfig.json              # TypeScript configuration
└── dist/
    └── night_eastwood.js      # Compiled output
```

### GDScript/Godot Files
```
GodotProject/mods/EastwoodMidnightOps/
├── LevelDirector.gd           # Main state machine
├── WeatherController.gd        # Weather system
├── ScatterGenerator.gd        # Debris generation
├── DestructibleStructure.gd    # Destructible objects
├── test_level_director.gd     # Testing utilities
├── night_eastwood.tscn        # Scene files
├── night_eastwood_flat.tscn   # Flat scene variant
└── mod.json                   # Mod metadata
```

## State Machine Flow

```
┌─────────────┐
│   Intro     │ (5 seconds)
│  (Camera)   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│Infiltration │ (Main gameplay)
│ (Clear Night)│
└──────┬──────┘
       │ (5 min or random)
       ▼
┌─────────────┐
│   Storm     │ (Heavy weather)
│ (Heavy Rain)│
└─────────────┘
```

## Weather System Details

### Clear Night Profile
- **Fog Density**: 0.01 (subtle atmospheric haze)
- **Fog Color**: Dark blue tint (0.05, 0.05, 0.1)
- **Light Energy**: 0.2 (dim moonlight)
- **Wetness**: 0.1 (slight surface moisture)
- **Rain**: Disabled

### Heavy Storm Profile
- **Fog Density**: 0.15 (thick volumetric fog)
- **Fog Color**: Very dark (0.02, 0.02, 0.05)
- **Light Energy**: 0.0 (near darkness, relies on lightning)
- **Wetness**: 1.0 (maximum surface wetness)
- **Rain**: Enabled with full particle emission

### Transition System
- Smooth tweened transitions (default 5-10 seconds)
- Parallel property animation for all weather elements
- Global shader parameter updates for material wetness
- Particle system state management

## Usage

### In Godot Editor

1. **Open the Scene**:
   - Navigate to `GodotProject/mods/EastwoodMidnightOps/`
   - Open `night_eastwood.tscn`

2. **Configure Systems**:
   - Assign `WeatherController` to LevelDirector
   - Assign `ScatterGenerator` to LevelDirector
   - Set up intro camera reference
   - Configure weather profiles in WeatherController

3. **Edit Level**:
   - Add/modify objects in the scene
   - Set ObjIds for script references
   - Adjust weather parameters
   - Test state transitions

4. **Export**:
   - Use "Export Current Level" in BFPortal tab
   - Or use command line export script

### In Portal

1. **Compile TypeScript**:
   ```bash
   cd mods/EastwoodMidnightOps
   npx tsc
   ```

2. **Upload Files**:
   - Upload `night_eastwood.spatial.json` to Portal Web Builder (Map Rotation tab)
   - Upload `dist/night_eastwood.js` or paste TypeScript code (Rules Editor tab)

3. **Configure Experience**:
   - Set up teams and player counts
   - Configure game rules
   - Add description and thumbnail

4. **Publish**:
   - Review settings
   - Publish experience
   - Test in Battlefield 6

## Technical Details

### Performance Considerations
- MultiMesh instancing for efficient debris rendering
- Distance-based culling (100m visibility range)
- Collision optimization for destructible structures
- Physics cost management (disabled when not needed)

### Shader Integration
- Global shader parameter: `global_wetness`
- Must be configured in Project Settings → Shader Globals
- Affects material appearance based on weather state

### Portal API Usage
- `mod.Message()` - Display messages on state transitions
- `mod.Wait()` - Async delay in game loop
- `OnGameModeStarted()` - Portal entry point
- Console logging for debugging

## Customization

### Adjusting State Durations
Edit `night_eastwood.ts`:
```typescript
// Change intro duration (line 40)
if (this.matchTime > 5.0) { // Change 5.0 to desired seconds

// Change storm trigger time (line 47)
if (this.matchTime > 300.0) { // Change 300.0 to desired seconds
```

### Modifying Weather Profiles
Edit `WeatherController.gd`:
```gdscript
const PROFILES = {
    "ClearNight": {
        "fog_density": 0.01,  # Adjust fog
        "light_energy": 0.2,  # Adjust brightness
        # ... other parameters
    }
}
```

### Changing Debris Count
Edit `ScatterGenerator.gd`:
```gdscript
@export var count: int = 2000  # Change to desired count
@export var area_extents: Vector3 = Vector3(200, 0, 200)  # Change area
```

## Dependencies

- **Godot Engine**: 4.4.1
- **TypeScript**: 5.9.3
- **Portal API**: Battlefield 6 Portal SDK 1.1.2.0
- **Map**: MP_Eastwood (SouthernCalifornia theater)

## Notes

- The mod uses a hybrid approach: GDScript for editor-time effects, TypeScript for runtime gameplay
- Weather transitions are smooth and tweened for visual quality
- The state machine is extensible - additional states can be added
- All systems are modular and can be used independently
- The mod serves as both a working example and a template for other Portal experiences

## Future Enhancements

Potential improvements:
- Additional weather profiles (light rain, fog, etc.)
- More state machine phases
- Dynamic storm intensity
- Lightning effects
- Enhanced destructible object variety
- Performance optimizations for larger maps

---

**Version**: 1.0.0  
**Last Updated**: Based on SDK version 1.1.2.0  
**Compatibility**: Battlefield 6 Portal only

