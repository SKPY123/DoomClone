extends Node3D


signal cng_atk_speed(attack_speed)
signal cng_gun_color(GunGolor)

@export var Gun_Color : Color = Color.WHITE
@export var ATKSPEED = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("cng_atk_speed", $"../../..".change_atk_speed)
	connect("cng_gun_color", $"../../..".change_gun_color)
	emit_signal("cng_atk_speed", ATKSPEED)
	emit_signal("cng_gun_color", Gun_Color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func fire():
	$AudioStreamPlayer3D.pitch_scale = randf_range(0.8 , 0.9)
	$AnimPlayer.play("Fire")


