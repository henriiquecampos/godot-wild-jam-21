extends Node2D

onready var shape = $LandingArea2D/CollisionShape2D.shape
onready var tween = $Tween

func _on_LandingArea2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		EventBus.emit_signal("planet_clicked", self)
