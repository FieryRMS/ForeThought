tool
extends Node2D

export(Array, Vector2) var ButtonPositions setget OnButtonPositionsChange
export(Color) var color = Color(1, 1, 1, 1) setget onColorChange

const Button = preload("res://elements/Button.tscn")
onready var DoorOverlay = get_node("Door/Overlay")
onready var Buttons = get_node("Buttons")

var ButtonsPressed = 0
var isOpen = false
var offset = Vector2(10, 10)


func OpenDoorIfValid():
	if ButtonsPressed == len(Buttons.get_children()):
		$Door/AnimationPlayer.play("DoorOpen")
		isOpen = true
	elif isOpen:
		$Door/AnimationPlayer.play("DoorClose")
		isOpen = false


func OnButtonPress(_obj, isopen):
	if isopen:
		ButtonsPressed += 1
	else:
		ButtonsPressed -= 1
	OpenDoorIfValid()


func SpawnButton(loc: Vector2):
	var TempBtn = Button.instance()
	TempBtn.SetOverlay(DoorOverlay.get_modulate())
	TempBtn.SetIndex(len(Buttons.get_children()))
	TempBtn.position = loc
	Buttons.add_child(TempBtn)
	TempBtn.owner = get_tree().edited_scene_root
	TempBtn.connect("ButtonPressed", self, "OnButtonPress")
	TempBtn.connect("PosChanged", self, "OnButtonPositionChange")


func _ready():
	DoorOverlay.set_modulate(color)
	for i in Buttons.get_children():
		i.free()
	for i in ButtonPositions:
		SpawnButton(i)
	if not Engine.is_editor_hint():
		OpenDoorIfValid()


func onColorChange(val):
	color = val
	if Engine.is_editor_hint() and DoorOverlay and Buttons:
		DoorOverlay.set_modulate(val)
		for i in Buttons.get_children():
			i.SetOverlay(val)


func OnButtonPositionsChange(val):
	print(val)
	if Engine.is_editor_hint() and DoorOverlay:
		if len(ButtonPositions) < len(val):
			for i in range(len(val) - len(ButtonPositions)):
				var pos = DoorOverlay.global_position + offset * (len(ButtonPositions) + i)
				SpawnButton(pos)
				ButtonPositions.push_back(pos)
		else:
			ButtonPositions = val
			_ready()
	else:
		ButtonPositions = val


func OnButtonPositionChange(_obj, position: Vector2, idx: int):
	ButtonPositions[idx] = position
