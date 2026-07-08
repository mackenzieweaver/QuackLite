extends Node


const ROCKET_IMPACT = preload("res://Scenes/Weapons/RocketImpact.tscn")


@onready var container: Node3D = $Container


var _scene_pool: ScenePool

func _ready() -> void:
	_scene_pool = ScenePool.new(4, ROCKET_IMPACT, container, "Impact")
