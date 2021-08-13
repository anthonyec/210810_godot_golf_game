extends KinematicBody2D

signal stopped_moving
signal bounced(speed, direction, hit_normal)

# TODO: Rename hitted signal to hit
signal hitted(power)

export var friction: float = 0.98;
export var bounce_reduction: float = 0.9;

var stop_bias_for_velocity: float = 0.05;
var velocity: Vector2 = Vector2.ZERO;

func _process(delta):
	var velocity_is_not_zero = velocity != Vector2.ZERO
	var velocity_mag = velocity.abs().length()
	var velocity_under_stop_bias = velocity_mag < stop_bias_for_velocity
	
	if velocity_is_not_zero && velocity_under_stop_bias:
		velocity = Vector2.ZERO
		emit_signal("stopped_moving")
		
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	## Check for velocity to stop infinite bounces happening when touching a
	## wall and not moving.
	if collision && !velocity_under_stop_bias:
		velocity = velocity.bounce(collision.normal) * bounce_reduction;
		emit_signal("bounced", velocity.length(), velocity.normalized(), collision.normal)

	velocity *= friction

func hit(direction: Vector2, power: float):
	velocity += direction * power
	emit_signal("hitted", power)
