extends Position2D

export(NodePath)var target_path
export(float)var follow_delay = 5

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	target = get_node(target_path)
	

func _physics_process(delta):
	
	if target != null:
		
		global_position += (target.global_position - global_position) * delta * follow_delay
		
	
