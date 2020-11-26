extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var weapon_vec = Vector2(0,0)
var move = Vector2(0,0)
var is_cooldown = false
var weapons
var bullet_scene = "res://bullet.tscn"
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
#		weapons[0].start_firing()
#		print(get_parent().get_parent().get_simple_path(Vector2(0,0), Vector2(100,100)))
		pass
	if event.is_action_pressed('right_button'):
#		weapons[1].start_firing()
		pass
	if Input.is_action_pressed("fire_left"):
		fire(weapon_vec)
	
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move = Vector2(0,0)
#	print(self.position)
#	get_node("Sprite").texture = viewport.get_texture()
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


func fire(position):
	if is_cooldown:
		return
	else:
		is_cooldown = true
		get_node("Timer").start()
		var b = load(bullet_scene).instance()
		b.to = weapon_vec
		b.position = self.global_position
		b.look_at(b.position + weapon_vec)
		get_tree().get_root().get_node('Node2D').add_child(b)
		
		

func _on_Timer_timeout():
	is_cooldown = false
	get_node("Timer").stop()
