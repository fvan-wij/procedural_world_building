class_name QuadTree extends RefCounted

var root : QuadNode = QuadNode.new()
enum Quadrant {
	TL,
	TR,
	BL,
	BR,
	None,
}

func build_quadrants(node: QuadNode) -> void:
	var half_size = node.rect.size / 2.0
	var p = node.rect.position
	
	var rects = [
		Rect2(p, half_size), # Top Left
		Rect2(Vector2(p.x + half_size.x, p.y), half_size), # Top Right
		Rect2(p + half_size, half_size), # Bottom Right
		Rect2(Vector2(p.x, p.y + half_size.y), half_size) # Bottom Left
	]

	for i in range(4):
		var child = QuadNode.new()
		child.rect = rects[i]
		node.add_child(child, i)
		print("node.children[%d].rect: %s" % [i, node.children[i].rect])


func calculate_quadrants(rect : Rect2) -> Array[Rect2]:
	var half_size = rect.size / 2.0
	var p = rect.position
	
	var rects = [
		Rect2(p, half_size), # Top Left
		Rect2(Vector2(p.x + half_size.x, p.y), half_size), # Top Right
		Rect2(p + half_size, half_size), # Bottom Right
		Rect2(Vector2(p.x, p.y + half_size.y), half_size) # Bottom Left
	]
	return rects


func get_quadrant(quadrant : Quadrant, rect : Rect2) -> Rect2:
	var portion = rect.size / 2.0
	var p = rect.position

	match quadrant:
		Quadrant.TL:
			return Rect2(p, portion)
		Quadrant.TR:
			return Rect2(Vector2(p.x + portion.x, p.y), portion)
		Quadrant.BL:
			return Rect2(p + portion, portion)
		Quadrant.BR:
			return Rect2(Vector2(p.x, p.y + portion.y), portion)
		_:
			return rect


func traverse_tree(node : QuadNode, do : Callable) -> void:
	if !node.children[0] and !node.children[1] and !node.children[2] and !node.children[3]:
		return
	
	do.call(node.rect, Color(randf(), randf(), randf()), true)



	# for i in range(node.ChildLimit):
	# 	if node.children[i]:
	# 		traverse_tree(node.children[i], do)

	# Check first node
	if node.children[0]:
		traverse_tree(node.children[0], do)

	# Check second node
	if node.children[1]:
		traverse_tree(node.children[1], do)

	# Check third node
	if node.children[2]:
		traverse_tree(node.children[2], do)

	# Check fourth node
	if node.children[3]:
		traverse_tree(node.children[3], do)


func build_random_tree(node : QuadNode, lvl : int) -> void:
	if lvl >= 8:
		return

	var quadrant := randi_range(0, 3)
	
	for i in quadrant:
		var child := QuadNode.new()
		child.rect = get_quadrant(i, node.rect)
		node.add_child(child, i)
		build_random_tree(child, lvl + 1)
