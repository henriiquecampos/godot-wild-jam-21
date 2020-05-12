extends Node2D

export var speed = 200.0
export(Resource) var fuel = preload("res://actors/Fuel.tres")

onready var tween = $Tween
onready var fuel_tween = $FuelTween

var _planets = []


func _ready():
	EventBus.connect("planet_clicked", self, "_on_Planet_clicked")
	fuel.setup()


func _process(delta):
	fuel.burn(delta)
	update()


func _on_Planet_clicked(planet):
	var planet_position = planet.global_position
	if global_position.distance_to(planet_position) > fuel.current:
		return
	
	_planets.append(planet)
	move_to_planet()


func move_to_planet():
	if tween.is_active():
		return
	for planet in _planets:
		var planet_position = planet.global_position
			
		var distance = global_position.distance_to(planet_position)
		var time = distance / speed
		
		tween.interpolate_property(self, "global_position", global_position,
				planet_position, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_completed")
		_replenish_fuel()
	_planets.clear()


func _replenish_fuel():
	if fuel_tween.is_active():
		fuel_tween.stop_all()
	fuel_tween.interpolate_property(fuel, "current", fuel.current, fuel.max_amount, 0.125)
	fuel_tween.start()


func _draw():
	draw_circle(Vector2.ZERO, fuel.current, Color(1.0, 1.0, 1.0, 0.5))
