class_name EnemyStateMachine
extends Node


@export var enemy: EnemyBase
@export var initial_state: EnemyState
@export var states: Dictionary[String, EnemyState] = {}


var _state: EnemyState


func ready() -> void:
	change_to_state(initial_state)
	enemy.enemy_hit.connect(take_hit)


func change_to_state(s: EnemyState):
	if !s: return
	if _state: _state.exit_state()
	
	_state = s
	_state.enter_state()


func take_hit(_acc_dmg: int):
	change_to_state(states.hurt)









