extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var img
var wall
var flor
var size = 200


#var RS = ResourceSaver.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	img = get_node("Sprite").texture.get_data()
	img.lock()
	flor = get_node("floor")
	wall = get_node("walls")
	for x in range(size):
		for y in range(size):
			var c = img.get_pixel(x, y).r
			if c == 1.0:
				flor.set_cell(x, y, 0)
			elif c == 0.0:
				wall.set_cell(x, y, 1)
				
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("res://my_scene.tscn", packed_scene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
