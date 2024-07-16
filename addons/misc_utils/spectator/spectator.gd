class_name Spectator extends Camera3D


@export var move_speed: float = 6.0:
	set(value):
		value = maxf(1.0, value)
		move_speed = value
	get:
		return move_speed
@export var acceleration: float = 15.0:
	set(value):
		value = clampf(value, 1.0, 60.0)
		acceleration = value
	get:
		return acceleration
@export var mouse_sensitivity: Vector2 = Vector2(0.15, 0.15)
@export_group("Input Actions")
@export var move_forward: StringName = "ui_up"
@export var move_backward: StringName = "ui_down"
@export var move_left: StringName = "ui_left"
@export var move_right: StringName = "ui_right"
@export var move_up: StringName = "ui_page_up"
@export var move_down: StringName = "ui_page_down"
@export var unlock_cursor: StringName = "ui_cancel"

var _velocity: Vector3


func _physics_process(delta: float) -> void:
	# Unlock cursor.
	if Input.is_action_just_pressed(unlock_cursor):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Movement inputs.
	var input_xz := Input.get_vector(move_left, move_right, move_forward, move_backward)
	var input_y := Input.get_axis(move_down, move_up)
	var move_vector := transform.basis * Vector3(input_xz.x, input_y, input_xz.y)
	
	# Apply velocity.
	var target_velocity := move_vector * move_speed
	var diff_velocity := target_velocity - _velocity
	_velocity += diff_velocity * clampf(delta * acceleration, 0.0, 1.0)
	position += _velocity * delta


func _input(event: InputEvent) -> void:
	# Camera inputs.
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		rotation_degrees.y -= motion.relative.x * mouse_sensitivity.x
		rotation_degrees.x -= motion.relative.y * mouse_sensitivity.y
		rotation_degrees.x = clampf(rotation_degrees.x, -85.0, 85.0)
	
	# Mouse button inputs.
	if event is InputEventMouseButton:
		var button := event as InputEventMouseButton
		if button.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		elif button.button_index == MOUSE_BUTTON_WHEEL_UP:
			move_speed += 1.0
		elif button.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			move_speed -= 1.0

