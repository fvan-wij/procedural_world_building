extends Camera2D

@export var camera_speed : float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if Input.is_action_pressed("move_up"):
        position += Vector2(0, -camera_speed)
    if Input.is_action_pressed("move_down"):
        position += Vector2(0, camera_speed)
    if Input.is_action_pressed("move_left"):
        position += Vector2(-camera_speed, 0)
    if Input.is_action_pressed("move_right"):
        position += Vector2(camera_speed, 0)

    if Input.is_action_just_pressed("zoom_in"):
        if (zoom < Vector2(100, 100)):
            zoom *= 1.1
    if Input.is_action_just_pressed("zoom_out"):
        if zoom > Vector2(0.1, 0.1):
            zoom *= 0.9
