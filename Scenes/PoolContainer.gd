extends Node3D

const AMMO_COLLECT = preload("res://Assets/Sounds/AmmoCollect.wav")
const POWERUP = preload("res://Assets/Sounds/523655__powerup.wav")

@onready var sounds: AudioStreamPlayer = $Sounds

const SoundsDict: Dictionary[GameUtils.SoundType, AudioStream] = {
	GameUtils.SoundType.AmmoPickUp: AMMO_COLLECT,
	GameUtils.SoundType.HealthBoost: POWERUP,
}

func _ready() -> void:
	await get_tree().process_frame
	ObjectPool.init_pools(self)
	SignalHub.on_play_sound.connect(handle_play_sound)


func handle_play_sound(key: GameUtils.SoundType):
	if !SoundsDict.has(key): return
	sounds.stop()
	sounds.stream = SoundsDict[key]
	sounds.play()











