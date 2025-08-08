extends RigidBody3D

@export var thrust: float = 20.0
@export var turn_speed: float = 3.0
@export var hover_height: float = 1.5
@export var hover_force: float = 30.0
@export var damping: float = 4.0
@export var max_speed: float = 25.0

func _physics_process(delta: float) -> void:
    var forward := Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
    if forward != 0.0:
        apply_central_force(-transform.basis.z * thrust * forward)

    var turn := Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")
    if turn != 0.0:
        apply_torque_impulse(Vector3.UP * turn * turn_speed)

    var from := global_transform.origin
    var to := from + Vector3.DOWN * (hover_height + 2.0)
    var res := get_world_3d().direct_space_state.intersect_ray(from, to, [self])
    if res:
        var dist := from.y - res.position.y
        var force := (hover_height - dist) * hover_force
        if force > 0.0:
            apply_central_force(Vector3.UP * force)

    var lv := linear_velocity.move_toward(Vector3.ZERO, damping * delta)
    linear_velocity = lv.limit_length(max_speed)
