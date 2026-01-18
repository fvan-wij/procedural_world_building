## Samples FastNoiseLite 
@tool
class_name NoiseSampler extends Node2D

# Visualizing sutff
@export var color : Color = Color.BLACK
@export var line_width : float = 1.0

enum {
	TopLeft,
	TopRight,
	BotRight,
	BotLeft,
}

# Input
@export var noise : FastNoiseLite

var _samples : Dictionary[Vector2i, Array] = {} # Values [int -> float[0, 0, 0, 0]]

func _sample_rect(rect : Rect2) -> Array[float]:
	var tl := sample_noise_at(rect.position)
	var tr := sample_noise_at(Vector2(rect.position.x + rect.size.x, rect.position.y))
	var br := sample_noise_at(rect.end)
	var bl := sample_noise_at(Vector2(rect.position.x, rect.position.y + rect.size.y))
	return [tl, tr, br, bl]


func _build_index_from_samples(samples : Array[float], threshold : float) -> int:
	var result : int = 0
	var bit_mask : int = 15
	for i in range(samples.size()):
		var bit : int = 1 if samples[i] > threshold else 0
		result += (bit << i) & bit_mask

	return result


## Samples noise at given coordinate
func sample_noise_at(coord : Vector2) -> float:
	return noise.get_noise_2d(coord.x, coord.y)


## Samples 4 corners of a cell of a given coordinate
## where corners are 'on' past the given threshold value (-1.0, 1.0)
func sample_marching_square_at(coord : Vector2i, tile_size : Vector2, threshold : float) -> int:
	var rect := Rect2(coord.x * tile_size.x, coord.y * tile_size.y, tile_size.x, tile_size.y)
	var samples : Array[float] = _sample_rect(rect)
	return _build_index_from_samples(samples, threshold)

