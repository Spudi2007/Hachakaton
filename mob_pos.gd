extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var charactcer_node = get_parent()
var unit_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.get_child(0).aim = get_parent().get_node("walls/RigidBody2D")
		if child.name.substr(0,1) == "r":
			unit_scene = load("res://mobs/navigation_drone.tscn").instance()
			child.add_child(unit_scene)
			print("adding child")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

