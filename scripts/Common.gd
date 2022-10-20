extends Object

class_name Common


class DataPoint:
	var Position: Vector2
	var SpriteFrame: int
	var delta: float

	func _init(Pos: Vector2, SpFrame: int, del: float):
		self.Position = Pos
		self.SpriteFrame = SpFrame
		self.delta = del


static func LargestMagnitude(a, b):
	if abs(a) > abs(b):
		return a
	return b


static func CalcFinalVelAfterPlayerMov(Vel: Vector2, PlayerVel: Vector2) -> Vector2:
	var FinalVel := Vector2.ZERO
	# if direction are the same
	if Vel.x * PlayerVel.x >= 0:
		FinalVel.x = LargestMagnitude(Vel.x, PlayerVel.x)
	else:
		FinalVel.x = Vel.x + PlayerVel.x

	if Vel.y * PlayerVel.y >= 0:
		FinalVel.y = LargestMagnitude(Vel.y, PlayerVel.y)
	else:
		FinalVel.y = Vel.y + PlayerVel.y
	return FinalVel
