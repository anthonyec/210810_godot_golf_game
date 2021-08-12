extends Node2D

export var enabled: bool
export var target_ball: NodePath
export var max_distance: float = 150
export var max_hit_power: float = 10

onready var line: Line2D = $Line2D
onready var label: RichTextLabel = $Label

var ball: KinematicBody2D
var is_mouse_down: bool = false
var initial_mouse_position: Vector2
var percent: float = 0
var direction: Vector2

func _ready():
	ball =  get_node(target_ball);
	print(ball)

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		is_mouse_down = true
		initial_mouse_position = get_viewport().get_mouse_position()

	if Input.is_action_just_released("left_click"):
		is_mouse_down = false
		line.clear_points()
		ball.hit(direction, max_hit_power * percent)
		label.text = ""
		
	if is_mouse_down:
		var current_mouse_position = get_viewport().get_mouse_position()
		var distance = current_mouse_position.distance_to(initial_mouse_position)
		direction = (initial_mouse_position - current_mouse_position).normalized()
		percent = clamp(distance/max_distance, 0, 1)
		var aim_position = ball.position + direction * (max_distance * percent)
		var text_position = ball.position + direction * (max_distance * (percent / 2))
		label.text = String(floor(percent * 100)) + "%"
		label.rect_position = text_position
		
		line.clear_points()
		line.add_point(ball.position)
		line.add_point(ball.position + direction * (max_distance * percent))

func _on_ball_stopped_moving():
	enabled = true
