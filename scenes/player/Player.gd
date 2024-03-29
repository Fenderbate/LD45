extends KinematicBody2D

class_name Player

var dir = Vector2()
var motion = Vector2()
export(float)var speed = 100

var interact_target = null

var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = weakref(self)
	
	$UI/PopupLabel.hide()
	
	if !get_parent().has_node("FollowCam"):
		var cam = load("res://scenes/followcam/FollowCam.tscn").instance()
		cam.target_path = get_path()
		cam.global_position = global_position
		get_parent().call_deferred("add_child",cam)
	
	SignalHandler.connect("player_active",self,"_on_player_active_changed")
	SignalHandler.connect("request_player",self,"on_player_requested")
	
	

func _physics_process(delta):
	
	if !active:
		$Sprite.hide()
		return
	
	dir = Vector2(
	int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
	int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	)
	
	motion = dir * speed
	
	motion = move_and_slide(motion)
	
	
	if dir != Vector2(0,0):
		if $AnimationPlayer.current_animation == "stand":
			$AnimationPlayer.play("walk")
	elif dir == Vector2(0,0):
		if $AnimationPlayer.current_animation == "walk":
			$AnimationPlayer.play("stand")
	

func _input(event):
	
	if !active:
		return
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE and interact_target != null:
			interact_target.interact()
			if !(interact_target is LustHouse):
				SignalHandler.emit_signal("player_did_bad")
			$UI/PopupLabel.hide()
			interact_target = null
		
		if event.scancode == KEY_Q:
			SignalHandler.emit_signal("window_show_pressed")
		
	
	
	

func _on_player_active_changed(state):
	active = state
	Global.player_active = state
	if state:
		$Sprite.show()
		$CollisionShape.set_deferred("disabled",false)
		$InteractRange/DetectionShape.set_deferred("disabled",false)
	else:
		$Sprite.hide()
		$CollisionShape.set_deferred("disabled",true)
		$InteractRange/DetectionShape.set_deferred("disabled",true)

func _on_InteractRange_area_entered(area):
	if area is Interactable and !area.used and interact_target == null:
		interact_target = area
		$UI/PopupLabel.text = str("Space\n",area.detail)
		$UI/PopupLabel.show()


func _on_InteractRange_area_exited(area):
	if interact_target == area:
		interact_target = null
		$UI/PopupLabel.hide()

func on_player_requested():
	SignalHandler.emit_signal("deliver_player",self)



func _on_AnimationPlayer_animation_started(anim_name):
	pass#print("started ",anim_name)
