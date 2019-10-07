extends Node

var player = null
var player_active = true

var people = []

var floater = preload("res://scenes/floating_text/FloatingText.tscn")


#--------------------------------------------------------------------#

var last_floater_position = Vector2()

var people_sprites = [
#preload("res://sprites/Npc_1_idle.png"),
preload("res://sprites/Npc_2_idle.png"),
preload("res://sprites/Npc_3_idle.png"),
preload("res://sprites/Npc_4_idle.png"),
preload("res://sprites/Npc_5_idle.png"),
preload("res://sprites/Npc_6_idle.png"),
preload("res://sprites/Npc_7_idle.png"),
preload("res://sprites/Npc_8_idle.png")
]

var stand_sprites = [
preload("res://sprites/stand_items_1.png"),
preload("res://sprites/stand_items_2.png")
]

#--------------------------------------------------------------------#

var lust = 0 setget set_lust
var max_lust = 10
func set_lust(value):
	lust = generic_set_get(value,lust,max_lust,"Lust+" if value >= lust else "Lust-")

var gluttony = 0setget set_gluttony
var max_gluttony = 10
func set_gluttony(value):
	gluttony = generic_set_get(value,gluttony,max_gluttony,"Gluttony+" if value >= gluttony else "Gluttony-")

var greed = 0 setget set_greed
var max_greed = 10
func set_greed(value):
	greed = generic_set_get(value,greed,max_greed,"Greed+" if value >= greed else "Greed-")

var sloth = 0 setget set_sloth
var max_sloth = 1
func set_sloth(value):
	sloth = generic_set_get(value,sloth,max_sloth,"Sloth+" if value >= sloth else "Sloth-")

var wrath = 0 setget set_wrath
var max_wrath = 10
func set_wrath(value):
	wrath = generic_set_get(value,wrath,max_wrath,"Wrath+" if value >= wrath else "Wrath-")

var envy = 0 setget set_envy
var max_envy = 10
func set_envy(value):
	envy = generic_set_get(value,envy,max_envy,"Envy+" if value >= envy else "Envy-")

var pride = 0 setget set_pride
var max_pride = 10
func set_pride(value):
	pride = generic_set_get(value,pride,max_pride,"Pride+" if value >= pride else "Pride-")

# generic_set_get(value,var1,var2,"N/A")

func generic_set_get(new_value, base_var, max_var, floater_text):
	base_var = new_value
	if player != null and player.get_ref():
		spawn_floater(player.get_ref(),floater_text)
	if base_var > max_var:
		base_var = max_var
	return base_var

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalHandler.connect("signal_presence",self,"on_presence_singaled")
	SignalHandler.connect("player_did_bad",self,"pn_player_done_bad")

	
func reset():
	lust = 0
	gluttony = 0
	greed = 0
	sloth = 0
	wrath = 0
	envy = 0
	pride = 0

func spawn_floater(target, text = ""):
	var f = floater.instance()
	f.text = text
	randomize()
	f.global_position = target.global_position + (last_floater_position + (10 * Vector2(rand_range(-1,1),rand_range(-1,1))))
	target.get_parent().call_deferred("add_child",f)


func max_sins():
	if lust == max_lust and gluttony == max_gluttony and greed == max_greed and wrath == max_wrath and envy == max_envy and pride == max_pride:
		return true
	return false

func no_sins():
	if lust == 0 and gluttony == 0 and greed == 0 and wrath == 0 and envy == 0 and pride == 0 and sloth == 0:
		return true
	print(lust,gluttony,greed,sloth,wrath,envy,pride)
	return false

func select_angry_person():
	randomize()
	
	if people.size() <= 0:
		return
	
	var index = randi() % people.size()
	
	if people[index].get_ref():
		people[index].get_ref().get_angry()
	else:
		select_angry_person()
	

func pn_player_done_bad():
	randomize()
	if rand_range(0,100) > 60:
		people = []
		SignalHandler.emit_signal("request_presence")
	
		yield(get_tree().create_timer(0.15),"timeout")
		select_angry_person()
	

func on_presence_singaled(present_object):
	people.append(present_object)
