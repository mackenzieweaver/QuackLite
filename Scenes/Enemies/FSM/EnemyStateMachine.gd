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


func start() -> void:
	idle()
	enemy.animation_tree.animation_finished.connect(anim_finished)
	enemy.enemy_hit.connect(hurt)
	enemy.enemy_died.connect(death)


func update(delta: float):
	if _state: _state.update_state(delta)
	enemy.player_detect.look_at(enemy.player_ref.player_pos)
	
	if !_can_change_state: return
	var _can_see_player = can_see_player()
	
	if _can_see_player:
		var _can_walk = check_distance(enemy.walk_distance)
		var _can_shoot = check_distance(enemy.shoot_distance)
		
		if _can_shoot:
			shoot()
			return
		elif _can_walk:
			walk()
			return
	
	idle()


func idle():
	_can_change_state = true
	_state = states.idle
func walk():
	_can_change_state = true
	_state = states.walking
func shoot():
	_can_change_state = false
	if _state == states.shoot: _state.enter_state()
	else: _state = states.shoot
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












