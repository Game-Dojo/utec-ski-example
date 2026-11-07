extends CharacterBody2D

@onready var visuals: AnimatedSprite2D = $Visuals
@onready var shape: CollisionShape2D = $CollisionShape2D
@onready var trail: Sprite2D = $Trail

const GRAVITY = 0.12
const MOVE_SPEED = 1.1
const MAX_VELOCITY_Y = 55
const MIN_VELOCITY_Y = 16

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
	# Se mueve horizontal solo si tiene la velocidad necesaria
	if velocity.y > MIN_VELOCITY_Y:
		velocity.x += movement * MOVE_SPEED
	
	# Limitamos la velocidad total
	if velocity.y <= MAX_VELOCITY_Y:
		velocity.y += GRAVITY
	
	move_and_slide()

func jump() -> void:
	shape.set_deferred("disabled", true)
	trail.visible = false
	
	var tw = create_tween()
	tw.tween_property(visuals, "scale", Vector2.ONE * 1.2, 0.7 )
	tw.tween_property(visuals, "scale", Vector2.ONE, 0.2 )
	
	if jump_tween: jump_tween.kill()
	jump_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	jump_tween.tween_property(visuals, "position:y", -10, 0.7)
	jump_tween.tween_interval(0.08) # Esperamos un momento en el peak del salto
	jump_tween.tween_property(visuals, "position:y", 0, 0.2)
	await jump_tween.finished
	trail.visible = true
	shape.set_deferred("disabled", false)
