extends Node2D

var is_active = false
var node_object
var busy = false
var aggro_range = 1000
var aim
var is_aggressive = false
var move_radius = 5
var active_range = 1500
var cooldown = 1
var time_to_shoot
func _ready():
	pass

func attack(aim):
	pass

func check_aggro(aim_pos):
	if aggro_range >= (position - aim_pos).length():
		return true
	else:
		return false
		
func check_active(aim_pos):
	if active_range >= (get_parent().position - aim_pos).length():
		return true
	else:
#		print("is_NOT_active")
		return false
func _process(delta):
	if is_active:
		if check_aggro(aim.position):
			is_aggressive = true
		if !busy:
			var roll = randf()
			if roll > 0.5:
				random_turn()
			else:
				random_move()
	check_active(aim.position)


func random_turn():
	var angle = int (round(randf() * 360))
	node_object.Rotatio

func fire():
	if time_to_shoot != 0:
		return
	
	
	

func aggres():
	pass

func random_move():
	var where = Vector2((randf() * move_radius * 2 - move_radius), (randf() * move_radius * 2 - move_radius)) + position
	
	random_turn()
	
