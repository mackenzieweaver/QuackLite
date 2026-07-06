class_name Player
extends CharacterBody3D
const GROUP_NAME: String = "Player"


@export var speed = 5.0
@export_range(0.0, 0.5) var deceleration: float = 0.25
@export var jump_speed = 15
@export var sensitivity: float = 0.0012
@export var gravity: float = -30.0

@onready var walking: AudioStreamPlayer3D = $Walking
@onready var stopping: AudioStreamPlayer3D = $Stopping
@onready var jumping: AudioStreamPlayer3D = $Jumping
@onready var landing: AudioStreamPlayer3D = $Landing
@onready var pains: AudioStreamPlayer3D = $Pains
@onready var hit_box: HitBox = $HitBox
@onready var camera: Camera3D = $Camera


enum states {
	idle,    # 0
	walking, # 1
	jumping, # 2
	falling, # 3
}

var _mouse_delta: Vector2
var _prev_state: states
var _state := states.idle:
	set(value):
		_prev_state = _state
		_state = value
		#print(_prev_state, _state)


const max_rotation_angle = PI / 2


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_delta = event.relative * -1
	if event is InputEventKey and event.as_text() == "Escape":
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _physics_process(delta: float) -> void:
	aim(delta)
	move_xz(delta)
	move_y(delta)
	play_sounds()


func aim(_delta: float):
	rotate_y(_mouse_delta.x * sensitivity)
	camera.rotate_x(_mouse_delta.y * sensitivity)
	camera.rotation.x = clamp(camera.rotation.x, -max_rotation_angle, max_rotation_angle)
	_mouse_delta = Vector2.ZERO


func move_y(delta: float):
	if !is_on_floor():
		velocity.y += gravity * delta
		_state = states.falling
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		_state = states.jumping


func move_xz(_delta: float):
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction.length():
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if is_on_floor(): _state = states.walking
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
		if is_on_floor(): _state = states.idle
	
	move_and_slide()


func play_sounds():
	# Sounds only play for state changes
	if _prev_state == _state: return
	
	if _prev_state != states.walking and _state == states.walking:
		walking.play()
	
	# Walking sound loops so need to stop it manually
	if _prev_state == states.walking and _state != states.walking:
		walking.stop()
	
	# Was walking, now idle, play stopping sound
	if _prev_state == states.walking and _state == states.idle:
		stopping.play()
	
	# Was falling, now not falling, play landing sound
	if _prev_state == states.falling and _state != states.falling:
		landing.play()
	
	# Was not jumping, now is jumping, play jump sound
	if _prev_state != states.jumping and _state == states.jumping:
		jumping.play()











