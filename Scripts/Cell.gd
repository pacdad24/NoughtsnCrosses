class_name Cell
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Shows if the closest cell is already occupied by a cross or nought
func isCellOccupied() -> bool:
	return get_child_count() > 0
