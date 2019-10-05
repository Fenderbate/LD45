extends Node

var lust = 0
var max_lust = 3

var gluttony = 0
var max_gluttony = 3

var greed = 0
var amx_greed = 3

var sloth = 0
var max_sloth = 3

var wrath = 0
var max_wrath = 3

var envy = 0
var max_envy = 3

var pride = 0
var max_pride = 3

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