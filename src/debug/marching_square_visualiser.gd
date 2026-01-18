class_name MarchingSquaresVisualiser extends Node2D


# func _draw() -> void:
# 	_draw_grid()

# func _draw_corners(rect : Rect2, noise_samples : Array = []) -> void:
# 	var size := Vector2(2.5, 2.5)
# 	var tl := Rect2(rect.position, size)
# 	var tr := Rect2(Vector2(rect.position.x + rect.size.x - size.x, rect.position.y), size)
# 	var br := Rect2(rect.end - size, size)
# 	var bl := Rect2(Vector2(rect.position.x, rect.position.y + rect.size.y - size.y), size)
# 	if noise_samples.is_empty():
# 		draw_rect(tl, Color.RED, true)
# 		draw_rect(tr, Color.RED, true)
# 		draw_rect(br, Color.RED, true)
# 		draw_rect(bl, Color.RED, true)
# 	else:
# 		if noise_samples[TopLeft] > wg.treshold:
# 			draw_rect(tl, Color.RED, true)
# 		if noise_samples[TopRight] > wg.treshold:
# 			draw_rect(tr, Color.RED, true)
# 		if noise_samples[BotRight] > wg.treshold:
# 			draw_rect(br, Color.RED, true)
# 		if noise_samples[BotLeft] > wg.treshold:
# 			draw_rect(bl, Color.RED, true)

# var font := ThemeDB.fallback_font
# func _draw_grid() -> void:
# 	var rows : int = wg.n_tiles.y
# 	var cols : int = wg.n_tiles.x
# 	var sx : float = wg.tile_size.x
# 	var sy : float = wg.tile_size.y
# 	for y in range(rows):
# 		for x in range(cols):
# 			var rect := Rect2(x * sx, y * sy, sx, sy)
# 			var coord := Vector2i(x, y)
# 			draw_rect(rect, color, false, line_width)
# 			if samples.has(coord):
# 				_draw_corners(rect, samples[coord])
# 			else:
# 				_draw_corners(rect)
