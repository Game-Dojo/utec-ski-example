extends CharacterBody2D

@onready var visuals: Sprite2D = $Visuals
@onready var shape: CollisionShape2D = $CollisionShape2D

const GRAVITY = 0.2
const MOVE_SPEED = 1

var movement = 0
var jump_tween

func _process(_delta: float) -> void:
	if Input.is_action_pressed("left"):
		movement = -1
	elif Input.is_action_pressed("right"):
		movement = 1
	else:
		movement = 0
	
func _physics_process(_delta: float) -> void:
	if movement == -1:
		velocity.x -= MOVE_SPEED
	elif movement == 1:
		velocity.x += MOVE_SPEED
		
	velocity.y += GRAVITY
	move_and_slide()

func jump() -> void:
	shape.set_deferred("disabled", true)
	
	if jump_tween: jump_tween.kill()
	jump_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	jump_tween.tween_property(visuals, "position:y", -10, 0.7)
	jump_tween.tween_property(visuals, "position:y", 0, 0.3)
	await jump_tween.finished
	
	shape.set_deferred("disabled", false)
