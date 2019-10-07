extends Node2D

var person = preload("res://scenes/person/Person.tscn")
var group = preload("res://scenes/people_group/PoepleGroup.tscn")


var last_pos = null
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalHandler.connect("remove_person",self,"on_person_removed")
	SignalHandler.connect("remove_group",self,"on_group_removed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func on_person_removed():
	var p = person.instance()
	
	randomize()
	var pivot = $LeftPivot if rand_range(0,100) >= 50 else $RightPivot
	
	p.global_position = Vector2(pivot.global_position.x, pivot.global_position.y + rand_range(-30,30))
	
	if pivot == $LeftPivot:
		p.dir = 1
	else:
		p.dir = -1
	get_parent().add_child(p)

func on_group_removed():
	var g = group.instance()
	
	randomize()
	var pos = $GroupPositions.get_children()[randi() % $GroupPositions.get_child_count()]
	
	if pos == last_pos:
		on_group_removed()
		return
	
	last_pos = pos
	
	g.global_position = pos.global_position + (Vector2(1,1.5) * rand_range(-20,20))
	
	get_parent().add_child(g)
	
	