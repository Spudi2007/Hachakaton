extends Node2D


var hp = 2000
var aggro_range = 1600
var approach_radius = 350
var is_active = true
var fire_distance = 300
var count_of_bull_in_volley
var state = "free"
var exploions
var radius_of_exlosions = 400
var bullet_path = "res://bullet.tscn"
var aim
var move_to = Vector2(0,0)
func _ready():
	get_parent().hp = hp
	get_parent().aggro_range = aggro_range
	get_parent().approach_radius = approach_radius
	get_parent().is_active = is_active
	get_parent().fire_distance = fire_distance
	aim = get_tree().get_root().get_node("Node2D/walls/RigidBody2D")

func take_damage(damage):
	hp -= damage




#func _process(delta):
#	pass

func check_attack():
	if state == "free":
		var roll = randf()
		if roll < 0.2:
			get_node("chill_time").start()
			state = "chill"
			
		elif roll >= 0.2 and roll < 0.4:
			just_follow()
		elif roll >= 0.4 and roll < 0.55:
			dash_attack()
		elif roll >= 0.55 and roll < 0.70:
			cataclism()
		elif roll >= 0.70 and roll < 0.85:
			projecttile_volley()
		else:
			pass
		print(state)
	else:
		print(state)
		pass


func projecttile_volley():
	count_of_bull_in_volley = 10
	state = "projecttile_volley"
	get_node("Timer_volley").start()

func just_follow():
	state = "just_allow"
	get_node("follow_timer").start()
	get_parent().approach_radius = 0

func _on_Timer_volley_timeout():
	count_of_bull_in_volley -= 1
	var bullet = load(bullet_path).instance()
	bullet.speed = 300
	bullet.look_at(aim.position)
	bullet.position = global_position
	bullet.to = aim.position
	get_tree().get_root().get_node('Node2D').add_child(bullet)
	if count_of_bull_in_volley < 0:
		get_node("Timer_volley").stop()
		state = "free"


func _on_chill_time_timeout():
	state = "free"
	get_node("chill_time").stop()

func cataclism():
	state = "cataclism"
	get_node("Timer_to_place_zone").start()
	exploions = 6
	pass

func dash_attack():
	state = "dash_attack"
	get_parent().speed = 1000
	get_parent().approach_radius = 0

func _on_Timer_to_plase_zone_timeout():
	var where = aim.global_position + Vector2(0,1).rotated(2*PI*randf()) * radius_of_exlosions 
	var explosion = load("res://explosion.tscn").instance()
	get_tree().get_root().get_node("Node2D").add_child(explosion)
	exploions -= 1
	if exploions <= 0:
		get_node("Timer_to_place_zone").stop()
		state = "free"


func _on_follow_timer_timeout():
	state = "free"
	get_parent().approach_radius = approach_radius
	get_node("follow_timer").stop()
	
