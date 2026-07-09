extends Node3D


@onready var particles: GPUParticles3D = $GPUParticles3D
@onready var sound: AudioStreamPlayer3D = $Sound


var _done: bool = true


func pool_is_ready():
	return _done


func pool_activate(pos: Vector3):
	global_position = pos
	_done = false
	particles.restart()
	sound.play()


func _on_gpu_particles_3d_finished() -> void:
	_done = true
