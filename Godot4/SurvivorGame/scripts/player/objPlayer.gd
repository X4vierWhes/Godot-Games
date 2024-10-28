extends CharacterBody2D
class_name Player

var spd: float = 600.0
var health: float = 100.0
var death:bool = false

func _physics_process(delta):
	#vetor de direções 
	var direction = Input.get_vector(
		"move_left","move_right",
		"move_up", "move_down")
	#guarda a direção do personagem 
	#multiplicando pela velocidade
	velocity = direction * spd
	#velocity.normalized()
	#move o personagem "arrastando" pouco a pouco
	move_and_slide()
	
	if Input.is_action_just_pressed("heal_player"):
		health = 100.0
		%ProgressBar.value = health
	#Muda a direção do sprite se ele estiver indo para a esquerda
	if direction.x != 0:
		%animPlayer.flip_h = (direction.x < 0)
	#Reproduz as animações do animatedSprite
	if velocity.length() > 0.0:
		#se o vetor de direção não for 0, o personagem estara correndo
		%animPlayer.play("run") 
	else:
		#se vetor for 0, estara parado
		%animPlayer.play("idle")
	
	if Input.is_action_just_pressed("shoot"):
		%obj_Gun.shoot(1)
	

func _take_damage(dmg:float) -> void:
	health -= dmg
	%ProgressBar.value = health
	if health <= 0.0:
		death = true

func _getState() -> bool:
	return death
