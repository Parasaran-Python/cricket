# Cricket

A small 2D arcade game built in Godot 4.6 — a cricket-themed take on the classic paddle game. Slide the bat to keep the ball in play; every contact with the bat scores a run. Miss it and the ball flies out of bounds.

**🏏 Play it here: [cricket.parasaran.in](https://cricket.parasaran.in)**

## Controls

- **Desktop:** Left / Right arrow keys
- **Mobile / Web touch:** Tap or drag horizontally to move the bat

## Project layout

| Path | Purpose |
| --- | --- |
| `node_2d.tscn` | Main scene — ball, bat, walls, background, audio |
| `main.gd` | Game loop: scoring, out-of-bounds detection, restart dialog |
| `Bat.gd` | Bat movement, input handling, wall-collision checks |
| `assets/` | Sprites and the boot splash |
| `ball_hit.mp3` | Bat-on-ball sound effect |
| `.github/workflows/build-deploy.yml` | CI: builds Web/Windows/Linux/Android, deploys Pages |

## Running locally

1. Install [Godot 4.6.2](https://godotengine.org/download).
2. Open this folder as a project (`Import` in the Godot project manager).
3. Press **F5** to run.

## Builds

CI runs on every push to `master` and on `v*` tags:

- **Web** is exported and deployed to GitHub Pages → [cricket.parasaran.in](https://cricket.parasaran.in)
- **Windows**, **Linux**, and **Android (debug APK)** are uploaded as workflow artifacts
- Tagged pushes (`v*`) additionally publish a **GitHub Release** with all four builds attached

To produce builds locally, use Godot's `Project → Export…` with the export presets in `export_presets.cfg`.
