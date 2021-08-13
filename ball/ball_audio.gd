extends Node

onready var ballHitSound: AudioStreamPlayer = $BallHitSound
onready var wallHitSound: AudioStreamPlayer = $WallHitSound

func _on_ball_hit(speed: float):
#	print("hit sound", speed)
	ballHitSound.pitch_scale = rand_range(0.8, 1.3)
	ballHitSound.play()

func _on_ball_bounced(power: float, direction: Vector2, hit_normal: Vector2):
	var normalized_dot_product = direction.dot(hit_normal)
	print("bounced sound ", power, ", ", normalized_dot_product)
	
	if normalized_dot_product < 0.2:
		print("More of a slide than a bounce")
	
	wallHitSound.pitch_scale = clamp(power, 0.8, 1)
	wallHitSound.volume_db = power
	wallHitSound.play()
