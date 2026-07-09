extends Node


const ROCKET_IMPACT = preload("res://Scenes/Weapons/RocketImpact.tscn")
const GRENADE_EXPLOSION = preload("res://Scenes/Weapons/Throwables/GrenadeExplosion.tscn")


var pools: Dictionary[GameUtils.PoolObjectNames, ScenePool] = {}


func init_pools(container: Node3D):
	pools.clear()
	pools[GameUtils.PoolObjectNames.RocketImpact] = ScenePool.new(100, ROCKET_IMPACT, container, "Rocket_Impact")
	pools[GameUtils.PoolObjectNames.GrenadeExplosion] = ScenePool.new(100, GRENADE_EXPLOSION, container, "Grenade_Explosion")


func activate(pool: GameUtils.PoolObjectNames, pos: Vector3):
	if pools.has(pool): pools[pool].activate_next_scene(pos)

