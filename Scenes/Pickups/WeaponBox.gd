extends Area3D


@export var weapon_type := WeaponBase.WeaponType.Pistol


@onready var pivot: Node3D = $Pivot
@onready var rocket_launcher: WeaponBase = $Pivot/RocketLauncher
@onready var grenade_launcher: WeaponBase = $Pivot/GrenadeLauncher
@onready var nail_gun: WeaponBase = $Pivot/NailGun
@onready var pistol: WeaponBase = $Pivot/Pistol


func _ready() -> void:
	match weapon_type:
		WeaponBase.WeaponType.Pistol: pistol.show()
		WeaponBase.WeaponType.Grenade: grenade_launcher.show()
		WeaponBase.WeaponType.NailGun: nail_gun.show()
		WeaponBase.WeaponType.RocketLauncher: rocket_launcher.show()


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.collect_weapon(weapon_type)		
		SignalHub.emit_on_play_sound(GameUtils.SoundType.AmmoPickUp)
		queue_free()
