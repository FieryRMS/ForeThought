extends Node2D

signal ButtonPressed(obj, id, pressed)
var _id: int


func init(color: Color, id: int):
	$Overlay.set_modulate(color)
	_id = id
	return self


func _on_Area2D_body_entered(body):
	if body.is_in_group("Entity"):
		$AnimationPlayer.play("ButtonPress")
		emit_signal("ButtonPressed", self, _id, true)


func _on_Area2D_body_exited(body):
	if body.is_in_group("Entity"):
		$AnimationPlayer.play_backwards("ButtonPress")
		emit_signal("ButtonPressed", self, _id, false)
