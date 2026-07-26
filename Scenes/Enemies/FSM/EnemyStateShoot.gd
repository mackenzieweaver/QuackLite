class_name EnemyStateShoot
extends EnemyState


func enter_state():
	look_at_player()
	var anim_name = 'Throw' if enemy.fire_behavior is ThrowableFire else 'Shoot'
	play_attack_animation(anim_name) # animation calls fire method


func update_state(_delta: float):
	pass


func exit_state():
	pass














