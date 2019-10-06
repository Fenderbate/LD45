extends Node2D

class_name PlayerBrawl

var meter = 50

var speed = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	
	meter -= 10 * delta * speed
	if meter <= 0:
		brawl_done()
		
	
	$CanvasLayer/Control/TextureProgress.value = meter
	

func _input(event):
	
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			meter += 10
			if meter > 100:
				brawl_done(false)
	

func brawl_done(lost = true):
	if lost and Global.pride > 0:
		Global.pride -= 1
	elif !lost:
		Global.pride += 1
	SignalHandler.emit_signal("player_active",true)
	queue_free()
