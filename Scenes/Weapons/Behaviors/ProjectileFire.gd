class_name ProjectileFire
extends FireBehavior


@export var projectile_scene: PackedScene
@export_range(0, 100, 1, "suffix:m/s") var speed: float = 1.0


func fire(_parent: Node3D, _transform: Transform3D):
	var p: ProjectileBase = projectile_scene.instantiate()
	p.global_transform = _transform
	p.collision_mask = damage_collision_mask
	p.init(damage, speed, _transform.basis.z * -1.0)
	_parent.get_tree().current_scene.add_child(p)














