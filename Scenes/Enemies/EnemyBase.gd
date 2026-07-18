class_name EnemyBase
extends CharacterBody3D


const WALKING_SPEED_SCALE_PARAM = "parameters/Walking/Speed/scale"
const HURT_SPEED_SCALE_PARAM = "parameters/Hurt/Speed/scale"
const MELEE_SPEED_SCALE_PARAM = "parameters/Attack/Melee/Speed/scale"
const SHOOT_SPEED_SCALE_PARAM = "parameters/Attack/Shoot/Speed/scale"
const THROW_SPEED_SCALE_PARAM = "parameters/Attack/Throw/Speed/scale"


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var tree_sm: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var tree_sm_attack: AnimationNodeStateMachinePlayback = animation_tree["parameters/Attack/playback"]


@onready var hit_box: HitBox = $HitBox
@onready var player_ref: PlayerRef = $PlayerRef
@onready var player_detect: RayCast3D = $PlayerDetect
@onready var nav_agent: NavigationAgent3D = $NavAgent
@onready var sfx: AudioStreamPlayer3D = $SFX
@onready var grunt_timer: Timer = $GruntTimer


@export var speed: float = 2.2
@export var walk_speed_scale: float = 1.5
@export var throw_speed_scale: float = 1.5
@export var shoot_speed_scale: float = 1.5
@export var melee_speed_scale: float = 1.5
@export var hurt_speed_scale: float = 1.5
@export var path_offset: float = 0.5


@export var fire_behavior: FireBehavior
@export var shoot_interval: float = 3.0
@export var shoot_accuracy: float = 0.7
@export var shoot_damage: float = 5
@export var melee_damage: float = 20
@export var melee_distance: float = 1.5


@export var death_sound: AudioStream
@export var grunt_sound: AudioStream
@export var pain_sound: AudioStream
@export var shoot_sound: AudioStream


func _ready() -> void:
	tree_sm.travel("Idle")
	animation_tree[WALKING_SPEED_SCALE_PARAM] = walk_speed_scale
	animation_tree[THROW_SPEED_SCALE_PARAM] = throw_speed_scale
	animation_tree[MELEE_SPEED_SCALE_PARAM] = melee_speed_scale
	animation_tree[SHOOT_SPEED_SCALE_PARAM] = shoot_speed_scale
	animation_tree[HURT_SPEED_SCALE_PARAM] = hurt_speed_scale


func _physics_process(_delta: float) -> void:
	player_detect.look_at(player_ref.player_pos)


func _on_hit_box_died() -> void:
	pass # Replace with function body.


func _on_hit_box_hit(damage_taken: int) -> void:
	pass # Replace with function body.


func _on_grunt_timer_timeout() -> void:
	pass # Replace with function body.
