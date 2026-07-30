class_name EnemyState
extends Node


@export var state_machine: EnemyStateMachine
@export var enemy: EnemyBase


var _elapsed_time: float = 0.0:
	set(v): _elapsed_time = v


func enter_state():
	pass


func update_state(_delta: float):
	pass


func exit_state():
	pass


func look_at_player():
	# Dont look up/down just straight
	var x = enemy.player_ref.player_x
	var z = enemy.player_ref.player_z
	enemy.look_at(Vector3(x, 0, z))


func play_attack_animation(anim_name: String):
	var current_tree_sm_node = enemy.tree_sm.get_current_node()
	if !current_tree_sm_node == 'Attack': enemy.tree_sm.travel("Attack")
	
	var current_tree_sm_attack_node = enemy.tree_sm_attack.get_current_node()
	if current_tree_sm_attack_node == anim_name: enemy.tree_sm_attack.start(anim_name)
	else: enemy.tree_sm_attack.travel(anim_name)


func fire():
	var spawn = enemy.get_tree().get_first_node_in_group('bone') as BoneAttachment3D
	enemy.fire_behavior.fire(enemy, spawn.global_transform)























