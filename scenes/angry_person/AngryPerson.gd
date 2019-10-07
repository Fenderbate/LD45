extends Area2D

var target = null

export(float)var speed = 80


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalHandler.connect("deliver_player",self,"on_player_delivered")
	SignalHandler.emit_signal("request_player")
	
	randomize()

func _physics_process(delta):
	
	if target != null:
		position += (target.global_position - position).normalized() * speed * delta
	



func on_player_delivered(player):
	target = player


func _on_AngryPerson_body_entered(body):
	if target != null and body == target:
		SignalHandler.emit_signal("player_active",false)
		
		var b = load("res://scenes/player_brawl/PlayerBrawl.tscn").instance()
		b.global_position = target.global_position
		get_parent().call_deferred("add_child",b)
		queue_free()

func _on_AngryPerson_area_entered(area):
	if area is PlayerBrawl:
		area.meter -= 20
		area.final_bonus += 1
		queue_free()
