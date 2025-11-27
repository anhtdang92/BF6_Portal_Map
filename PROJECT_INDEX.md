# Project Index

## Overview
This is the Battlefield 6 Portal SDK, based on the Godot Engine (v4.4.1). It provides tools and a runtime environment for creating custom experiences (mods) for Battlefield 6.

## Directory Structure

### Root
- **.git/**: Git repository metadata.
- **FbExportData/**: Export data related to the Frostbite engine.
- **GodotProject/**: The main Godot project directory. Open this with the provided Godot executable.
    - **addons/**: Godot addons.
    - **levels/**: Level data.
    - **mods/**: Active mods in the editor.
    - **objects/**: Game objects.
    - **raw/**: Raw assets.
    - **scripts/**: Scripts (GDScript/C#).
    - **static/**: Static assets.
    - **project.godot**: Godot project configuration.
- **code/**: SDK core code and definitions.
    - **gdconverter/**: Asset conversion tools.
    - **gdplugins/**: Godot plugins.
    - **mod/**: TypeScript definitions (`index.d.ts`) for modding.
    - **modlib/**: TypeScript library (`index.ts`) for mods.
- **mods/**: Example mods and templates.
    - **AcePursuit/**, **BombSquad/**, **BumperCars/**, etc.: Example mod directories.
    - **_StartHere_BasicTemplate/**: Template for new mods.
- **python/**: Bundled Python 3.11 environment, likely used for SDK tooling.
- **Godot_v4.4.1-stable_win64.exe**: The Godot editor executable.
- **README.html**: Documentation.
- **requirements.txt**: Python dependencies.

## Key Components
- **GodotProject**: The visual editor workspace.
- **mods**: Collection of example mods to learn from.
- **code**: TypeScript/JavaScript layer, possibly for scripting logic that interfaces with the game or tools.
- **python**: Backend tooling support.

## Languages & Tools
- **Godot Engine**: Core runtime and editor.
- **Python**: Tooling and scripts.
- **TypeScript**: Modding API definitions.
