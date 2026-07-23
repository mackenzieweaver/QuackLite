class_name EnemyStateShoot
extends EnemyState


func enter_state():
	enemy.look_at_player()
	play_animation()


func update_state(_delta: float):
	pass


func exit_state():
	pass


func play_animation():
	var current_tree_sm_node = enemy.tree_sm.get_current_node()
	if !current_tree_sm_node == 'Attack': enemy.tree_sm.travel("Attack")
	
	var current_tree_sm_attack_node = enemy.tree_sm_attack.get_current_node()
	if current_tree_sm_attack_node == 'Shoot': enemy.tree_sm_attack.start('Shoot')
	else: enemy.tree_sm_attack.travel('Shoot')














