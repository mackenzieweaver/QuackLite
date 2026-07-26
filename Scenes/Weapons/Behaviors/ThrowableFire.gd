class_name ThrowableFire
extends FireBehavior

@export var throwable_scene: PackedScene
@export var impulse: float = 15.0
@export var torque := Vector3(0, 3, 0)

@export_flags_3d_physics var instant_explode_collision_mask: int = 0
@export_flags_3d_physics var physics_collision_mask: int = 0

func fire(parent: Node3D, transform: Transform3D):
	var throwable: ThrowableBase = throwable_scene.instantiate()
	
	# E.g. place grenade at finger tip of bone
	throwable.global_position = transform.origin
	
	# E.g. face the same way as the enemy
	throwable.transform.basis = parent.transform.basis
	
	throwable.init(impulse, torque, damage, damage_collision_mask, instant_explode_collision_mask, physics_collision_mask)
	parent.get_tree().current_scene.add_child(throwable)
