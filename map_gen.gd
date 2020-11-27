extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var img
var wall
var flor
var noise
var size = 100


#var RS = ResourceSaver.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	return
	img = get_node("Sprite").texture.get_data()
	noise = get_node("Sprite2").texture.noise.get_image(200,200)
#	print(noise.)
#	yield(noise, 'changed')
	print('data_collectd  ', img, '   ', noise )
	img.lock()
	print('img_locked')
	noise.lock()
	flor = get_node("floor")
	wall = get_node("walls")
	flor.clear()
	wall.clear()
	print('gen_started')
	for x in range(size):
		for y in range(size):
			var c = img.get_pixel(x, y).r
			var n = noise.get_pixel(x, y).r
#			print(n)
			if c == 1.0:
				if n > 0.5:
					flor.set_cell(x, y, 0)
				else:
					flor.set_cell(x, y, 1)
			elif c == 0.0:
				if n > 0.5:

					wall.set_cell(x, y, 0)
				else:
					wall.set_cell(x, y, 1)
				
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("res://my_scene.tscn", packed_scene)
	pass # Replace with function body.
func _input(event):
	if event.is_action_pressed("open_lvlup"):
		get_node("walls/RigidBody2D/Light2D").texture_scale = 40.15
		var scn = load("res://lvlup.tscn").instance()
		get_tree().get_root().get_node("Node2D").add_child(scn)
		scn.show()
		scn.rect_position = get_tree().get_root().get_node("Node2D/walls/RigidBody2D/Camera2D").global_position - Vector2(520, 300)
#		for node in get_tree().get_nodes_in_group('enemy'):
#			node.set_process(false)
#func clear():
#	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
