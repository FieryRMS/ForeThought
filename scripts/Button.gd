tool
extends Node2D

signal ButtonPressed(obj, pressed)
signal PosChanged(obj, pos, idx)

var _idx
var _entities = 0


func SetOverlay(color: Color):
	$Overlay.set_modulate(color)


func SetIndex(idx: int):
	_idx = idx


func _enter_tree() -> void:
	set_notify_transform(true)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		emit_signal("PosChanged", self, position, _idx)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Entity"):
		_entities += 1
		if _entities == 1:
			$AnimationPlayer.play("ButtonPress")
			emit_signal("ButtonPressed", self, true)


func _on_Area2D_body_exited(body):
	if body.is_in_group("Entity"):
		_entities -= 1
		if not _entities:
			emit_signal("ButtonPressed", self, false)
			$AnimationPlayer.play_backwards("ButtonPress")
