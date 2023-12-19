extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cells_game_ended(end):
	match end:
		0: 
			text = "noughts win!"
		1:
			text = "crosses win!"
		2:
			text = "draw!"
	
	
