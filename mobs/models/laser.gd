extends Node2D


# Declare member variables here. Examples:
var from 
var to


# Called when the node enters the scene tree for the first time.
func _ready():
#	print(to)
#	print(self.global_position)
	look_at(to)
	self.scale.x *= (to-self.global_position).length() / 7.5
#	update()
	pass # Replace with function body.
#func _process(delta):
#	print(self.global_position)

func _draw():
	draw_line(self.global_position, to, 10)
