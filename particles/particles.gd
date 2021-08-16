extends CPUParticles2D

onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start() 
	emitting = true

func _on_timer_timeout() -> void:
	queue_free()
