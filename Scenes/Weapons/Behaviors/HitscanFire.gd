class_name HitscanFire
extends FireBehavior


@export var collide_with_bodies: bool = true
@export var collide_with_areas: bool = true
@export_range(0, 200, 1, "suffix:m") var max_scan_distance: float = 200.0


func fire(_parent: Node3D, _transform: Transform3D):
	var space: PhysicsDirectSpaceState3D = _parent.get_world_3d().direct_space_state
	var from: Vector3 = _transform.origin
	var to: Vector3 = from + _transform.basis.z * -max_scan_distance
	
	var ray_cast_parameters := PhysicsRayQueryParameters3D.create(from, to, damage_collision_mask)
	ray_cast_parameters.collide_with_areas = collide_with_areas
	ray_cast_parameters.collide_with_bodies = collide_with_bodies
	
	var hit: Dictionary = space.intersect_ray(ray_cast_parameters)
	if hit:
		var collider: CollisionObject3D = hit.collider
		if collider is HitBox and collider.get_health() > 0:
			SignalHub.emit_on_hitscan_hit()
			collider.take_hit(damage)























