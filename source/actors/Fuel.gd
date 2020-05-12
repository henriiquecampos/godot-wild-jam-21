extends Resource


export var max_amount = 100.0
export var fuel_loss_ratio = 0.1

var current = max_amount


func setup():
	current = max_amount


func burn(delta):
	current -= (current * fuel_loss_ratio) * delta
