extends Node2D


var hp = 100
var damage = 15


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func take_damage(damage):
	hp -= damage
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
