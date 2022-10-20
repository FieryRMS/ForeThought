extends KinematicBody2D
class_name Entity

export var Gravity := 200
export var MovementSpeed := 10
export var JumpStrength := 100
export var Friction := 0.7
var Velocity := Vector2.ZERO

func _ready():
	add_to_group("Entity")
	pass

func _process(delta):
	Velocity.y += Gravity*delta
	if(is_on_floor()):
		if(Velocity.y>=0):
			Velocity.y=0.5
		if(Velocity.x!=0):
			Velocity.x*=Friction
		if(abs(Velocity.x)<1):
			Velocity.x=0
	if(is_on_ceiling()):
		Velocity.y*=-1
	if(is_on_wall()):
		Velocity.x=0
	pass
