extends Node2D

var hp = 100
var damage = 15
var weapon
var bulet_scene = "res://mobs/models/laser.tscn"

var move_to = Vector2(0,0)
var to_target = Vector2(0,0)
var target
func _ready():
	target = get_parent().aim.get_child(0).global_position
#	get_node("Viewport/Spatial/MeshInstance").rotation.y = randf() * PI
#	bulet_scene = load("res://mobs/models/projecttile.tscn").instance()
#	self.add_child(bulet_scene)
	get_node("Viewport/Spatial").transform.origin.x = 200.0 * Constants.counter1
	Constants.counter1 += 1
#	get_node("Viewport/Spatial/MeshInstance").rotation.y = -get_node("legs").global_rotation - PI/2

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
	get_node("Sprite").texture = get_node('Viewport').get_texture()
	get_node("legs").look_at(move_to + self.global_position)
	get_node("Viewport/Spatial/MeshInstance").rotation.y = -get_node("legs").global_rotation - PI/2
	get_node("head").look_at(to_target + self.global_position)
	get_node("Viewport/Spatial/MeshInstance2").rotation.y = -get_node("head").global_rotation - PI/2

func fire():
	var b = load(bulet_scene).instance()
	var space_state = get_world_2d().direct_space_state
	var lighted_targets = get_tree().get_nodes_in_group('lighted_up')
#	var target
	var result
	if lighted_targets and !(self in lighted_targets):
		target = find_closest(lighted_targets).global_position
		var exception = []
		for enemy in get_tree().get_nodes_in_group('enemies'):
			if !(enemy in lighted_targets):
				exception.append(enemy)
		result = space_state.intersect_ray(self.global_position, target, exception)
	else:
#		return
#		target = get_parent().aim.get_child(0).global_position
#		var exception = get_tree().get_nodes_in_group('enemies').duplicate(true)
#		exception.erase()
		result = space_state.intersect_ray(self.global_position, (target-self.global_position).normalized() * 20000 + self.global_position, get_tree().get_nodes_in_group('enemies'))
	if result:
		if result['collider'].name == 'RigidBody2D':
			b.to = result['collider'].get_child(0).global_position
			result['collider'].take_damage(100)
		else:
			b.to = result['position']
			if result['collider'] in get_tree().get_nodes_in_group('enemies'):
				result['collider'].take_damage(100)
	else:
		b.to = target
#			b.to = target
	to_target = target - self.global_position
	target = get_parent().aim.get_child(0).global_position

#	to_target = target - self.global_position
#	else:
#		b.to = get_parent().aim.get_node(0).global_position
#	b.global_position = self.global_position

	
	b.position = self.global_position
	get_tree().get_root().get_node('Node2D').add_child(b)
#	b.look_at(get_parent().aim.global_position)
#	b.global_position = self.global_position
#	b.global_position = self.global_position

	pass


func find_closest(arr):
	var m = 99999
	var closest
	for elem in arr:
		if elem.global_position.distance_to(self.global_position) < m:
			closest = elem
			m = elem.global_position.distance_to(self.global_position)
	return closest
