extends Interactable


var dir = 0

var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalHandler.connect("request_presence",self,"on_presence_requested")
	randomize()
	$Sprite.texture = Global.people_sprites[randi() % Global.people_sprites.size()]
	
	randomize()
	dir = 1 if rand_range(0,100) >= 50 else -1
	
	speed += rand_range(-10,10)

func _physics_process(delta):
	
	position.x += dir * speed * delta
	

func interact():
	if used:
		return
	used = true
	Global.greed += 1
	$Timer.start()

func get_angry():
	
	var a = load("res://scenes/angry_person/AngryPerson.tscn").instance()
	a.global_position = global_position
	a.get_node("Sprite").texture = $Sprite.texture
	get_parent().add_child(a)
	queue_free()
	print("person should get angry")

func on_presence_requested():
	if $VisibilityNotifier2D.is_on_screen():
		SignalHandler.emit_signal("signal_presence",weakref(self))


func _on_WallDetector_body_entered(body):
	if body.is_in_group("Bounds"):
		dir = dir * -1


func _on_Timer_timeout():
	used = false
