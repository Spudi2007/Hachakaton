extends Node2D

var hp = 100
var damage = 15
var weapon


func _ready():
	pass 


func take_damage(damage):
	hp -= damage
	
func change_aim(aim):
	get_parent().aim = aim

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
