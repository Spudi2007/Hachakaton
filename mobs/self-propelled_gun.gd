extends Node2D

var hp = 100
var damage = 15
var weapon
var bulet_scene

func _ready():
	bulet_scene = load("res://mobs/models/projecttile.tscn").instance()
	self.add_child(bulet_scene)

func take_damage(damage):
	hp -= damage
	
func change_aim(aim):
	get_parent().aim = aim

func aimed_shoot(aim):
	pass
	
func shoot(aim):
	pass

func _on_Timer_timeout():
	get_node("Timer").stop()
