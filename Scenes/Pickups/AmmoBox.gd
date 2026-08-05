extends Area3D


@export var ammo_type := WeaponBase.WeaponType.Pistol
@export var amount: int = 20


@onready var pivot: Node3D = $Pivot
@onready var bullets: Node3D = $Pivot/Bullets
@onready var nails: Node3D = $Pivot/Nails
@onready var grenades: Node3D = $Pivot/Grenades
@onready var rockets: Node3D = $Pivot/Rockets


func _ready() -> void:
	match ammo_type:
		WeaponBase.WeaponType.Pistol: bullets.show()
		WeaponBase.WeaponType.NailGun: nails.show()
		WeaponBase.WeaponType.Grenade: grenades.show()
		WeaponBase.WeaponType.RocketLauncher: rockets.show()


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		if body.add_to_ammo(ammo_type, amount):
			SignalHub.emit_on_play_sound(GameUtils.SoundType.AmmoPickUp)
			queue_free()
