# hoverboard-clone

Cloning the classic Windows 95 game Hover!

This repository contains GDScript helpers for Godot 4:

- `Scripts/MazeLoader.gd` – loads MAZ files and instantiates simple tile scenes.
- `Scripts/HoverCar.gd` – rudimentary hover car controller.
- `Scripts/Main.gd` – ties the maze loader and hover car together; expects
  children named `MazeLoader` and `HoverCar` in the scene.

Drop `Assets/Mazes/*.MAZ` and simple `Assets/Scenes` scene files into a Godot
project to run.
