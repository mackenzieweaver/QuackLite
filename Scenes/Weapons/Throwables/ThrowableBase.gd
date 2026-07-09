class_name ThrowableBase
extends RigidBody3D


@export var impact_pool_object := GameUtils.PoolObjectNames.None


@onready var land_effect: AudioStreamPlayer3D = $LandEffect
@onready var damage_area: Area3D = $DamageArea
@onready var instant_explode: Area3D = $InstantExplode


var _impulse: float = 2.0
var _torque := Vector3.ONE
var _damage: int = 0
var _damage_collision_mask: int = 0
var _instant_explode_collision_mask: int = 0
var _physics_collision_mask: int = 0


func _ready() -> void:
	damage_area.collision_mask = _damage_collision_mask
	instant_explode.collision_mask = _instant_explode_collision_mask
	collision_mask = _physics_collision_mask
	apply_central_impulse(-global_transform.basis.z.normalized() * _impulse)
	apply_torque_impulse(_torque)


func init(impulse: float, torque: Vector3, damage: int, damage_collision_mask: int, instant_explode_collision_mask: int, physics_collision_mask: int):
	_impulse = impulse
	_torque = torque
	_damage = damage
	_damage_collision_mask = damage_collision_mask
	_instant_explode_collision_mask = instant_explode_collision_mask
	_physics_collision_mask = physics_collision_mask


func blow_up():
	if GameUtils.ValidPoolObject(impact_pool_object):
		ObjectPool.activate(impact_pool_object, global_position)
		
	GameUtils.toggle_area3d(damage_area, true, true)
	GameUtils.vanish_rigidbody(self)
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	queue_free()


func _on_damage_area_area_entered(_area: Area3D) -> void:
	pass # Replace with function body.


func _on_instant_explode_area_entered(_area: Area3D) -> void:
	blow_up()


func _on_explode_timer_timeout() -> void:
	blow_up()


func _on_body_entered(_body: Node) -> void:
	if !land_effect.playing: land_effect.play()

























