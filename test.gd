extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var weapon_vec = Vector2(0,0)
var move = Vector2(0,0)

var weapons

var viewport
# Called when the node enters the scene tree for the first time.
func _ready():
	weapons = get_node("weapons").get_children()
	viewport = get_node("Viewport")
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		weapon_vec = (event.position - Vector2(500,300))
	if event.is_action_pressed('left_button'):
		weapons[0].start_firing()
	if event.is_action_pressed('right_button'):
		weapons[1].start_firing()
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move = Vector2(0,0)
	get_node("Sprite").texture = viewport.get_texture()
#	self.move_and_slide(vec.normalized() * 500)
	if Input.is_action_pressed("move_up"):
		move.y -= 200
	if Input.is_action_pressed("move_down"):
		move.y += 200
	if Input.is_action_pressed("move_left"):
		move.x -= 200
	if Input.is_action_pressed("move_right"):
		move.x += 200
	self.move_and_slide(move)








