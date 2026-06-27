extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
const DISTANCIA_BOLA_X = 15.0 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite_jogador = $AnimatedSprite2D
@onready var sprite_bola = $Bola

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSfx.play()

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		sprite_jogador.play("run")
		
		if sprite_bola:
			sprite_bola.play("default") 
			if direction == -1:
				sprite_jogador.flip_h = true
				sprite_bola.position.x = -DISTANCIA_BOLA_X
			else:
				sprite_jogador.flip_h = false
				sprite_bola.position.x = DISTANCIA_BOLA_X
	else:
		sprite_jogador.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)
		if sprite_bola:
			sprite_bola.stop()

	if not is_on_floor():
		sprite_jogador.play("jump")

	move_and_slide()
