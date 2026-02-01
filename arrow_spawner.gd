class_name ArrowSpawner extends Node

@export var projectile : PackedScene
@export var player : Player

func _ready() -> void:
	if player:
		player.shoot_arrow_to.connect(_shoot_arrow_to)


func _shoot_arrow_to(dir : Constants.Direction, vector : Vector2) -> void:
	# if dir == Constants.Direction.West:
	var arrow := projectile.instantiate() as Arrow
	arrow.direction = vector
	# var angle := vector.angle()
	# arrow.rotate(angle)
	arrow.initialise(Constants.Direction.West)
	arrow.position = player.bow.global_position - Vector2(0, 16)
	add_child(arrow)
