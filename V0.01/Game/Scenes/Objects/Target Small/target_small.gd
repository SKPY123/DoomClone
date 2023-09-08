extends RigidBody3D


signal score_up


var hit_force = 100


func hit(hit_dir, hit_point):
	if freeze == true:
		set_freeze_enabled(false)
	
	$CollisionPoint.global_position = hit_point
	apply_force(-hit_dir * hit_force, $CollisionPoint.position)
	
	print("hit")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
