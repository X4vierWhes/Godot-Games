extends Camera2D

onready var target = get_node("/root/Main/Player")

func _ready():
	pass

func _process(delta):
	position = target.position
