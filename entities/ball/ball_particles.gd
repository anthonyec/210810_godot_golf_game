extends Node2D

export var bounce_particles: PackedScene;
export var hit_particles: PackedScene;

onready var spawner: Position2D = $Spawner

func _on_ball_bounced(speed, direction, hit_normal) -> void:
	spawner.spawn(bounce_particles)

func _on_ball_hit(power, direction) -> void:
	spawner.spawn(hit_particles)
