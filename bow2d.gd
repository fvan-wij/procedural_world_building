class_name Bow2D extends Sprite2D

const dir_tex : Dictionary[Constants.Direction, Resource] = {
	Constants.Direction.North:preload("uid://c074sa7cyudaa"),
	Constants.Direction.East: preload("uid://jmmcf3nn3ufv"),
	Constants.Direction.South: preload("uid://7gf3j3ccw6qp"),
	Constants.Direction.West: preload("uid://brg588225m660"),
}

func point_to(dir : Constants.Direction) -> void:
	texture = dir_tex[dir]
