extends KinematicBody2D

var is_active = false
var node_object
var busy
var aggro_range = 600
var aim
var fire_distance = 400
var is_aggressive = false
var move_radius = 500
var active_range = 1000
var cooldown = 1
var time_to_shoot
var path = [Vector2(134, 221), Vector2(13434, 221)]
var where_random_move
var nav 
var magic_move = Vector2(0,0)
var move_buff = Vector2(0,0)
var approach_radius = 200

var death_timer = -1

func _ready():
	randomize()
	nav = get_tree().get_root().get_node('Node2D/Navigation2D')
	aim = get_tree().get_root().get_node("Node2D/walls/RigidBody2D")
	
	
	
func take_damage(damage):
	get_child(2).take_damage(damage)
	if get_child(2).hp <= 0:
		get_child(2).get_node("CPUParticles2D").emitting = true
		get_child(2).get_node("CPUParticles2D2").emitting = true
		death_timer = 1.4
		
func attack(aim):
	pass

func check_aggro(aim_pos):
	if aggro_range >= (self.global_position - aim_pos).length():
		is_aggressive = true
	return is_aggressive
	
		
func check_active(aim_pos):
	if active_range >= (self.global_position - aim_pos).length():
		is_active = true
		return true
	else:
		is_active = false
		return false

func _process(delta):
	if death_timer > -1:
#		death_timer -= delta
		if death_timer < 0:
			self.queue_free()
		death_timer -= delta
		return
	if check_active(aim.position):
		
		if check_aggro(aim.position):
			aggres(delta)
			busy = "aggro"
			if self in get_tree().get_nodes_in_group('drones'):
				get_child(2).to_target = aim.global_position - self.global_position
			
#			print("IM ANGRY")
		else:
			if !busy:
				var roll = randf()
				if roll > 0.5:
					get_node("Timer").wait_time = (randf() * 5)
					busy = "random_wait"
					get_node("Timer").start()
#					print("I'm wait")
				else:
					var where_random_move_loacal = Vector2((randf() * move_radius * 2 - move_radius), (randf() * move_radius * 2 - move_radius)) + global_position
					where_random_move = nav.get_closest_point(where_random_move_loacal)
					busy = "random_move"
#					print("I'm moving")
			if busy == "random_move":
				move(delta, where_random_move)
			elif busy == "random_wait":
				return
	
	else:
		busy = null
		is_active = false
		is_aggressive = false
		
	
var path_buff = Vector2(0,0)

func move(delta, aim):
	if aim:
		if aim.distance_to(global_position) < approach_radius:
			return
		if path.size() > 0:
			if (path[-1] - aim).length() >= 100 or true:
				path = get_tree().get_root().get_node('Node2D/Navigation2D').get_simple_path(self.global_position, aim, true)
#				print(path)
#				path_buff = path[-1]
			if path.size() > 1:
	#			path.remove(0)
				if (self.global_position - path[0]).length() < 0.1:
					path.remove(0)
#				move_and_slide((path[0] - self.global_position).normalized() * 200)
				magic_move = (path[0] - self.global_position).normalized() * 200
				move_buff = lerp(move_buff, magic_move, 0.03)
				get_child(2).move_to = move_buff
				move_and_slide(move_buff)
#			else:
#				move_and_slide((path[1] - self.global_position).normalized() * 200)
#self.position += (path[1] - self.global_position).normalized() * 1
		if aim.distance_to(global_position) < 1:
			busy = null
			
		



func random_turn():
	var angle = int (round(randf() * 360))
	

func fire():
	if time_to_shoot != 0:
		return
	
	

func aggres(delta):
	if global_position.distance_to(aim.global_position) <= fire_distance:
		if get_child(2).name == "self-propelled_gun" and get_child(2).get_node("Timer").is_stopped():
			get_child(2).get_node("Timer").start()
	else:
		if get_child(2).name == "self-propelled_gun":
			get_child(2).get_node("Timer").stop()
	move(delta, aim.global_position)

func random_move(where):
	move_and_slide(where)
	


func random_wait():
	busy = null
	get_node("Timer").stop()
