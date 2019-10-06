extends Node

var player = null
var player_active = true

var floater = preload("res://scenes/floating_text/FloatingText.tscn")

#--------------------------------------------------------------------#

var last_floater_position = Vector2()

#--------------------------------------------------------------------#

var lust = 0 setget set_lust
var max_lust = 3
func set_lust(value):
	lust = generic_set_get(value,lust,max_lust,"Lust+")

var gluttony = 0setget set_gluttony
var max_gluttony = 3
func set_gluttony(value):
	gluttony = generic_set_get(value,gluttony,max_gluttony,"Gluttony+")

var greed = 0 setget set_greed
var max_greed = 3
func set_greed(value):
	greed = generic_set_get(value,greed,max_greed,"Greed+")

var sloth = 0 setget set_sloth
var max_sloth = 1
func set_sloth(value):
	sloth = generic_set_get(value,sloth,max_sloth,"Sloth+")

var wrath = 0 setget set_wrath
var max_wrath = 3
func set_wrath(value):
	wrath = generic_set_get(value,wrath,max_wrath,"Wrath+")

var envy = 0 setget set_envy
var max_envy = 3
func set_envy(value):
	envy = generic_set_get(value,envy,max_envy,"Envy+")

var pride = 0 setget set_pride
var max_pride = 3
func set_pride(value):
	pride = generic_set_get(value,pride,max_pride,"Pride+")

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
	pass # Replace with function body.

	
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
	f.global_position = target.global_position + (last_floater_position + (50 * Vector2(rand_range(-1,1),rand_range(-1,1))))
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