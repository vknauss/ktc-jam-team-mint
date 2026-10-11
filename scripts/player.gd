extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const LOOK_SENSITIVITY = Vector2(-0.005, -0.005)

func _input(event):
	if event is InputEventMouseMotion:
		var look_input = LOOK_SENSITIVITY * event.relative
		rotate_y(look_input.x)
		var vert_angle = $Camera3D.transform.basis.get_euler().x
		if vert_angle + look_input.y > -PI / 2 && vert_angle + look_input.y < PI / 2:
			$Camera3D.rotate_x(look_input.y)
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
