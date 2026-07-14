class_name WeaponBase
extends Node3D


const WEAPON_SWAP = preload("res://Assets/Sounds/159450__weapon_swap.wav")
const EMPTY_WEAPON = preload("res://Assets/Sounds/730213__empty weapon.wav")


enum WeaponType {
	Grenade,
	Pistol,
	RocketLauncher,
	NailGun,
}


@export var weapon_type: WeaponType = WeaponType.Pistol
@export var fire_behavior: FireBehavior
@export var fire_rate_msec: int = 500
@export var start_ammo: int = 25
@export var max_ammo: int = 100


@onready var muzzle: Node3D = $Muzzle
@onready var fire_sound: AudioStreamPlayer3D = $FireSound
@onready var muzzle_flash: GPUParticles3D = $MuzzleFlash
@onready var activate_sound: AudioStreamPlayer3D = $ActivateSound


var _last_fire_msec: int = 0
var _swapping: bool = false
var _ammo: int


func _ready() -> void:
	_ammo = start_ammo


func fire():
	var time_since_last_fire: int = Time.get_ticks_msec() - _last_fire_msec
	var can_shoot: bool = time_since_last_fire > fire_rate_msec
	
	if _swapping or !can_shoot: return
	
	if _ammo == 0:
		activate_sound.stream = EMPTY_WEAPON
		activate_sound.play()
		return
	
	fire_sound.play()
	fire_behavior.fire(self, muzzle.global_transform)
	muzzle_flash.restart()
	
	_ammo -= 1
	_last_fire_msec = Time.get_ticks_msec()


func switch_in():
	_swapping = true
	
	
	show()
	activate_sound.stream = WEAPON_SWAP
	activate_sound.play()
	
	
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", Vector3(360, 0, 0), 0.3)
	await get_tree().create_timer(0.4, false).timeout
	rotation_degrees = Vector3.ZERO
	
	
	_swapping = false


func switch_out():
	hide()















