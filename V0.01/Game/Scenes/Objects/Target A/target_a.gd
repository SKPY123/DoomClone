extends RigidBody3D

@onready var light = $Light

signal score_up


var hit_force = 250


func hit(hit_dir, hit_point):
	if freeze == true:
		set_freeze_enabled(false)
		#light.hide()
		get_tree().root.get_node("/root/Game").score_up()
	$CollisionPoint.global_position = hit_point
	apply_force(-hit_dir * hit_force, $CollisionPoint.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


