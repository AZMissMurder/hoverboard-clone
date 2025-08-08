extends Node3D

const MAZE_WIDTH: int = 48
const MAZE_HEIGHT: int = 32
const TILE_SIZE: float = 2.0

var tile_scenes := {
    0: preload("res://Assets/Scenes/Floor.tscn"),
    1: preload("res://Assets/Scenes/Wall.tscn"),
    2: preload("res://Assets/Scenes/PlayerSpawn.tscn"),
}

func load_maze(filename: String) -> Vector3:
    var file := FileAccess.open("res://Assets/Mazes/%s" % filename, FileAccess.READ)
    if file == null:
        push_error("Couldn't open %s" % filename)
        return Vector3.ZERO
    var data := file.get_buffer(file.get_length())
    file.close()

    if data.size() != MAZE_WIDTH * MAZE_HEIGHT:
        push_error("Unexpected file size: %s" % data.size())
        return Vector3.ZERO

    var spawn_position := Vector3.ZERO

    for y in range(MAZE_HEIGHT):
        for x in range(MAZE_WIDTH):
            var idx := data[y * MAZE_WIDTH + x]
            if tile_scenes.has(idx):
                var tile := tile_scenes[idx].instantiate()
                tile.position = Vector3(x * TILE_SIZE, 0, y * TILE_SIZE)
                add_child(tile)
                if idx == 2:
                    spawn_position = tile.position + Vector3.UP
    return spawn_position
