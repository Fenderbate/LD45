extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Window.hide()
	SignalHandler.connect("window_show_pressed",self,"on_window_show_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_window_show_pressed():
	$Window.show()

func _on_Yes_button_down():
	print("go to ending screen")
	SignalHandler.emit_signal("player_active",false)
	SignalHandler.emit_signal("go_sleep")
	$Window.hide()


func _on_No_button_down():
	$Window.hide()

