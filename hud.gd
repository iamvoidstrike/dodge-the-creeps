extends CanvasLayer

signal start_game

@onready var score_label: Label = $ScoreLabel
@onready var start_button: Button = $StartButton
@onready var message: Label = $Message
@onready var message_timer: Timer = $MessageTimer
func show_message(text: String):
	message.show()
	message.text = text
	message_timer.start()

func show_gameover():
	show_message("GameOver")
	await message_timer.timeout
	
	show_message("Dodge The Creeps")
	message.show()
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(score: int):
	score_label.text = str(score)

func _on_start_button_pressed() -> void:
	start_button.hide()
	start_game.emit()
	pass # Replace with function body.

func _on_message_timer_timeout() -> void:
	message.hide()
	pass # Replace with function body.
