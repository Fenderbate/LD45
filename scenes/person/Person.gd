extends Interactable


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalHandler.connect("request_presence",self,"on_presence_requested")

func interact():
	if used:
		return
	used = true
	Global.greed += 1
		

func get_angry():
	
	var a = load("res://scenes/angry_person/AngryPerson.tscn").instance()
	a.global_position = global_position
	get_parent().add_child(a)
	queue_free()
	print("person should get angry")

func on_presence_requested():
	if $VisibilityNotifier2D.is_on_screen():
		SignalHandler.emit_signal("signal_presence",weakref(self))
