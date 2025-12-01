// Siege Night Ops - Rules Editor Logic
// COPY AND PASTE THIS into the "Script" or "Rules Editor" tab on the Portal Website.

// These functions are available in the Rules Editor environment but may not be in the local SDK.
declare function EnableVisualFilter(filter: string): void;
declare function SetWorldColorScale(color: any, intensity: number): void;
declare function SetCameraEffect(effect: string, intensity: number): void;
declare function MakeColor(r: number, g: number, b: number): any;

export function OnGameModeStarted() {
    // 1. Enable Visual Filter
    // "Noir_Blue" creates a high-contrast, blue-tinted night look.
    // Alternatives: "Search", "B&W"
    EnableVisualFilter("Noir_Blue");

    // 2. Set World Color Scale
    // Tints the global lighting (sun/sky) to a deep blue moonlight.
    // Intensity 0.3 keeps it dark but visible.
    const moonColor = MakeColor(0.0, 0.0, 0.2);
    SetWorldColorScale(moonColor, 0.3);

    // 3. Set Camera Effect
    // "Vignette" darkens the screen edges, hiding the horizon/skybox seams.
    SetCameraEffect("Vignette", 1.0);

    // Debug Message
    console.log("Siege Night Ops: Night Mode Initialized");
}
