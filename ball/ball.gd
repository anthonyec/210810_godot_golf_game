extends KinematicBody2D

signal stopped_moving

# TODO: Rename dot product var to something that makes more sense, direct_hit-ness?
signal bounced(speed, normalized_dot_product)

# TODO: Rename hitted signal to hit
signal hitted(power)

export var friction: float = 0.98;
export var bounce_reduction: float = 0.9;

var stop_bias_for_velocity: float = 0.05;
var velocity: Vector2 = Vector2.ZERO;

func _process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	if collision:
		velocity = velocity.bounce(collision.normal) * bounce_reduction;
		emit_signal("bounced", velocity.length(), velocity.normalized().dot(collision.normal))

	velocity *= friction
	
	var velocity_is_zero = velocity != Vector2.ZERO
	var velocity_mag = velocity.abs().length()
	
	if velocity_is_zero && velocity_mag < stop_bias_for_velocity:
		velocity = Vector2.ZERO
		emit_signal("stopped_moving")

func hit(direction: Vector2, power: float):
	velocity += direction * power
	emit_signal("hitted", power)
