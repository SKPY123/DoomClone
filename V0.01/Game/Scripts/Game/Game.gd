extends Node

var score = 0

var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func score_up():
	score += 1
	print(score)
