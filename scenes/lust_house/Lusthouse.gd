extends Interactable

class_name LustHouse

var player_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.hide()

func interact():
	
	player_inside = true
	SignalHandler.emit_signal("player_active",false)
	$Particles2D.emitting = true
	$Timer.start()
	$CanvasLayer/Info.show()

func _input(event):
	if event is InputEventKey and event.scancode == KEY_SPACE and event.pressed and player_inside:
		player_inside = false
		SignalHandler.emit_signal("player_active",true)
		$Particles2D.emitting = false
		$Timer.stop()
		$CanvasLayer/Info.hide()

func _on_Timer_timeout():
	Global.lust += 1
	
