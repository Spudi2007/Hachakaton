extends Node2D

var spawner_counter = 0
var mod_path = "res://mob.tscn"
var drone_path = "res://mobs/navigation_drone.tscn"
var tank_path = "res://mobs/self-propelled_gun.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	var godzila = load(mod_path).instance()
	get_node("spawner2").add_child(godzila)
	godzila.add_child(load("res://godzilla.tscn").instance())
	godzila.global_position = get_node("spawner2").global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().get_nodes_in_group("enemy_drones").size() < 10:
		if spawner_counter >= 8:
			spawner_counter = 0
		var new_drone = load(mod_path).instance()
		get_child(spawner_counter).add_child(new_drone)
		new_drone.add_child(load(drone_path).instance())
		new_drone.global_position = get_child(spawner_counter).global_position
		print("Spawn drone in ",spawner_counter,"number of drones", get_tree().get_nodes_in_group("enemy_drones").size())
		new_drone.add_to_group("enemy_drones")
		new_drone.add_to_group('drones')
		spawner_counter += 1
		return
	if get_tree().get_nodes_in_group("enemy_tanks").size() < 20:
		if spawner_counter >= 8:
			spawner_counter = 0
		var new_tank = load(mod_path).instance()
		get_tree().get_root().get_node("Node2D/mob_pos").add_child(new_tank)
		new_tank.add_child(load(tank_path).instance())
		new_tank.global_position = get_child(spawner_counter).global_position
		print("Spawn tank in ",spawner_counter," number of tanks", get_tree().get_nodes_in_group("enemy_tanks").size())
		new_tank.add_to_group("enemy_tanks")
		spawner_counter += 1
		return
