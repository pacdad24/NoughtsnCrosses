extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_two_player_mode_button_pressed():
	visible = false
	var returnToMenuButton: Button = get_node("/root/Main/Game/ReturnToMenuButton")
	returnToMenuButton.pressed.connect(_on_return_to_menu_button_pressed)
	
func _on_return_to_menu_button_pressed():
	visible = true
