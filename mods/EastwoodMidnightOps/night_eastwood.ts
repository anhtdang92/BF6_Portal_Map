// Eastwood Midnight Ops - Logic
// Implements HFSM and Weather Control

const VERSION = [1, 0, 0];

// State Enums
enum GameState {
    Intro,
    Infiltration,
    Storm
}

class LevelDirector {
    currentState: GameState = GameState.Intro;
    matchTime: number = 0;
    stormTimer: number = 0;

    constructor() {
        console.log("LevelDirector Initialized");
    }

    Update(dt: number) {
        this.matchTime += dt;

        switch (this.currentState) {
            case GameState.Intro:
                this.UpdateIntro(dt);
                break;
            case GameState.Infiltration:
                this.UpdateInfiltration(dt);
                break;
            case GameState.Storm:
                this.UpdateStorm(dt);
                break;
        }
    }

    UpdateIntro(dt: number) {
        // Simple timer to transition to Infiltration
        if (this.matchTime > 5.0) {
            this.TransitionTo(GameState.Infiltration);
        }
    }

    UpdateInfiltration(dt: number) {
        // Random chance to start storm or fixed time
        if (this.matchTime > 300.0) { // 5 minutes
            this.TransitionTo(GameState.Storm);
        }
    }

    UpdateStorm(dt: number) {
        // Storm logic (maybe intensify over time)
    }

    TransitionTo(newState: GameState) {
        console.log(`Transitioning from ${this.currentState} to ${newState}`);
        this.currentState = newState;

        switch (newState) {
            case GameState.Intro:
                // Setup initial state
                break;
            case GameState.Infiltration:
                mod.Message("Infiltration Phase Started");
                // Set weather to clear night
                // Note: Actual weather commands might need specific API calls if available
                break;
            case GameState.Storm:
                mod.Message("WARNING: Storm Approaching");
                // Set weather to storm
                break;
        }
    }
}

let director: LevelDirector;

export function OnGameModeStarted() {
    console.log("Eastwood Midnight Ops Started");
    director = new LevelDirector();

    // Start the update loop
    GameLoop();
}

async function GameLoop() {
    while (true) {
        if (director) {
            director.Update(0.1);
        }
        await mod.Wait(0.1);
    }
}
