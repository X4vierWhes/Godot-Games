extends KinematicBody2D

var spd = 200
var xp = 20
var dano = 20
var timeAtk = 1.0
var distanceAtk = 100
var distanceVision = 400

onready var timer = $Timer
onready var target = get_node("/root/Main/Player")

func _ready():
	timer.wait_time = timeAtk
	timer.start()

func _physics_process(delta):
	var dist = position.distance_to(target.position)
	if dist > distanceAtk and dist < distanceVision:
		var vel = (target.position - position).normalized()
		move_and_slide(vel * spd)

func death():
	target.toma_xp(xp)
	queue_free()


func _on_Timer_timeout():
	if position.distance_to(target.position) <= distanceAtk:
		target.toma_dano(dano)
