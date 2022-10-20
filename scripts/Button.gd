tool
extends Node2D

signal ButtonPressed(obj, pressed)


func SetOverlay(color: Color):
	$Overlay.set_modulate(color)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Entity"):
		$AnimationPlayer.play("ButtonPress")
		emit_signal("ButtonPressed", self, true)


func _on_Area2D_body_exited(body):
	if body.is_in_group("Entity"):
		$AnimationPlayer.play_backwards("ButtonPress")
		emit_signal("ButtonPressed", self, false)
