class_name EnemyStateShoot
extends EnemyState


func enter_state():
	enemy.tree_sm.travel("Attack")
	enemy.tree_sm_attack.travel("Shoot")


func update_state(_delta: float):
	pass


func exit_state():
	pass
