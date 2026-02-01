class_name Arrow extends Node2D

var dir : Constants.Direction = Constants.Direction.West
var direction : Vector2

@export var arrow_speed : float = 300.0
@export var speed_decline : float = 400.0
@export var sprite : Sprite2D
@export var shadow : TextureRect

const dir_tex : Dictionary[Constants.Direction, Resource] = {
	Constants.Direction.West: preload("uid://b0qrol25l82a0")
}

func _process(delta: float) -> void:

	if dir == Constants.Direction.West:
		# direction = Vector2(-1, 0)
		# var iso_vector := Vector2(direction.x - direction.y, (direction.x + direction.y) / 2.0)
		var iso_vector := direction
		position += iso_vector * delta * arrow_speed

	if arrow_speed > 0:
		arrow_speed -= delta * speed_decline
	else:
		modulate.a -= delta

	if modulate.a <= 0:
		queue_free()
	var p := arrow_speed / 200.0
	shadow.position.y = (p * 8.0) - 5.0



func initialise(shoot_dir : Constants.Direction) -> void:
	dir = shoot_dir
	sprite.texture = dir_tex[dir]
