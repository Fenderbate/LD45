extends Interactable


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	if used:
		return
	Global.pride += 1
	used = true