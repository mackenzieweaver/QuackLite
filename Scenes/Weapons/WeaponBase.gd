class_name WeaponBase
extends Node3D


enum WeaponType {
	Grenade,
	Pistol,
	RocketLauncher,
	NailGun,
}


@export var weapon_type: WeaponType = WeaponType.Pistol
@export var fire_behavior: FireBehavior


@onready var muzzle: Node3D = $Muzzle
@onready var fire_sound: AudioStreamPlayer3D = $FireSound


func fire():
	fire_sound.play()
	fire_behavior.fire(self, muzzle.global_transform)


















