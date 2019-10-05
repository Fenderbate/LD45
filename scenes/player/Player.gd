extends KinematicBody2D

var dir = Vector2()
var motion = Vector2()
export(float)var speed = 100

var interact_target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if !get_parent().has_node("FollowCam"):
		print("asd")
		var cam = load("res://scenes/followcam/FollowCam.tscn").instance()
		cam.target_path = get_path()
		cam.global_position = global_position
		get_parent().call_deferred("add_child",cam)
	

func _physics_process(delta):
	
	dir = Vector2(
	int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
	int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	)
	
	motion = dir * speed
	
	motion = move_and_slide(motion)
	

func _input(event):
	
	if interact_target != null and event is InputEventKey and event.scancode == KEY_E and event.pressed:
		interact_target.interact()
	


func _on_InteractRange_area_entered(area):
	if area is Interactable:
		interact_target = area


func _on_InteractRange_area_exited(area):
	if interact_target == area:
		interact_target = null
