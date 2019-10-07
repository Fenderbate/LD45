extends Interactable

export(bool)var pre_placed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Group/Person1.texture = Global.people_sprites[randi() % Global.people_sprites.size()]
	$Group/Person2.texture = Global.people_sprites[randi() % Global.people_sprites.size()]
	
	$Group/Person3.frame = randi() % $Group/Person3.hframes
	
	if pre_placed:
		$Group.show()
		$StaticBody2D/BumbCol.disabled = false
		$CollisionShape2D.disabled = false

func interact():
	
	if used:
		return
	$Group.hide()
	$Sprite.show()
	$Sprite.texture = load("res://sprites/fight_cloud.png")
	$Sprite.hframes = 2
	$AnimationPlayer.play("fight")
	$Timer.start()
	Global.envy += 1
	Global.wrath += 1
	used = true


func _on_Timer_timeout():
	SignalHandler.emit_signal("remove_group")
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	if !pre_placed and !$VisibilityNotifier2D.is_on_screen():
		$Group.show()
		$StaticBody2D/BumbCol.disabled = false
		$CollisionShape2D.disabled = false
