# Godot 2D Platformer Game

A 2D platformer game built with Godot Engine 4.6 using Jolt Physics. Features include:

## Gameplay

### Controls
- **WASD** or **Arrow Keys**: Move left/right
- **Space**: Jump (double jump available in air)
- **X**: Roll (dash move on the ground)

### Features
- Character with health system (3 HP max)
- Coin collection scoring
- Double jump mechanic
- Rolling dash ability
- Knockback on damage
- Animated sprite system with idle, run, jump, and hit animations

## Project Structure
```
assets/          - Game assets (textures, audio, etc.)
scenes/          - Scene files (.tscn)
scripts/         - GDScript code for game logic
project.godot    - Godot project configuration
```

## Scenes
- **Player**: Main character with movement and combat mechanics
- **Slime**: Enemy/enemy entities
- **Coin**: Collectible items for scoring
- **Platform**: Game platforms
- **Killzone**: Death area
- **Music**: Audio manager
- **GameManager**: Global state (health, score)

## Building & Running

```bash
# Run in Godot Editor
godot --run

# Export (example - select platform in Godot UI)
godot --export-release windows_x11:4.6 --path .
```

## Requirements
- Godot Engine 4.6+
- Jolt Physics plugin (configured as default physics engine)
