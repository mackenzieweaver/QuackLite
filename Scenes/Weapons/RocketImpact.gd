extends GPUParticles3D


var _done: bool = true


func pool_is_ready():
	return _done


func pool_activate(pos: Vector3):
	global_position = pos
	_done = false
	restart()


func _on_finished() -> void:
	_done = true
