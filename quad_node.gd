class_name QuadNode extends RefCounted

var 	children 		: Array[QuadNode] = [null, null, null, null]
var 	rect 			: Rect2
const 	ChildLimit 		: int = 4


func add_child(child : QuadNode, idx : int) -> void:
	if idx >= 4:
		return

	children[idx] = child


func remove_node(idx : int) -> void:
	if idx >= 4:
		return
	
	children[idx] = null