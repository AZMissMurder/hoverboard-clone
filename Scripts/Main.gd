extends Node3D

@onready var maze_loader: Node3D = $MazeLoader
@onready var hover_car: RigidBody3D = $HoverCar

func _ready() -> void:
    var spawn := maze_loader.load_maze("MAZE1.MAZ")
    hover_car.global_position = spawn
