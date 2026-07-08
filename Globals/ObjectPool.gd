extends Node


const ROCKET_IMPACT = preload("res://Scenes/Weapons/RocketImpact.tscn")


var pools: Dictionary[GameUtils.PoolObjectNames, ScenePool] = {}


func init_pools(container: Node3D):
	pools.clear()
	pools[GameUtils.PoolObjectNames.RocketImpact] = ScenePool.new(100, ROCKET_IMPACT, container, "Rocket_Impact")


func activate(pool: GameUtils.PoolObjectNames, pos: Vector3):
	if pools.has(pool): pools[pool].activate_next_scene(pos)

