extends KinematicBody2D

var vidas = 100
var spd = 300
var teasures = 0
var interactDist = 80
var xp = 10
var vel = Vector2() 
var facingDir = Vector2()
onready var ray = $RayCast2D
onready var anim = $aPlayer
signal criabomba
signal win
onready var ui = get_node("/root/Main/HUD")

func _ready():
	ui.att_life(vidas)
	ui.att_xp(xp)
	ui.att_teasures(teasures)
	$theme.play()

func _physics_process(delta):
	
	vel = Vector2()
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		facingDir = Vector2(0,-1)
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
		facingDir = Vector2(0,1)
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
		facingDir = Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
		facingDir = Vector2(1,0)
	vel = vel.normalized()
	move_and_slide(vel * spd, Vector2.ZERO)
	
	if Input.is_action_just_pressed("bomb") and xp >= 10:
		toma_xp(-10)
		emit_signal("criabomba")
		$putbomb.play()
	
	if Input.is_action_pressed("reiniciar"):
		get_tree().reload_current_scene()
	
	if vel.x > 0:
		play_animation("direita")
	elif vel.x < 0:
		play_animation("esquerda")
	elif vel.y < 0:
		play_animation("cima")
	elif vel.y > 0:
		play_animation("baixo")
	elif facingDir.x == 1:
		play_animation("pdireita")
	elif facingDir.x == -1:
		play_animation("pesquerda")
	elif facingDir.y == -1:
		play_animation("pcima")
	elif facingDir.y == 1:
		play_animation("pbaixo")

func death():
	get_tree().reload_current_scene()

func play_animation(anim_name):
	if anim.animation != anim_name:
		anim.animation = anim_name

func toma_tesouro(encontrado):
	teasures += encontrado
	ui.att_teasures(teasures)
	$teasure.play()
	if teasures == 6:
		$win.play()
		emit_signal("win")

func toma_xp(enemyXp):
	xp += enemyXp
	ui.att_xp(xp)

func toma_dano(hit):
	vidas -= hit
	ui.att_life(vidas)
	$damage.play()
	if vidas <= 0:
		$death.play()
		death()

func retX():
	return position.x

func retY():
	return position.y


func _on_music_timeout():
	$theme.play()
