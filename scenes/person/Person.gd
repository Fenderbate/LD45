extends Interactable

var used = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	if used:
		return
	used = true
	print("Stole some money :v")
	Global.greed += 1
		