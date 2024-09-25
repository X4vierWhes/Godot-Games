extends CanvasLayer
class_name UI

@onready var EnemiesInScreen = %EnemiesInScreen
@onready var Points = %Points

func _update_enemies_label(value:int):
	EnemiesInScreen.text = "Enemies: " + str(value)

func _upadate_points_label(value:int):
	Points.text = "Points: " + str(value)
