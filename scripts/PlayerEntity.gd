extends Entity

func _ready():
	add_to_group("Player")

var PlayerMovement = Vector2.ZERO

func _process(_delta):
	if is_on_floor():
		PlayerMovement = Vector2(
		(Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		)*MovementSpeed,
		-JumpStrength if Input.get_action_strength("move_jump") else 0)
	move_and_slide(Common.CalcFinalVelAfterPlayerMov(Velocity, PlayerMovement), Vector2.UP, true)
	if(not is_on_floor()):
		Velocity=Common.CalcFinalVelAfterPlayerMov(Velocity, PlayerMovement)
		PlayerMovement=Vector2.ZERO
