extends Area2D

signal hit

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var speed: int = 250
var screen_size
var input: Vector2

func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size

func start(pos: Vector2) -> void:
	show()
	collision.set_deferred("disabled", false)
	position = pos

func _unhandled_input(event: InputEvent) -> void:
	input = Input.get_vector("left", "right",
	"up", "down")
	

func _physics_process(delta: float) -> void:
	position += (input * speed) * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if input.length() > 0:
		if input.y != 0:
			sprite.play("up")
			sprite.flip_v = input.y > 0
		elif input.x != 0:
			sprite.play("walk")
			sprite.flip_h = input.x < 0
			
	else:
		sprite.pause()


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	collision.set_deferred("disabled", true)
	pass # Replace with function body.
