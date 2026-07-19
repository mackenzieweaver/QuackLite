class_name EnemyStateMachine
extends Node


@export var enemy: EnemyBase
@export var states: Dictionary[String, EnemyState] = {}


var _prev_state: EnemyState
var _state: EnemyState:
	set(_new_state):
		if _state == _new_state:
			return
		if _state:
			_prev_state = _state
			_state.exit_state()
		if _new_state:
			_state = _new_state
			_new_state.enter_state()


func start() -> void:
	idle()
	enemy.animation_tree.animation_finished.connect(anim_finished)
	enemy.enemy_hit.connect(hurt)


func update(delta: float):
	if _state: _state.update_state(delta)
	enemy.player_detect.look_at(enemy.player_ref.player_pos)
	
	if enemy.player_detect.is_colliding():
		if enemy.player_detect.get_collider() is Player:
			walk()
		else:
			idle()


func idle(): _state = states.idle
func walk(): _state = states.walking
func hurt(): _state = states.hurt
func anim_finished(_anim_name: String): idle()



















