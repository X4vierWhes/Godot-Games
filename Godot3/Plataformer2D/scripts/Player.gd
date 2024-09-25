extends KinematicBody2D

var velocity = Vector2.ZERO #Movimentação em eixos X e Y / Movimentation in axis X and Y
var move_speed = 480 #Velocidade de movimento
var gravity = 1200
var jump_force = -720
var is_grounded
onready var raycasts = $raycasts

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta 
	
	_get_input()
	
	move_and_slide(velocity)
	
	is_grounded = _check_is_grounded()
	
	_set_animation()

func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) #movimentação dirita e esquerda
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$texture.scale.x = move_direction

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded: #se o jogador apertar "jump" e le estiver em solo, será feito o pulo.
		velocity.y = jump_force / 2

func _check_is_grounded() -> bool: #testando se o jogador está ao chão.
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _set_animation():
	var anim = "idle" #Animação padrão
	
	if !is_grounded: #se jogador nao estiver no chão, então está pulando.
		anim = "jump"
	elif velocity.x != 0: 
		anim = "run"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)
