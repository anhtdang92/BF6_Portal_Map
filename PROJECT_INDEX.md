# Project Index

## Root Directory
- `FULL_INSTRUCTIONS.md`: Detailed guide on using the SDK.
- `README.md`: General overview of the SDK.
- `package.json`: Node.js dependencies.
- `tsconfig.json`: TypeScript configuration.

## Code
### `code/gdconverter`
- Python scripts for converting Godot `.tscn` files to Battlefield Portal `.spatial.json` format.
- `src/gdconverter/export_tscn.py`: Main entry point for export.
- `src/gdconverter/_tscn_to_json.py`: Core conversion logic.

### `code/gdplugins`
- Godot editor plugins.
- `bf_portal/portal_tools/portal_tools_dock.gd`: UI for the export tool in Godot.

## FbExportData
- `asset_types.json`: Definitions of allowed asset types and their properties.
- `level_info.json`: Metadata about supported levels.

## GodotProject
- The Godot project source.
- `levels/`: Base level scenes (e.g., `MP_Eastwood.tscn`, `MP_Abbasid.tscn`).
- `mods/`: Source files for mods.
    - `SiegeNightOps/`: Source for the "Siege Night Ops" mod.
- `objects/`: Shared assets and entities.
    - `entities/SpawnPoint.tscn`: Spawn point asset.
    - `Shared/Generic/Military/Props/`: Prop assets like `BarrierConcreteWall`.

## Mods
- Exported mod files and scripts.
- `SiegeNightOps/`:
    - `mod.json`: Mod metadata.
    - `siege_night.tscn`: The mod scene file.
    - `siege_night.spatial.json`: The exported level data.
    - `export_siege.bat`: Export script.
