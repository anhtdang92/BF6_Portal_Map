import json
import sys

def patch_json(file_path):
    try:
        with open(file_path, 'r') as f:
            data = json.load(f)
        
        # Inject required fields
        data['mapName'] = 'Abbasid'
        data['gameMode'] = 'Conquest'
        
        # Ensure they are at the top (visually, though JSON order doesn't technically matter)
        # We can reconstruct the dict to put them first
        new_data = {
            'mapName': 'Abbasid',
            'gameMode': 'Conquest'
        }
        new_data.update(data)
        
        with open(file_path, 'w') as f:
            json.dump(new_data, f, indent=4)
            
        print(f"Successfully patched {file_path}")
        
    except Exception as e:
        print(f"Error patching JSON: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python patch_json.py <path_to_json>")
        sys.exit(1)
    
    patch_json(sys.argv[1])
