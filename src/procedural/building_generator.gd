extends Node2D

const TW := 32
const TH := 16
const HEIGHT_ATLAS_INDEX := [0, 2, 5, 10, 16]
const HEIGHT_ATLAS_EXTENDED_INDEX := [0, 2, 5, 9, 14, 20, 27, 35, 44]

enum {
	EdgeNone,

	EdgeTop,
	EdgeRight,
	EdgeBot,
	EdgeLeft,

	EdgeTopLeft,
	EdgeTopRight,
	EdgeBotRight,
	EdgeBotLeft,

	EdgeFull,
}

@export var building_size : Vector2i = Vector2i(16, 16)
@export var world_coord : Vector2i = Vector2i(64, 64)
@onready var tl : TileMapLayer = $TileMapLayer

func _ready() -> void:
	generate_building(world_coord, building_size)
	# for i in range(8):
	# 	var size := Vector2i(randi_range(1, 32), randi_range(1, 32))
	# 	var coord := Vector2i(randi_range(0, 64) * i, randi_range(0, 64) * i)
	# 	generate_building(coord, size)

func _get_tile_idx(rsize : Vector2i, coord : Vector2i, height : int) -> Vector2i:
	if rsize == Vector2i(1, 1):
		return Vector2i(EdgeFull, height)
	if coord.x == 0 and coord.y == 0:
		return Vector2i(EdgeTopLeft, height)
	if coord.x == rsize.x - 1 and coord.y == 0:
		return Vector2i(EdgeTopRight, height)
	if coord.x == 0 and coord.y == rsize.y - 1:
		return Vector2i(EdgeBotLeft, height)
	if coord.x == rsize.x - 1 and coord.y == rsize.y - 1:
		return Vector2i(EdgeBotRight, height)
		
	if coord.y == 0:
		return Vector2i(EdgeTop, height)
	if coord.y == rsize.y - 1:
		return Vector2i(EdgeBot, height)
	if coord.x == 0:
		return Vector2i(EdgeLeft, height)
	if coord.x == rsize.x - 1:
		return Vector2i(EdgeRight, height)
		
	return Vector2i(EdgeNone, height)


func _generate_quad_chunk(rect : Rect2, world_coord : Vector2i, height : int) -> void:
	var offset := Vector2i(rect.position.x / TW, rect.position.y / TH)
	var chunk := Vector2i(rect.size.x / TW, rect.size.y / TH)

	height = clampi(height, 0, HEIGHT_ATLAS_EXTENDED_INDEX.size())
	for y in range(chunk.y):
		for x in range(chunk.x):
			var coord := Vector2i(x, y)
			var atlas_coord := _get_tile_idx(chunk, coord, HEIGHT_ATLAS_EXTENDED_INDEX[height])
			tl.set_cell(world_coord + coord + offset, 1, atlas_coord)


func traverse_and_set_quad(node : QuadNode, world_coord : Vector2i, height : int = 0) -> void:
	if !node.children[0] and !node.children[1] and !node.children[2] and !node.children[3]:
		return

	_generate_quad_chunk(node.rect, world_coord, height)

	for i in range(node.ChildLimit):
		if node.children[i]:
			traverse_and_set_quad(node.children[i], world_coord, height + 1)


func generate_building(world_coord : Vector2i, size : Vector2i) -> void:
	var rect := Rect2(Vector2.ZERO, Vector2(size.x * TW, size.y * TH))
	var tree = QuadTree.new()

	tree.root.rect = rect
	tree.build_random_tree(tree.root, 0)
	traverse_and_set_quad(tree.root, world_coord, 0)