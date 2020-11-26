extends KinematicBody2D

var is_active = false
var node_object
var busy
var aggro_range = 100
var aim
var is_aggressive = false
var move_radius = 500
var active_range = 1000
var cooldown = 1
var time_to_shoot
var path = [Vector2(134, 221), Vector2(13434, 221)]
var where_random_move
var nav 

func _ready():
	randomize()
	nav = get_tree().get_root().get_node('Node2D/Navigation2D')
	pass

func take_damage(damage):
	get_child(2).take_damage(damage)
	if get_child(2).hp <= 0:
		self.queue_free()

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
	if check_active(aim.position):
		
		if check_aggro(aim.position):
			aggres(delta)
			busy = "aggro"
			print("IM ANGRY")
		else:
			if !busy:
				var roll = randf()
				if roll > 0.5:
					get_node("Timer").wait_time = (randf() * 5)
					busy = "random_wait"
					get_node("Timer").start()
					print("I'm wait")
				else:
					var where_random_move_loacal = Vector2((randf() * move_radius * 2 - move_radius), (randf() * move_radius * 2 - move_radius)) + global_position
					where_random_move = nav.get_closest_point(where_random_move_loacal)
					busy = "random_move"
					print("I'm moving")
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
		if path:
			if (path[-1] - aim).length() >= 100 or true:
				path = get_tree().get_root().get_node('Node2D/Navigation2D').get_simple_path(self.global_position, aim, true)
				path_buff = path[-1]
			if path.size() > 1:
	#			path.remove(0)
	#			print(self.move_and_collide((path[1] - self.global_position).normalized() * delta * 200))
				if (self.global_position - path[0]).length() < 0.1:
					path.remove(0)
				move_and_slide((path[0] - self.global_position).normalized() * 200)
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
	move(delta, aim.global_position)

func random_move(where):
	move_and_slide(where)
	


func random_wait():
	busy = null
	get_node("Timer").stop()
