extends Node

var player

var floater = preload("res://scenes/floating_text/FloatingText.tscn")

#--------------------------------------------------------------------#

var last_floater_position = Vector2()

#--------------------------------------------------------------------#

var lust = 0 setget set_lust
var max_lust = 3
func set_lust(value):
	generic_set_get(value,lust,max_lust,"Lust+")

var gluttony = 0setget set_gluttony
var max_gluttony = 3
func set_gluttony(value):
	generic_set_get(value,gluttony,max_gluttony,"Gluttony+")

var greed = 0 setget set_greed
var max_greed = 3
func set_greed(value):
	generic_set_get(value,greed,max_greed,"Greed+")

var sloth = 0
var max_sloth = 3

var wrath = 0
var max_wrath = 3

var envy = 0
var max_envy = 3

var pride = 0
var max_pride = 3


# generic_set_get(value,var1,var2,"N/A")

func generic_set_get(new_value, base_var, max_var, floater_text):
	base_var = new_value
	spawn_floater(player,floater_text)
	if base_var > max_var:
		base_var = max_var

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func reset_sins():
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
