extends YSort

var music_muted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.reset()

func _input(event):
	
	if event is InputEventKey and event.scancode == KEY_M and event.pressed:
		
		if !music_muted:
			$Music.volume_db = -100
		else:
			$Music.volume_db = -20
		music_muted = !music_muted
	


