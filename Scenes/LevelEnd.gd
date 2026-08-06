extends Node3D

@onready var label: Label3D = $Label

var rune_collected: bool = false

func _ready() -> void:
	SignalHub.on_rune_collected.connect(handle_rune_collection)

func handle_rune_collection():
	rune_collected = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is not Player: return
	
	label.show()
	if rune_collected:
		label.text = "You've Completed the Level!"
	else:
		label.text = "You need the key"
		await get_tree().create_timer(2.0).timeout
		label.hide()
