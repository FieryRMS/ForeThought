tool
extends Node2D

export(int) var NumOfDoors = 0 setget onNumOfDoorsChange
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


func OnButtonPress(_obj, val):
	if val:
		ButtonsPressed += 1
	else:
		ButtonsPressed -= 1
	OpenDoorIfValid()


func _ready():
	DoorOverlay.set_modulate(color)
	NumOfDoors = 0
	for i in Buttons.get_children():
		i.SetOverlay(color)
		NumOfDoors += 1
		i.connect("ButtonPressed", self, "OnButtonPress")
	if not Engine.is_editor_hint():
		OpenDoorIfValid()


func onNumOfDoorsChange(val):
	print(val)
	if Engine.is_editor_hint() and DoorOverlay:
		if val < 0:
			return
		elif val < NumOfDoors:
			var arr = Buttons.get_children()
			for _i in range(NumOfDoors - val):
				arr.pop_back().queue_free()
		else:
			for i in range(val - NumOfDoors):
				var TempBtn = Button.instance()
				TempBtn.SetOverlay(DoorOverlay.get_modulate())
				TempBtn.position = DoorOverlay.global_position + offset * (NumOfDoors + i)
				Buttons.add_child(TempBtn)
				TempBtn.owner = get_tree().edited_scene_root
	NumOfDoors = val


func onColorChange(val):
	color = val
	if Engine.is_editor_hint() and DoorOverlay and Buttons:
		DoorOverlay.set_modulate(val)
		for i in Buttons.get_children():
			i.SetOverlay(val)
