extends Node2D

onready var input_area = $InputArea2D
onready var shape = $InputArea2D/CollisionShape2D.shape
onready var tween = $Tween

var active = true setget set_active


func set_active(value):
	active = value
	input_area.input_pickable = active


func _on_InputArea2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		EventBus.emit_signal("planet_clicked", self)
