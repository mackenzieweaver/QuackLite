extends Control

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	SignalHub.on_hitscan_hit.connect(hit)

func hit():
	gpu_particles_2d.position = get_viewport_rect().get_center()
	gpu_particles_2d.restart()
