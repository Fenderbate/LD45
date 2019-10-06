extends Interactable

class_name LustHouse

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	
	if used:
		return
	used = true
	SignalHandler.emit_signal("player_active",false)
	Global.lust += 1
	$Timer.start()


func _on_Timer_timeout():
	SignalHandler.emit_signal("player_active",true)
