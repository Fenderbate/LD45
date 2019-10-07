extends Interactable

export(String,"Food","Gold","Item")var hold = "Food"

var restock = false

# Called when the node enters the scene tree for the first time.
func _ready():
	detail = str("Steal ",hold.to_lower())
	randomize()
	$Items.texture = Global.stand_sprites[randi() % Global.stand_sprites.size()]


func interact():
	if used:
		return
	used = true
	$Timer.start()
	$Items.hide()
	print("stole ",hold)
	Global.greed += 1
	if hold == "Food":
		Global.gluttony += 1
	elif hold == "Gold":
		pass
		#Global.greed += 1
	elif hold == "Item":
		print("Item stealing has no funtion!")

func restock():
	
	randomize()
	$Items.texture = Global.stand_sprites[randi() % Global.stand_sprites.size()]
	$Items.show()
	restock = false
	used = false
	print("yum")
	

func _on_Timer_timeout():
	restock = true
	if !$VisibilityEnabler2D.is_on_screen():
		restock()


func _on_VisibilityEnabler2D_screen_exited():
	if restock:
		restock()
