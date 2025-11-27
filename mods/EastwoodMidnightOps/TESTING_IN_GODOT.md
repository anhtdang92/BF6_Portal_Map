# Testing Eastwood Midnight Ops in Godot Editor

## ✅ Yes, You Can Test in Godot!

The mod is already set up to run in the Godot editor. The GDScript version has all the visual effects and systems that you can test and preview.

## 🚀 Quick Start

### Method 1: Run the Scene Directly (Easiest)

1. **Open Godot Editor**
   - Launch `Godot_v4.4.1-stable_win64.exe`
   - Open the project: `GodotProject/` folder

2. **Open the Mod Scene**
   - In Godot, go to **Scene → Open Scene**
   - Navigate to: `mods/EastwoodMidnightOps/night_eastwood.tscn`
   - Or double-click the file in the FileSystem panel

3. **Press F5 or Click Play**
   - The scene will run with all systems active:
     - ✅ State machine (Intro → Infiltration → Storm)
     - ✅ Weather system (fog, lighting, rain)
     - ✅ Scatter generator (debris)
     - ✅ Camera transitions

4. **Watch the Console**
   - You'll see messages like:
     - `[color=green]Initializing Eastwood Systems...[/color]`
     - `[b]Transitioning to State:[/b] Intro`
     - State transitions as they happen

### Method 2: Set as Main Scene (For Quick Testing)

1. **Set Main Scene**
   - Right-click `mods/EastwoodMidnightOps/night_eastwood.tscn` in FileSystem
   - Select **"Set as Main Scene"**
   - Now pressing F5 will always run this scene

2. **Run Project**
   - Press **F5** or click the **Play** button
   - The mod will start automatically

## 🎮 What You'll See

### Visual Effects
- **Night Sky**: Dark blue sky with dim lighting
- **Volumetric Fog**: Atmospheric fog (starts at 0.01 density)
- **Dynamic Lighting**: Dim directional light (0.2 energy)
- **Rain Particles**: Will activate during Storm phase
- **Scattered Debris**: Procedurally generated objects

### State Transitions
1. **Intro Phase** (6 seconds)
   - Camera animation
   - Transitions automatically to Infiltration

2. **Infiltration Phase** (Main gameplay)
   - Clear night weather
   - Low fog, dim lighting
   - Will transition to Storm after random trigger or time

3. **Storm Phase**
   - Heavy fog (0.15 density)
   - Rain particles activate
   - Near darkness (0.0 light energy)
   - Maximum wetness shader effects

## 🔍 Testing Features

### View State Machine in Action
- Open the **Output** panel (bottom of screen)
- Watch for state transition messages
- See system initialization messages

### Test Weather Transitions
The weather system will automatically transition based on state, but you can also:
- Select the `WeatherController` node in the scene
- In the Inspector, you can manually trigger weather changes
- Or modify the state machine timing in `LevelDirector.gd`

### Adjust Settings
You can modify these in the Inspector when the scene is open:
- **LevelDirector**:
  - `match_duration`: Total match time
  - `weather_controller`: Reference to weather system
  - `scatter_system`: Reference to debris generator
  - `intro_camera`: Camera for intro sequence

- **WeatherController**:
  - Weather profiles (ClearNight, HeavyStorm)
  - Fog density, lighting, wetness values

- **ScatterGenerator**:
  - `count`: Number of debris objects (default: 500 in scene)
  - `area_extents`: Area size for scattering

## 🐛 Debugging

### Check Console Output
- Look for colored messages indicating state changes
- Error messages will appear in red
- System initialization messages in green

### Test Script Available
There's a test script at: `GodotProject/mods/EastwoodMidnightOps/test_level_director.gd`
- This can be used for unit testing the state machine
- Run it separately if needed

### Common Issues

**"Camera not found"**
- Make sure `intro_camera` is assigned in LevelDirector
- The scene should have a Camera3D node

**"Weather not changing"**
- Check that WeatherController has references to:
  - `world_env` (WorldEnvironment node)
  - `sun_light` (DirectionalLight3D node)
  - `rain_particles` (GPUParticles3D node)

**"No debris visible"**
- ScatterGenerator needs a `debris_mesh_source` assigned
- Check that `count` is set to a value > 0

## 📝 Differences from Portal Version

### What Works in Godot:
- ✅ Full visual effects (fog, rain, lighting)
- ✅ State machine logic
- ✅ Weather transitions
- ✅ Scatter system
- ✅ Camera animations
- ✅ All GDScript systems

### What's Portal-Only:
- ❌ Actual gameplay (players, weapons, etc.)
- ❌ Portal API calls (mod.Message, mod.Wait, etc.)
- ❌ Multiplayer functionality

The Godot version is for **visual preview and testing** of the environmental effects and state machine logic. The actual gameplay happens in Battlefield 6 Portal.

## 🎯 Tips

1. **Use the Scene Tree** to navigate and see all nodes
2. **Check the Inspector** to see current state values
3. **Watch the Output panel** for state transition messages
4. **Adjust timing** in LevelDirector if transitions are too fast/slow
5. **Test weather manually** by selecting WeatherController and calling methods

## 🔄 Export After Testing

After testing and making changes in Godot:
1. Save your scene (Ctrl+S)
2. Use **BFPortal → Export Current Level** to create new spatial JSON
3. Upload the new spatial JSON to Portal

---

**Note**: The Godot version uses GDScript for visual effects, while Portal uses TypeScript for gameplay. Both work together - visual effects are exported in the spatial JSON, gameplay logic runs from the JavaScript file.

