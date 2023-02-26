extends CanvasLayer

onready var barravidas = get_node("life")
onready var barraxp = get_node("xp")
onready var texto = get_node("Label")

func _ready():
	pass

func att_life(vidas):
	barravidas.value = vidas

func att_xp(xp):
	barraxp.value = xp

func att_teasures(tesouros):
	texto.text = "Tesouros: " + str(tesouros)
