class_name EnemyStateDeath
extends EnemyState


func enter_state():
	enemy.tree_sm.travel("Death")
	enemy.physics_collision.set_deferred("disabled", true)
	GameUtils.toggle_area3d(enemy.hit_box, false, false)


func update_state(_delta: float):
	pass


func exit_state():
	await get_tree().create_timer(5).timeout
	enemy.queue_free()
