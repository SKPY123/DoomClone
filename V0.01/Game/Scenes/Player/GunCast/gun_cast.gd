extends RayCast3D


@onready var hitMark = preload("res://Game/Scenes/Effects/HitMark/hit_mark.tscn")

@onready var PistolFile = preload("res://Game/Scenes/Player/Guns/Guns/Pistol.tscn")
@onready var MachinePistolFile = preload("res://Game/Scenes/Player/Guns/Guns/MachinePistol.tscn")

var gun_color : Color = Color.WHITE

var can_fire = true

var MainWeapon = null
var SecondaryWeapon = null


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in $Arms/Hand.get_children():
		i.queue_free()
	var PistolInst = PistolFile.instantiate()
	$Arms/Hand.add_child(PistolInst)
	MainWeapon = PistolFile
	SecondaryWeapon = MachinePistolFile


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_Arms()
	if Input.is_action_just_pressed("Weapon_next"):
		change_weapon("next")
	if Input.is_action_just_pressed("Weapon_prev"):
		change_weapon("prev")
	
	
	


func change_atk_speed(atkspeed):
	$AtkSpeed.wait_time = atkspeed


func change_gun_color(newGunColor  : Color):
	gun_color = newGunColor
	print("ColorChanged")


func change_weapon(to_weapon):
	match to_weapon:
		"next":
			for i in $Arms/Hand.get_children():
				i.queue_free()
			var NewInst = MainWeapon.instantiate()
			$Arms/Hand.add_child(NewInst)
		"prev":
			for i in $Arms/Hand.get_children():
				i.queue_free()
			var NewInst = SecondaryWeapon.instantiate()
			$Arms/Hand.add_child(NewInst)



func _Arms():
	if get_collider():
		$Arms.look_at(get_collision_point())
	else:
		$Arms.rotation = Vector3.ZERO


func Fire():
	
	
	if can_fire:
		for i in $Arms/Hand.get_children():
			if i.has_method("fire"):
				i.fire()
		
		$AnimArms.play("Recoil")
		
		if is_colliding():
			
			var newMark = hitMark.instantiate()
			
			get_tree().root.add_child(newMark)
			newMark.hit_color = gun_color
			newMark.global_position = get_collision_point() + (get_collision_normal() * .01)
		
		if get_collider():
			if get_collider().has_method("hit"):
				get_collider().hit(get_collision_normal(), get_collision_point())
		
		
		
		can_fire = false
		
		$AtkSpeed.start()
	
	else:
		pass


func _on_atk_speed_timeout():
	can_fire = true
