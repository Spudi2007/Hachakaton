extends Node2D


var hp = 100
var damage = 15
var weapon
var move_to = Vector2(0,0)
var to_target = Vector2(0,0)
var move_buff = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Viewport/Spatial").transform.origin.y = 200.0 * get_parent().get_parent().get_index()
	get_parent().approach_radius = 100

func take_damage(damage):
	hp -= damage
	

func find_target():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var result = space_state.intersect_ray(self.global_position, get_parent().aim.global_position, get_tree().get_nodes_in_group('enemies'))
	if result:
		if result.collider.name != 'walls':
			result.collider.add_to_group("lighted_up")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Sprite").texture = get_node('Viewport').get_texture()
	get_node("head").look_at(to_target + self.global_position)
	
	get_node("Viewport/Spatial/MeshInstance").rotation.y = -get_node("head").global_rotation - PI/2

	if get_parent().is_aggressive:
		find_target()
