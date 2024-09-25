extends Area2D

onready var Player = get_node("/root/Main/Player")


func _ready():
	var tipo = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = tipo[randi() % tipo.size()]

func _on_tesouro_body_entered(body):
	if body.name == "Player":
		Player.toma_tesouro(1)
		Player.toma_xp(10)
		queue_free()
