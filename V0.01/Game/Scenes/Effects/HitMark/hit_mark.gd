extends GPUParticles3D

var hit_color = Color.WHITE


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()
