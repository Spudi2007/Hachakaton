extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var to
var speed = 700
var damage = 75
var who = "RigidBody2D"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += to.normalized() * delta * speed


func _on_bullet_body_entered(body):
	print(body)
	if body.name == "walls":
		self.queue_free()
	if body.name != who and body.name != "walls":
		body.take_damage(damage)
		self.queue_free()
	
