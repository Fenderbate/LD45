extends Interactable

export(String,"Food","Gold","Item")var hold = "Food"

var restock = false

# Called when the node enters the scene tree for the first time.
func _ready():
	detail = str("Steal ",hold.to_lower())


func interact():
	if used:
		return
	used = true
	print("stole ",hold)
	Global.greed += 1
	if hold == "Food":
		Global.gluttony += 1
	elif hold == "Gold":
		pass
		#Global.greed += 1
	elif hold == "Item":
		print("Item stealing has no funtion!")


func _on_Timer_timeout():
	restock = true


func _on_VisibilityEnabler2D_screen_exited():
	if restock:
		used = false
