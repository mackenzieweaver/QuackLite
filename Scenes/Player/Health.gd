extends VBoxContainer

const HEALTHY = preload("res://Assets/Images/QuakeGuy/QuakeGuy64Face.png")
const HURT1 = preload("res://Assets/Images/QuakeGuy/QuakeGuy64Face1.png")
const HURT2 = preload("res://Assets/Images/QuakeGuy/QuakeGuy64Face2.png")
const HURT3 = preload("res://Assets/Images/QuakeGuy/QuakeGuy64Face3.png")

@onready var image: TextureRect = $Image
@onready var label: Label = $Label

func _ready() -> void:
	SignalHub.on_player_health_changed.connect(update_health)

func update_health(h: int):
	label.text = str(h)
	if h > 75: image.texture = HEALTHY
	elif h > 50: image.texture = HURT1
	elif h > 25: image.texture = HURT2
	else: image.texture = HURT3
