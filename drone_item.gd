extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var drone3d
# Called when the node enters the scene tree for the first time.
func _ready():
	drone3d = get_node("navigation_drone")
	get_node("navigation_drone/Viewport/Spatial/AnimationPlayer").playback_speed = 0
	drone3d.get_node("Viewport/Spatial").transform.origin.y = 200.0 * Constants.counter2
	Constants.counter2 += 1
	drone3d.get_node("Sprite").texture = drone3d.get_node('Viewport').get_texture()
	get_node("navigation_drone/Viewport/Spatial/MeshInstance").rotation.y = 180 - 45
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == 'RigidBody2D':
		body.collect_drone()
		self.queue_free()
	pass # Replace with function body.
