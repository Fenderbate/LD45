extends Interactable

var stole = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	if stole:
		return
	print("Stole some money :v")
	stole = true
	Global.greed += 1
		