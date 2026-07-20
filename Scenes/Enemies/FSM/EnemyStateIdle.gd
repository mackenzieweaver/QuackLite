class_name EnemyStateIdle
extends EnemyState


func enter_state():
	enemy.tree_sm.travel("Idle")


func update_state(_delta: float):
	pass


func exit_state():
	pass






















