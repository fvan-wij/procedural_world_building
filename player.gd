class_name Player extends CharacterBody2D

signal shoot_arrow_to(dir : Constants.Direction, vector : Vector2)
@export var movement_speed := 5.0
@export var bow : Bow2D

func _process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var iso_vector := Vector2(input_vector.x - input_vector.y, (input_vector.x + input_vector.y) / 2.0)
	var motion := iso_vector * movement_speed * delta
	position += motion

	var mp := get_local_mouse_position()
	var dir := get_iso_direction(mp)
	bow.point_to(dir)

	if Input.is_action_just_pressed("shoot"):
		shoot_arrow_to.emit(dir, mp.normalized())

	var dist := 5.0
	bow.position = Vector2(clampf(mp.x, -dist, dist), clampf(mp.y, -dist, dist))
	queue_redraw()


func get_iso_angle(point : Vector2) -> float:
	var diff = point
	var flat_diff = Vector2(diff.x, diff.y * 2.0)
	var angle = rad_to_deg(atan2(flat_diff.y, flat_diff.x))
	return angle


func get_iso_direction(point : Vector2) -> Constants.Direction:
	var angle := get_iso_angle(point) - 45
	if angle > -45 and angle <= 45:
		# print("East")
		return Constants.Direction.East
	elif angle > 45 and angle <= 135:
		# print("South")
		return Constants.Direction.South
	elif angle > -135 and angle <= -45:
		# print("North")
		return Constants.Direction.North
	else:
		# print("West")
		return Constants.Direction.West

func _draw() -> void:
	# draw_circle(get_global_mouse_position(), 5, Color.RED, false)
	var w := Vector2(5, 5)
	draw_rect(Rect2(get_local_mouse_position() - w/2, w), Color.RED, false)
	draw_string(ThemeDB.fallback_font, Vector2(0, -200), "local mp: " + str(get_local_mouse_position()))
	# draw_string(ThemeDB.fallback_font, Vector2(0, -250), "global mp: " + str(get_global_mouse_position()))
