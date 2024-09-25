extends Node2D

var flyaway = 0
var capture = 0
var patosnatela
var pato = preload("res://scenes/pato.tscn")

func _ready():
	$gerarpato.start()

func _process(delta):
	
	$hud/contador.text = str(capture)
	$alvo.position.x = get_local_mouse_position().x
	$alvo.position.y = get_local_mouse_position().y
	

func nasce():
	var novopato = pato.instance()
	
	add_child(novopato)
	novopato.position.x = rand_range(50, 700)
	novopato.position.y = 700

func _on_gerarpato_timeout():
	patosnatela = int(rand_range(1, 6))
	for i in patosnatela:
		nasce()


func _on_espera_timeout():
	$gerarpato.start()


func _on_top_body_entered(body):
	flyaway = 1
	patosnatela -= 1
	$fly.play()
	atualizarturno()


func _on_ground_body_entered(body):
	capture += 1
	patosnatela -= 1
	$capt.play()
	atualizarturno()

func atualizarturno():
	
	if (patosnatela == 0):
		$espera.start()
		if (flyaway == 1):
			$cao.play("rindo")
			$caoRindo.play()
			capture = 0
			flyaway = 0
		else:
			$cao.play("captura")
			$caoCaptura.play()
			

