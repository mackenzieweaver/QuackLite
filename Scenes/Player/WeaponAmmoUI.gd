extends VBoxContainer

@export var weapon_type: WeaponBase.WeaponType
@onready var image: TextureRect = $Image
@onready var label: Label = $Label

func _ready():
	SignalHub.on_weapon_pickup.connect(handle_pickup)
	SignalHub.on_ammo_updated.connect(handle_ammo)

func handle_pickup(w: WeaponBase.WeaponType):
	if w != weapon_type: return
	image.self_modulate = Color.WHITE

func handle_ammo(w: WeaponBase.WeaponType, amount: int):
	if w != weapon_type: return
	label.show()
	label.text = str(amount)














