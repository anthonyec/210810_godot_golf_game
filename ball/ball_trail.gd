extends Line2D

var multipler: float = 2.5

func _ready():
	clear_points()
	add_point(Vector2(0, 0))
	add_point(Vector2(0, 0))

func _on_ball_moving(speed, direction):
	set_point_position(1, position - direction * speed * multipler)
	pass
