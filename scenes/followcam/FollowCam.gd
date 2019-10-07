extends Position2D

export(NodePath)var target_path
export(float)var follow_delay = 5

var sin_decriptions = [
"Lust\n\nThis sin is related to making love for one's self amusement.",
"Gluttony\n\nThis sin is related to unnecessary overconsumption of food.",
"Greed\n\nThis sin is related to one's desire of posessing things.",
"Sloth\n\nThis sin is related to one's self loathing and laziness.",
"Wrath\n\nThis sin is related to the enjoyment of violence.",
"Envy\n\nThis sin is related to one's enjoyment of the suffering of others.",
"Pride\n\nThis sin is related to one's belief of being greater and better than others."
]
var sin_page = 0

var target = null

var tablet = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalHandler.connect("sins_changed",self,"update_meters")
	SignalHandler.connect("go_sleep",self,"on_gone_sleep")
	
	target = get_node(target_path)
	$Camera2D/CanvasLayer/UI/SinDescription/ScrollContainer/DescriptionLabel.text = sin_decriptions[sin_page]

func _physics_process(delta):
	
	if target != null:
		
		global_position += (target.global_position - global_position) * delta * follow_delay
		
	$Camera2D/CanvasLayer/UI/SinDescription/ScrollContainer/DescriptionLabel.text = sin_decriptions[sin_page]
	
	update_meters()
	
func _input(event):
	if Global.player_active and event is InputEventKey and event.pressed:
		if event.scancode == KEY_LEFT and sin_page > 0:
			sin_page -= 1
		elif event.scancode == KEY_RIGHT and sin_page < sin_decriptions.size() - 1:
			sin_page += 1
		if event.scancode == KEY_E:
			if !tablet:
				$Camera2D/CanvasLayer/UI/SinDescription/DescriptionAP.play("tablet_up")
				tablet = true
				return
			elif tablet:
				$Camera2D/CanvasLayer/UI/SinDescription/DescriptionAP.play("tablet_down")
				tablet = false
				return
			#$Camera2D/CanvasLayer/UI/SinDescription.visible = !$Camera2D/CanvasLayer/UI/SinDescription.visible
		
	

func update_meters():
	$Camera2D/CanvasLayer/UI/SinContainer/Lust.value =1.0 - float(Global.lust) / Global.max_lust
	$Camera2D/CanvasLayer/UI/SinContainer/Gluttony.value = 1.0 - float(Global.gluttony) / Global.max_gluttony
	$Camera2D/CanvasLayer/UI/SinContainer/Greed.value = 1.0 - float(Global.greed) / Global.max_greed
	$Camera2D/CanvasLayer/UI/SinContainer/Sloth.value = 1.0 - float(Global.sloth) / Global.max_sloth
	$Camera2D/CanvasLayer/UI/SinContainer/Wrath.value = 1.0 - float(Global.wrath) / Global.max_wrath
	$Camera2D/CanvasLayer/UI/SinContainer/Envy.value = 1.0 - float(Global.envy) / Global.max_envy
	$Camera2D/CanvasLayer/UI/SinContainer/Pride.value = 1.0 - float(Global.pride) / Global.max_pride

func _on_Left_button_down():
	if sin_page > 0:
		sin_page -= 1


func _on_Right_button_down():
	if sin_page < sin_decriptions.size() - 1:
		sin_page += 1

func on_gone_sleep():
	$Camera2D/CanvasLayer/AnimationPlayer.play("fade_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		if Global.max_sins():
			Global.sloth = Global.max_sloth
		print("move sloth setting up from the followcam script!!")
		get_tree().change_scene("res://scenes/end/End.tscn")
