extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	var minutes = Game.time / 60
	var seconds = fmod(Game.time, 60.0)
	$CenterContainer/MenuContainer/CountTime.text = "%02d:%02d" % [minutes, seconds]
	$CenterContainer/MenuContainer/CountTargets.text = str(Game.score)
	$CenterContainer/MenuContainer/CountRating
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://Game/Scenes/Levels/Level_Base/Level_base.tscn")


func _on_continue_pressed():
	# EVENTUALY REPLACE WITH get_tree().change_scene_to_file("NEXTLEVEL.tcsn")
	pass # Replace with function body.


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Game/Scenes/Screens/MainMenu/menu.tscn")
