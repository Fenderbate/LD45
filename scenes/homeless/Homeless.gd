extends Interactable



# Called when the node enters the scene tree for the first time.
func _ready():
	detail = "Kick"

func interact():
	if used:
		return
	Global.pride += 1
	used = true
	$Knocked.show()
	$Sprite.hide()
	$Timer.start()

func _on_Timer_timeout():
	$Sprite.show()
	$Knocked.hide()
	used = false


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimTimer.wait_time = rand_range(1,5)
	$AnimTimer.start()


func _on_AnimTimer_timeout():
	randomize()
	if rand_range(0,100) > 50:
		$AnimationPlayer.play("drink")
		return
	$AnimTimer.wait_time = rand_range(1,5)
	$AnimTimer.start()
