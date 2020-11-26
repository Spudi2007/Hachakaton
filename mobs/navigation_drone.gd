extends Node2D


var hp = 100
var damage = 15
var weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func take_damage(damage):
	hp -= damage

func find_target():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var result = space_state.intersect_ray(self.position, get_parent().aim)
	if result:
		result.collider.add_to_group("")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
