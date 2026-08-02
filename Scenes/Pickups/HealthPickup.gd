class_name HealthPickup
extends Area3D

@export var bonus: int = 25

func _on_body_entered(_body: Node3D) -> void:
	hide()
	GameUtils.toggle_area3d(self, false, false)
	SignalHub.emit_on_player_health_bonus(bonus)
	queue_free()
