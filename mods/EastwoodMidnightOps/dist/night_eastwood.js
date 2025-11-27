"use strict";
// Eastwood Midnight Ops - Logic
// Implements HFSM and Weather Control
Object.defineProperty(exports, "__esModule", { value: true });
exports.OnGameModeStarted = OnGameModeStarted;
const VERSION = [1, 0, 0];
// State Enums
var GameState;
(function (GameState) {
    GameState[GameState["Intro"] = 0] = "Intro";
    GameState[GameState["Infiltration"] = 1] = "Infiltration";
    GameState[GameState["Storm"] = 2] = "Storm";
})(GameState || (GameState = {}));
class LevelDirector {
    constructor() {
        this.currentState = GameState.Intro;
        this.matchTime = 0;
        this.stormTimer = 0;
        console.log("LevelDirector Initialized");
    }
    Update(dt) {
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
    UpdateIntro(dt) {
        // Simple timer to transition to Infiltration
        if (this.matchTime > 5.0) {
            this.TransitionTo(GameState.Infiltration);
        }
    }
    UpdateInfiltration(dt) {
        // Random chance to start storm or fixed time
        if (this.matchTime > 300.0) { // 5 minutes
            this.TransitionTo(GameState.Storm);
        }
    }
    UpdateStorm(dt) {
        // Storm logic (maybe intensify over time)
    }
    TransitionTo(newState) {
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
let director;
function OnGameModeStarted() {
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
