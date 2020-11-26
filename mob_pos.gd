extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var charactcer_node = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.get_child(0).aim = get_parent().get_node("walls/RigidBody2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

