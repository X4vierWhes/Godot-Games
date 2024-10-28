extends CharacterBody2D

var spd: float = 300.0
var health: float = 30.0
var state: String = "run"
var chase: bool = true

@onready var player = get_node("/root/Game/objPlayer")
@onready var ui = get_node("/root/Game")
@export var healthBar: ProgressBar
@export var stateTimer:Timer
@export var cooldownTimer: Timer
func _ready():
	%animPig.play(state)


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * spd
	velocity.normalized()
	if chase:
		move_and_slide()
	%animPig.play(state)
	if player.has_method("_getState"):
		var death:bool = player._getState()
		
		if death:
			queue_free()
		
	if direction.x != 0:
		%animPig.flip_h = (direction.x > 0)
	

func take_damage(dmg:float):
	health -= dmg
	healthBar.value = health
	state = "hurt"
	stateTimer.start()
	#%animPig.play("hurt")
	if health <= 0:
		ui._decrement()
		queue_free()
		
		const smokeS = preload("res://resources/smoke_explosion/smoke_explosion.tscn")
		var smoke = smokeS.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
	


func _atkPlayer(body: Node2D) -> void:
	if body.has_method("_take_damage"):
		body._take_damage(15.0)
		chase = false
		cooldownTimer.start()

func _on_state_timer_timeout() -> void:
	state = "run"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		_atkPlayer(body)


func _on_cooldown_timeout() -> void:
	chase = true
