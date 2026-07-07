class_name ThrowableFire
extends FireBehavior

@export var throwable_scene: PackedScene
@export var impulse: float = 15.0
@export var torque := Vector3(0, 3, 0)

@export_flags_3d_physics var instant_explode_collision_mask: int = 0
@export_flags_3d_physics var physics_collision_mask: int = 0

func fire(_parent: Node3D, _transform: Transform3D):
	var tb: ThrowableBase = throwable_scene.instantiate()
	tb.global_transform = _transform
	tb.init(impulse, torque, damage, damage_collision_mask, instant_explode_collision_mask, physics_collision_mask)
	_parent.get_tree().current_scene.add_child(tb)
