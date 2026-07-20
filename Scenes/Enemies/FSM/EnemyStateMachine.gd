class_name EnemyStateMachine
extends Node


@export var enemy: EnemyBase
@export var states: Dictionary[String, EnemyState] = {}


var _prev_state: EnemyState
var _state: EnemyState:
	set(_new_state):
		if _state == _new_state:
			return
		print(_new_state)
		if _state:
			_prev_state = _state
			_state.exit_state()
		if _new_state:
			_state = _new_state
			_state.enter_state()


func start() -> void:
	idle()
	enemy.animation_tree.animation_finished.connect(anim_finished)
	enemy.enemy_hit.connect(hurt)


func update(delta: float):
	if _state: _state.update_state(delta)
	
	enemy.player_detect.look_at(enemy.player_ref.player_pos)
	var is_hurt: bool = _state == states.hurt
	
	if !is_hurt:
		if can_walk():
			walk()
		else:
			idle()


func idle(): _state = states.idle
func walk(): _state = states.walking
func hurt(_acc_dmg: int): _state = states.hurt
func anim_finished(_anim_name: String): idle()


func can_walk() -> bool:
	var is_colliding: bool = enemy.player_detect.is_colliding()
	var with_player: bool = enemy.player_detect.get_collider() is Player
	var is_colliding_with_player: bool = is_colliding and with_player
	
	var is_within_distance = enemy.player_ref.player_less_than_distance(
		enemy.global_position,
		enemy.walk_distance
	)
	
	return is_colliding_with_player and is_within_distance
















