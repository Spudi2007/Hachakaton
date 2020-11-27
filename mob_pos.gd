extends Node2D



var charactcer_node = get_parent()
var unit_scene
var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.get_child(0).aim = get_parent().get_node("walls/RigidBody2D")
		if child.name.substr(0,1) == "r":
			unit_scene = load("res://mobs/navigation_drone.tscn").instance()
			child.get_child(0).add_child(unit_scene)
			child.add_to_group('drones')
			print("adding child")
		
		elif child.name.substr(0,1) == "t":
			unit_scene = load("res://mobs/self-propelled_gun.tscn").instance()
			child.get_child(0).add_child(unit_scene)
#			print(child.get_child(0))
			print("adding child")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

