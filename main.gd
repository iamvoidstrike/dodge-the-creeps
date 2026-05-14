extends Node	

@onready var start_timer: Timer = $StartTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var mob_timer: Timer = $MobTimer
@onready var player: Area2D = $Player
@onready var start_position: Marker2D = $StartPosition
@onready var mob_spawn_location: PathFollow2D = $MobPath/MobSpawnLocation
@onready var hud: CanvasLayer = $HUD
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var music: AudioStreamPlayer2D = $Music

@export var mob_scene: PackedScene
var score: int

func game_over() -> void:
	score_timer.stop()
	mob_timer.stop()
	hud.show_gameover()
	
	music.stop()
	death_sound.play()

func new_game() -> void:
	score = 0
	player.start($StartPosition.position)
	start_timer.start()
	hud.update_score(score)
	hud.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	music.play()


func _on_start_timer_timeout() -> void:
	mob_timer.start()
	score_timer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	hud.update_score(score)


func _on_mob_timer_timeout() -> void:
	var mob: RigidBody2D = mob_scene.instantiate()
	mob_spawn_location.progress_ratio = randf_range(0.0, 1.0)
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
