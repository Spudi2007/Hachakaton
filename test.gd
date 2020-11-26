extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var vec = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		vec = (event.position - Vector2(500,300))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.move_and_slide(vec.normalized() * 500)
	if Input.is_action_pressed("move_up"):
		self.move_local_y(-5)
	if Input.is_action_pressed("move_down"):
		self.move_local_y(5)
	if Input.is_action_pressed("move_left"):
		self.move_local_x(-5)
	if Input.is_action_pressed("move_right"):
		self.move_local_x(5)
