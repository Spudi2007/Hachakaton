extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ticks
var number1 = load("res://numbers/1.png")
var number2 = load("res://numbers/2.png")
var number3 = load("res://numbers/3.png")
var bodies = []
var a = 3.0
var damaging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ticks = 3
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !damaging:
		return
	a -= delta
	for body in bodies:
		if body.name != 'walls':
			body.take_damage(delta * 100)
	if a < 0:
		self.queue_free()

func _on_Timer_timeout():
	var image
#	if ticks == 3:
#		image = number3
	if ticks == 3:
		image = number2
	if ticks == 2:
		image = number1
	get_node("Sprite").texture = image
	if ticks == 1:
		get_node("CPUParticles2D").emitting = true
		get_node("CPUParticles2D2").emitting = true
		damaging = true
		get_node("Sprite").hide()
		get_node("Timer").stop()
	ticks -= 1


func _on_Area_body_entered(body):
	bodies.append(body)
	pass # Replace with function body.


func _on_Area_body_exited(body):
	bodies.erase(body)
	pass # Replace with function body.
