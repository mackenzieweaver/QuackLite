class_name EnemyStateMachine
extends Node


@export var enemy: EnemyBase
@export var states: Dictionary[String, EnemyState] = {}


var _can_change_state: bool = true
var _prev_state: EnemyState
var _state: EnemyState:
	set(_new_state):
		if _state == _new_state:
			return
		print(_new_state)
		if _state:
			_prev_state = _state
			_state.exit_state()
		if _new_state:
			_state = _new_state
			_state.enter_state()


var _melee_on_cooldown = false
var _shoot_on_cooldown = false


func start() -> void:
	idle()
	enemy.enemy_hit.connect(hurt)
	enemy.enemy_died.connect(death)	
	enemy.animation_tree.animation_finished.connect(anim_finished)


func update(delta: float):
	if _state: _state.update_state(delta)
	enemy.player_detect.look_at(enemy.player_ref.player_pos)
	
	if !_can_change_state: return
	var _can_see_player = can_see_player()
	
	if _can_see_player:
		if can_melee():
			melee()
			return
		elif can_shoot():
			shoot()
			return
		elif can_walk():
			walk()
			return
	
	idle()


func idle():
	_can_change_state = true
	_state = states.idle


func walk():
	_can_change_state = true
	_state = states.walking
func can_walk() -> bool:
	return check_distance(enemy.walk_distance)


func melee():
	_can_change_state = false
	_state = states.melee
	_melee_on_cooldown = true
	var timer = enemy.get_tree().create_timer(2)
	timer.timeout.connect(on_melee_cooldown)


func on_melee_cooldown():
	_melee_on_cooldown = false


func can_melee() -> bool:
	var close_enough = check_distance(enemy.melee_distance)
	var off_cooldown = !_melee_on_cooldown
	return close_enough and off_cooldown


func shoot():
	_can_change_state = false
	_state = states.shoot
	_shoot_on_cooldown = true
	var timer = enemy.get_tree().create_timer(5)
	timer.timeout.connect(on_shoot_cooldown)


func on_shoot_cooldown():
	_shoot_on_cooldown = false


func can_shoot() -> bool:
	var not_too_close = enemy.player_ref.player_greater_than_distance(enemy.global_position, 5)
	var close_enough = check_distance(enemy.shoot_distance)
	var off_cooldown = !_shoot_on_cooldown
	return not_too_close and close_enough and off_cooldown


func hurt(_acc_dmg: int):
	_can_change_state = false
	_state = states.hurt


func death():
	_can_change_state = false
	_state = states.death


func anim_finished(anim_name: String):
	if anim_name == 'Death':
		_state.exit_state()
		return
	
	if anim_name == 'Melee': _melee_on_cooldown = true
	if anim_name == 'Shoot': _shoot_on_cooldown = true
	
	_can_change_state = true


func can_see_player() -> bool:
	var is_colliding: bool = enemy.player_detect.is_colliding()
	var with_player: bool = enemy.player_detect.get_collider() is Player
	var is_colliding_with_player: bool = is_colliding and with_player
	return is_colliding_with_player


func check_distance(distance: float) -> bool:
	return enemy.player_ref.player_less_than_distance(
		enemy.global_position,
		distance
	)































