extends Node

onready var ballHitSound: AudioStreamPlayer = $SoundHit
onready var bounceMedium: AudioStreamPlayer = $SoundBounceMedium
onready var bounceSmall: AudioStreamPlayer = $SoundBounceSmall

func _on_ball_hit(speed: float, direction: Vector2):
	# TODO: Should speed actually be a percentage of the hit? Where do we
	# define the upper bound? Currently it's defined in HitBallControl but 
	# we need it here to determine the percentage.
	var max_hit_power: float = 10
	var hit_percent: float = speed / max_hit_power
	ballHitSound.pitch_scale = lerp(1, 1.2, hit_percent)
	ballHitSound.play()

func _on_ball_bounced(power: float, direction: Vector2, hit_normal: Vector2):
	var dot_product = direction.dot(hit_normal)
	
	if dot_product < 0.2:
		print("More of a slide than a bounce")

	var max_hit_power: float = 10
	var bounce_percent: float = power / max_hit_power
	
	if (bounce_percent < 0.4):
		bounceSmall.pitch_scale = lerp(1, 1.5, bounce_percent)
		bounceSmall.volume_db = lerp(-20, 5, bounce_percent * 2)
		bounceSmall.play()
	else:
		bounceMedium.pitch_scale = lerp(1, 1.2, bounce_percent)
		bounceMedium.volume_db = lerp(-20, 0, bounce_percent)
		bounceMedium.play()
