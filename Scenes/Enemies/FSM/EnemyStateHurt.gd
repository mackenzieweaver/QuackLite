class_name EnemyStateHurt
extends EnemyState


func enter_state():
	enemy.tree_sm.travel("Hurt")
	enemy.grunt_timer.stop()


func update_state(_delta: float):
	enemy.velocity = Vector3.ZERO


func exit_state():
	pass
