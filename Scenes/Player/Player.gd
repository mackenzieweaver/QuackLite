class_name Player
extends CharacterBody3D
const GROUP_NAME: String = "Player"


@export var speed = 5.0
@export_range(0.0, 0.5) var deceleration: float = 0.25
@export var jump_speed = 15
@export var sensitivity: float = 0.012
@export var gravity: float = -30.0


# TODO play sounds appropriately
const WALK_SOUND = preload("res://assets/Sounds/concrete-footsteps-6752.wav")
const STOP_SOUND = preload("res://assets/Sounds/concrete-footsteps-stop.wav")
const JUMP_SOUND = preload("res://assets/Sounds/667297_jump_05.wav")
const DEATH_SOUND = preload("res://assets/Sounds/469567__PlayerDie.wav")


@onready var walking_sound: AudioStreamPlayer3D = $WalkingSound
@onready var landing_sound: AudioStreamPlayer3D = $LandingSound
@onready var pains: AudioStreamPlayer3D = $Pains
@onready var hit_box: HitBox = $HitBox
@onready var camera: Camera3D = $Camera


var _was_moving: bool = false
var _was_on_floor: bool = false
var _mouse_delta: Vector2


const max_rotation_angle = PI / 2


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_delta = event.relative * -1


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _physics_process(delta: float) -> void:
	aim(delta)
	move_airborne(delta)
	move_grounded(delta)


func aim(_delta: float):
	rotate_y(_mouse_delta.x * sensitivity)
	camera.rotate_x(_mouse_delta.y * sensitivity)
	camera.rotation.x = clamp(camera.rotation.x, -max_rotation_angle, max_rotation_angle)
	_mouse_delta = Vector2.ZERO


func move_airborne(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed


func move_grounded(_delta: float):
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction.length():
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
	move_and_slide()


func play_footsteps() -> void:
	walking_sound.stream = WALK_SOUND
	walking_sound.play()


func play_stop_sound():
	walking_sound.stop()
	walking_sound.stream = STOP_SOUND
	walking_sound.play()


func play_jump_sound():
	walking_sound.stop()
	walking_sound.stream = JUMP_SOUND
	walking_sound.play()
