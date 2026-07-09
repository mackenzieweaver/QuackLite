class_name ProjectileBase
extends Area3D


@export var impact_pool_object := GameUtils.PoolObjectNames.None


@onready var hit_sound: AudioStreamPlayer3D = $HitSound


var _damage = 0
var _velocity = Vector3.ZERO


func init(damage: int, speed: float, dir: Vector3):
	_damage = damage
	_velocity = dir.normalized() * speed


func _physics_process(delta: float):
	global_translate(_velocity * delta)


func blow_up():
	if GameUtils.ValidPoolObject(impact_pool_object):
		ObjectPool.activate(impact_pool_object, global_position)
	
	GameUtils.toggle_area3d(self, false, false)
	hide()
	set_physics_process(false)
	if hit_sound.stream:
		hit_sound.play()
		await hit_sound.finished
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	blow_up()
	if area is HitBox: area.take_hit(_damage)


func _on_body_entered(_body: Node3D) -> void:
	blow_up()



























