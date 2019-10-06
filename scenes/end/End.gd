extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.no_sins():
		$GoodEnding.show()
	elif Global.max_sins():
		$RealEnding.show()
	else:
		$FakeEnding.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
