extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var weapon_vec = Vector2(0,0)
var move = Vector2(0,0)
var magic_vector = Vector2(0,0)
var firing = false
var weapons
var bullet_scene = "res://bullet.tscn"
var viewport
# Called when the node enters the scene tree for the first time.
func _ready():
	weapons = get_node("weapons").get_children()
	viewport = get_node("Viewport")
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		weapon_vec = (event.position - Vector2(512,300))
	if event.is_action_pressed('left_button'):
#		weapons[0].start_firing()
#		print(get_parent().get_parent().get_simple_path(Vector2(0,0), Vector2(100,100)))
		pass
	if event.is_action_pressed('right_button'):
#		weapons[1].start_firing()
		pass
	if event.is_action_pressed("fire_left"):
		firing = true
	if event.is_action_released("fire_left"):
		firing = false
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for node in get_tree().get_nodes_in_group('lighted_up'):
		node.remove_from_group("lighted_up")
#	print(get_tree().get_nodes_in_group('lighted_up'))
#	move = Vector2(0,0)
	magic_vector = Vector2(0,0)
	get_node("weapons").look_at(weapon_vec + get_child(0).global_position)
	get_node("legs").look_at(move + get_child(0).global_position)
	get_node("Viewport/Spatial/MeshInstance2").rotation.y = -get_node("legs").global_rotation - PI/2
	get_node("Viewport/Spatial/MeshInstance").rotation.y = -get_node("weapons").global_rotation - PI/2
	get_node("Sprite").texture = viewport.get_texture()
	get_node("Viewport/Spatial/MeshInstance2").get_node("AnimationPlayer").playback_speed = move.length() / 100.0
	if Input.is_action_pressed("move_up"):
		magic_vector.y -= 300
	if Input.is_action_pressed("move_down"):
		magic_vector.y += 300
	if Input.is_action_pressed("move_left"):
		magic_vector.x -= 300
	if Input.is_action_pressed("move_right"):
		magic_vector.x += 300
	move = lerp(move, magic_vector, 0.05)
	self.move_and_slide(move)


func fire(position):
#	get_node("Timer").start()
	var b = load(bullet_scene).instance()
	b.to = weapon_vec
	b.position = get_child(0).global_position
	b.look_at(b.position + weapon_vec)
	get_tree().get_root().get_node('Node2D').add_child(b)
		
		

func _on_Timer_timeout():
	if firing:
		fire(weapon_vec)
#	get_node("Timer").stop()
