extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp_level = 0
var speed_level = 0
var damage_level = 0
var light_level = 0
var p
var points = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	p = get_node("Panel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_hp_pressed():
	if points > 0 and hp_level < 3:
		hp_level += 1
		points -= 1
		get_node("RichTextLabel").text = "number of points: " + str(points) 
		if hp_level == 1:
			p.get_node("1heart").show()
		if hp_level == 2:
			p.get_node("2heart").show()
		if hp_level == 3:
			p.get_node("3heart").show()
		
func _on_speed_pressed():
	if points > 0 and speed_level < 3:
		speed_level += 1
		points -= 1
		get_node("RichTextLabel").text = "number of points: " + str(points)
		if speed_level == 1:
			p.get_node("1speed").show()
		if speed_level == 2:
			p.get_node("2speed").show()
		if speed_level == 3:
			p.get_node("3speed").show()


func _on_light_pressed():
	if points > 0 and light_level < 3:
		points -= 1
		light_level += 1
		get_node("RichTextLabel").text = "number of points: " + str(points)
		if light_level == 1:
			p.get_node("1light").show()
		if light_level == 2:
			p.get_node("2light").show()
		if light_level == 3:
			p.get_node("3light").show()

func _on_damage_pressed():
	if points > 0 and damage_level < 3:
		damage_level += 1
		points -= 1
		get_node("RichTextLabel").text = "number of points: " + str(points)
		if damage_level == 1:
			p.get_node("1damage").show()
		if damage_level == 2:
			p.get_node("2damage").show()
		if damage_level == 3:
			p.get_node("3damage").show()


func _on_TextureButton_pressed():
	self.hide()
