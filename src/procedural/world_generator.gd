@tool
class_name WorldGenerator extends Node

# World settings
@export_category("World Settings")
@export var chunk_size : Vector2i = Vector2i(10, 10)
@export var chunks : Vector2i = Vector2i(4, 4)
@export var tile_size : Vector2 = Vector2(64, 64)
@export var threshold : float = 0.5
@export_tool_button("Generate Chunk")
var my_button := func(): _on_button_pressed()

@export_category("Components")
@export var noise_sampler : NoiseSampler
@export var ground_layer : TileMapLayer


enum {
	FlatGround,
	EdgeGround,
	Wall,
}


func _tile_to_atlas_coord(tile_idx : int, rows : int, cols : int) -> Vector2i:
	var x : int = tile_idx % cols
	var y : int = floor(tile_idx / cols)
	return Vector2i(x, y)


func _on_button_pressed() -> void:
	ground_layer.clear()
	if not noise_sampler or not ground_layer:
		printerr("WorldGenerator: Please assign NoiseSampler and GroundLayer in the Inspector!")
		return
		
	for y in range(chunks.y):
		for x in range(chunks.x):
			var chunk := Vector2i(x, y)
			generate_chunk(chunk)


func generate_chunk(chunk_coord : Vector2i) -> void:
	# ground_layer.clear()
	var offset := Vector2i(chunk_coord.x * chunk_size.x, chunk_coord.y * chunk_size.y)
	for y in range(chunk_size.y):
		for x in range(chunk_size.x):
			var coord := Vector2i(x + offset.x, y + offset.y)
			var tile_idx := noise_sampler.sample_marching_square_at(coord, tile_size, threshold)
			var atlas_coord := _tile_to_atlas_coord(tile_idx, 4, 4)
			ground_layer.set_cell(coord, EdgeGround, atlas_coord)
