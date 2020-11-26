extends Node2D

var hp = 100
var damage = 15
var weapon
var bulet_scene = "res://mobs/models/laser.tscn"

func _ready():
	print(name)
#	bulet_scene = load("res://mobs/models/projecttile.tscn").instance()
#	self.add_child(bulet_scene)
	pass
	
func take_damage(damage):
	hp -= damage
	
func change_aim(aim):
	get_parent().aim = aim

func aimed_shoot(aim):
	pass
	
func shoot(aim):
	pass

func _on_Timer_timeout():
	fire()
#	get_node("Timer").stop()


func _process(delta):
	pass

func fire():
	var b = load(bulet_scene).instance()
	var space_state = get_world_2d().direct_space_state
	var lighted_targets = get_tree().get_nodes_in_group('lighted_up')
	var target
	if lighted_targets:
		target = find_closest(lighted_targets).global_position
	else:
		return
		target = get_parent().aim.get_child(0).global_position
	var result = space_state.intersect_ray(self.global_position, target)
	if result:
		if result['collider'].name == 'RigidBody2D':
			b.to = result['collider'].get_child(0).global_position
		else:
			b.to = result['position']
	else:
		return
#	else:
#		b.to = get_parent().aim.get_node(0).global_position
#	b.global_position = self.global_position
#	print(get_parent().aim.position)
	
	b.position = self.global_position
	get_tree().get_root().get_node('Node2D').add_child(b)
#	b.look_at(get_parent().aim.global_position)
#	b.global_position = self.global_position
#	b.global_position = self.global_position
#	print('pipka')
	pass


func find_closest(arr):
	var m = 99999
	var closest
	for elem in arr:
		if elem.global_position.distance_to(self.global_position) < m:
			closest = elem
			m = elem.global_position.distance_to(self.global_position)
	return closest
