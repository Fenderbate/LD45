extends Position2D

export(NodePath)var target_path
export(float)var follow_delay = 5

var sin_decriptions = [
"Lust\n\n",
"Gluttony\n\n",
"Greed\n\n",
"Sloth\n\n",
"Wrath\n\n",
"Envy\n\n",
"Pride\n\n"
]
var sin_page = 0

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalHandler.connect("sins_changed",self,"update_meters")
	
	target = get_node(target_path)
	$Camera2D/CanvasLayer/UI/SinDescription/ScrollContainer/DescriptionLabel.text = sin_decriptions[sin_page]

func _physics_process(delta):
	
	if target != null:
		
		global_position += (target.global_position - global_position) * delta * follow_delay
		
	$Camera2D/CanvasLayer/UI/SinDescription/ScrollContainer/DescriptionLabel.text = sin_decriptions[sin_page]
	
	update_meters()
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_LEFT and sin_page > 0:
			sin_page -= 1
		elif event.scancode == KEY_RIGHT and sin_page < sin_decriptions.size() - 1:
			sin_page += 1
		if event.scancode == KEY_SPACE:
			$Camera2D/CanvasLayer/UI/SinDescription.visible = !$Camera2D/CanvasLayer/UI/SinDescription.visible
		
	

func update_meters():
	$Camera2D/CanvasLayer/UI/SinContainer/Lust.value = float(Global.lust) / Global.max_lust
	$Camera2D/CanvasLayer/UI/SinContainer/Gluttony.value = float(Global.gluttony) / Global.max_gluttony
	$Camera2D/CanvasLayer/UI/SinContainer/Greed.value = float(Global.greed) / Global.max_greed
	$Camera2D/CanvasLayer/UI/SinContainer/Sloth.value = float(Global.sloth) / Global.max_sloth
	$Camera2D/CanvasLayer/UI/SinContainer/Wrath.value = float(Global.wrath) / Global.max_wrath
	$Camera2D/CanvasLayer/UI/SinContainer/Envy.value = float(Global.envy) / Global.max_envy
	$Camera2D/CanvasLayer/UI/SinContainer/Pride.value = float(Global.pride) / Global.max_pride

func _on_Left_button_down():
	if sin_page > 0:
		sin_page -= 1


func _on_Right_button_down():
	if sin_page < sin_decriptions.size() - 1:
		sin_page += 1
