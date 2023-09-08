extends CharacterBody3D

@onready var Camera = $CamNode/Camera3D
@onready var GunCast = $CamNode/Camera3D/GunCast

@onready var Shape = $CollisionShape3D
@onready var ShapeModel = $CollisionShape3D2

const SPEED = 7.0
const JUMP_VELOCITY = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var crouch = false
var zoom = false



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	
	Zoom()
	
	
	if Input.is_action_pressed("Fire"):
		if GunCast.can_fire:
			Fire()
		else:
			pass
	
	
	if Input.is_action_just_pressed("ui_end"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * .05))
		Camera.rotate_x(deg_to_rad(-event.relative.y * .05))
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("Zoom"):
			zoom = true
		if Input.is_action_just_released("Zoom"):
			zoom = false
	
	
	if event is InputEventKey:
		if Input.is_action_just_pressed("Crouch"):
			crouch = true
		if Input.is_action_just_released("Crouch"):
			crouch = false


func Fire():
	if $CamNode/Camera3D/GunCast.can_fire:
		$CamNode/Camera3D/GunCast.Fire()
	else:
		pass


func Zoom():
	match zoom:
		true:
			$CamNode/Camera3D.fov = lerp($CamNode/Camera3D.fov, 35.0, 0.5)
			$PlayerUI/AnimUI.play("Zoom")
		false:
			$CamNode/Camera3D.fov = lerp($CamNode/Camera3D.fov, 70.0, 0.5)
			$PlayerUI/AnimUI.play("Zoom_out")






func _physics_process(delta):
	# Add the gravity.
	Movement(delta)





func Movement(delta):
	var cur_speed = SPEED
	
	
	
	if Input.is_action_pressed("Run"):
		cur_speed += 2
	
	
	
	var walk_Dir = Vector3.ZERO
	
	
	walk_Dir.z = -Input.get_action_strength("Walk_Up") + Input.get_action_raw_strength("Walk_Down")
	walk_Dir.x = -Input.get_action_strength("Walk_Left") + Input.get_action_raw_strength("Walk_Right")
	
	walk_Dir = transform.basis * Vector3(walk_Dir.x, 0,walk_Dir.z).normalized() * cur_speed
	
	if is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			velocity.y += JUMP_VELOCITY
		
		
		velocity.x = walk_Dir.x
		velocity.z = walk_Dir.z
	
	
	if !is_on_floor():
		velocity.y -= gravity * delta
		velocity.x = lerp( velocity.x, walk_Dir.x , 0.05)
		velocity.z = lerp( velocity.z, walk_Dir.z , 0.05)
	
	
	move_and_slide()
	
	if crouch == false:
		Shape.get("shape").set("height", lerp(Shape.get("shape").get("height"), 2.0, 0.05))
		#ShapeModel.get("mesh").set("height", lerp(ShapeModel.get("mesh").get("height"), 2.0, 0.05))
	if crouch == true:
		Shape.get("shape").set("height", lerp(Shape.get("shape").get("height"), 1.0, 0.05))
		#ShapeModel.get("mesh").set("height", lerp(ShapeModel.get("mesh").get("height"), 1.0, 0.05))

