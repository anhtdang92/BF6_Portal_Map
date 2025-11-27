# Upload Status - Eastwood Midnight Ops

## ✅ READY TO UPLOAD

### 1. TypeScript/JavaScript File
**File**: `dist/night_eastwood.js`  
**Status**: ✅ **READY**  
**Location**: `mods/EastwoodMidnightOps/dist/night_eastwood.js`

This is the compiled JavaScript file that contains the gameplay logic:
- State machine (Intro → Infiltration → Storm)
- Game loop with async updates
- Portal entry point (`OnGameModeStarted`)
- Message displays on state transitions

**Upload this to Portal's Rules Editor/Script tab**

---

### 2. Spatial JSON File
**File**: `night_eastwood_flat.spatial.json`  
**Status**: ✅ **READY** (Has content - 957 lines)  
**Location**: `mods/EastwoodMidnightOps/night_eastwood_flat.spatial.json`

This file contains:
- Portal_Dynamic objects (HQs, spawn points, etc.)
- Static objects (terrain, assets)
- Level geometry and layout

**Upload this to Portal's Map Rotation tab**

---

## 📋 Upload Instructions

### Step 1: Upload Spatial JSON (Level Data)
1. Go to [portal.battlefield.com](https://portal.battlefield.com)
2. Create a new experience or edit existing one
3. Navigate to **Map Rotation** tab
4. Click the upload icon
5. Select: `mods/EastwoodMidnightOps/night_eastwood_flat.spatial.json`

### Step 2: Upload JavaScript (Gameplay Logic)
1. In the same experience, go to **Rules Editor** or **Script** tab
2. Either:
   - **Option A**: Upload the file `mods/EastwoodMidnightOps/dist/night_eastwood.js`
   - **Option B**: Copy and paste the TypeScript code from `mods/EastwoodMidnightOps/night_eastwood.ts` (Portal will compile it)

### Step 3: Configure Experience
- Set up teams, player counts
- Configure game rules
- Add name, description, thumbnail
- **Important**: Make sure you're using the **MP_Eastwood** base map

### Step 4: Publish
- Review all settings
- Click "Publish"
- Test in Battlefield 6

---

## 📝 Notes

- The TypeScript file (`night_eastwood.ts`) is functional but basic - it only handles state transitions and messages
- Weather effects (fog, rain, lighting) are NOT controlled by the TypeScript - they need to be baked into the level during export from Godot
- The current spatial JSON may not have weather effects - you may need to export a new one from Godot with the weather system configured
- The mod.json file is for reference only - Portal doesn't use it directly

---

## ⚠️ Important

**Current Limitation**: The TypeScript code has comments indicating weather control may not be available via Portal API. The weather effects (fog, rain, lighting) that exist in the GDScript version need to be exported from Godot into the spatial JSON file.

If you want the full weather effects, you'll need to:
1. Open the level in Godot (`GodotProject/mods/EastwoodMidnightOps/night_eastwood.tscn`)
2. Ensure WeatherController is configured
3. Export the level again using the BFPortal export tool
4. Use the newly exported spatial JSON file

---

**Files Ready**: ✅ 2 files ready to upload
- `dist/night_eastwood.js` - Gameplay script
- `night_eastwood_flat.spatial.json` - Level data

