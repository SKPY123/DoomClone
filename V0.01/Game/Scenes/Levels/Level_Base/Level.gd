extends Node3D




# Called when the node enters the scene tree for the first time.
func _ready():
	Game.score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_end_area_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Game/Scenes/Screens/EndLevel/end_level.tscn")


func _on_timer_timeout():
	Game.time += 1.0
	$Timer.start()
