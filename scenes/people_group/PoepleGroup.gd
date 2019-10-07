extends Interactable


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	
	if used:
		return
	$Sprite.texture = load("res://sprites/fight_cloud.png")
	$Sprite.hframes = 2
	$AnimationPlayer.play("fight")
	$Timer.start()
	Global.envy += 1
	Global.wrath += 1
	used = true


func _on_Timer_timeout():
	queue_free()
