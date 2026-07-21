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















