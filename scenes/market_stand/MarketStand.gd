extends Interactable

export(String,"Food","Gold","Item")var hold = "Food"

var stole = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	if stole:
		return
	print("stole ",hold)
	Global.greed += 1
	if hold == "Food":
		Global.gluttony += 1
	elif hold == "Gold":
		Global.greed += 1
	elif hold == "Item":
		print("Item stealing has no funtion!")
