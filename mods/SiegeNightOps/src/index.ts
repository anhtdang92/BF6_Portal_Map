import { 
    Events, 
    Player, 
    VisualFilter, 
    World, 
    Color 
} from "@bf6mods/sdk";

// 1. Initialize Night Mode when the Game Mode starts
Events.onGameModeStarted.subscribe(() => {
    
    // Apply the 'Liberation' filter (Cold/Blue tint) to simulate Moonlight
    // 'Noir' is also an option for pitch black, but Liberation is better for visibility.
    World.setVisualFilter(VisualFilter.Liberation);

    // Crush the exposure (Brightness) to 15% to hide the daylight skybox
    World.setColorScale(new Color(0.1, 0.1, 0.3), 0.15);

    // Optional: Add heavy fog to hide the ground below
    World.setFog({
        density: 0.8,
        color: new Color(0.0, 0.0, 0.1), // Dark Blue Fog
        startDistance: 10,
        endDistance: 500
    });

    console.log("Night Mode Initialized on MP_Abbasid");
});

// 2. Force players to spawn on our Sky Platform
// This overrides the default map spawns which are on the ground.
Events.onPlayerSpawn.subscribe((player: Player) => {
    
    // Teleport player to the platform coordinates defined in the JSON (Y=802)
    // We add a slight random offset so players don't stack on top of each other.
    const randomOffset = Math.random() * 5;
    
    player.teleport({
        x: 0 + randomOffset,
        y: 802,
        z: 0 + randomOffset
    });
});
