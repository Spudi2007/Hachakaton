extends Node2D

var spawner_counter = 0
var mod_path = "res://mob.tscn"
var drone_path = "res://mobs/navigation_drone.tscn"
var tank_path = "res://mobs/self-propelled_gun.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().get_nodes_in_group("enemy_drones").size() < 4:
		var new_tank = load(mod_path).instance()
		get_child(spawner_counter).add_child(new_tank)
		new_tank.add_child(load(drone_path).instance())
		new_tank.global_position = get_child(spawner_counter).global_position
		print("Spawn drone in ",spawner_counter,"number of drones", get_tree().get_nodes_in_group("enemy_drones").size())
		return
	
