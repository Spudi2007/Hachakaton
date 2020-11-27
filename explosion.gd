extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ticks
var number1 = load("res://numbers/1.png")
var number2 = load("res://numbers/2.png")
var number3 = load("res://numbers/3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	ticks = 3
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var image
	if ticks == 3:
		image = number3
	if ticks == 2:
		image = number2
	if ticks == 1:
		image = number1
	get_node("Sprite").texture = image
	if ticks == 0:
		get_node("Timer").stop()
	ticks -= 1
