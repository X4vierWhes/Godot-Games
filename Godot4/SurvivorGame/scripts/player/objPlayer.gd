extends CharacterBody2D

var spd: float = 600.0
var health: float = 100.0
var death:bool = false

func _physics_process(delta):
	#vetor de direções 
	var direction = Input.get_vector(
		"move_left","move_right",
		"move_up", "move_down")
	#guarda a direção do personegem 
	#multiplicando pela velocidade
	velocity = direction * spd
	#velocity.normalized()
	#move o personagem "arrastando" pouco a pouco
	move_and_slide()
	
	if Input.is_action_pressed("heal_player"):
		health += 50
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
	
	const damage_rate = 15.0
	var overlaping_mobs = %hurtBox.get_overlapping_bodies()
	#print(overlaping_mobs.size())
	if overlaping_mobs.size() > 1:
		health -= damage_rate * overlaping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			death = true

func _getState() -> bool:
	return death
