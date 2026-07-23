class_name EnemyStateWalking
extends EnemyState


func enter_state():
	enemy.tree_sm.travel("Walking")


func update_state(_delta: float):
	grunt()
	walk()


func exit_state():
	enemy.velocity = Vector3.ZERO
	enemy.grunt_timer.stop()


func grunt():
	if enemy.grunt_timer.time_left: return
	enemy.grunt_timer.wait_time = randf_range(5, 10)
	enemy.grunt_timer.start()


func walk():
	if enemy.nav_agent.target_position != enemy.player_ref.player_pos:
		enemy.nav_agent.target_position = enemy.player_ref.player_pos
	
	enemy.look_at_player()
	enemy.velocity = enemy.transform.basis * Vector3.FORWARD * enemy.speed



















