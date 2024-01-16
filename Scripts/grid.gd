extends Node2D

signal gameEnded(end: int)

var isCrossTurn: bool = true
var cellArray: Array[Node]
var winLineArray: Array[WinLine]
var gameState: gameStateType = gameStateType.PLAYING
var crossScene: PackedScene = load("res://Scenes/cross.tscn")
var noughtScene: PackedScene = load("res://Scenes/nought.tscn")

enum gameStateType {NOUGHT, CROSS, DRAW, PLAYING}

# Called when the node enters the scene tree for the first time.
func _ready():
	var cellIndices: Array[int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 3, 6, 1, 4, 7, 2, 5, 8, 0, 4, 8, 2, 4, 6]
	cellArray = get_children()
	for i in range(0, 22, 3):
		var winLine: WinLine = WinLine.new(cellArray[cellIndices[i]], cellArray[cellIndices[i+1]], cellArray[cellIndices[i+2]])
		winLineArray.push_back(winLine)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Main function processing mouse click
func _input(event):
	if gameState == gameStateType.PLAYING:
		if event is InputEventMouseButton: 
			if event.pressed:
				var turnShape: Polygon2D = getCurrentTurnShape()
				var closestCell: Node2D = getClosestCell(event)
				if not closestCell.isCellOccupied(): 
					closestCell.add_child(turnShape)
					if checkForEnd():
						gameEnded.emit(gameState)
					else:
						isCrossTurn = not isCrossTurn
			
# Alternates between cross and nought scenes
func getCurrentTurnShape() -> Polygon2D:
	if isCrossTurn:
		return crossScene.instantiate()
	else:
		return noughtScene.instantiate()

# Determines the cell closest to the mouse click event
func getClosestCell(event: InputEventMouseButton) -> Cell:
	var distanceArray: Array[float]
	for cell in cellArray:
		distanceArray.push_back(cell.global_position.distance_to(event.position))
	return cellArray[distanceArray.find(distanceArray.min())]

# Shows if all cells are occupied or not
func isGridFull() -> bool:
	var checkedCellsOccupied: bool = true
	for cell in cellArray:
		checkedCellsOccupied = checkedCellsOccupied and cell.isCellOccupied()
	return checkedCellsOccupied

func checkForEnd() -> bool:
	if checkForWin():
		return true
	elif isGridFull():
		gameState = gameStateType.DRAW
		return true
	return false
	
	
func checkForWin() -> bool: 
	for winLine in winLineArray:
		var winCheck: int = winLine.checkLine()
		match winCheck:
			0:
				gameState = gameStateType.NOUGHT
				return true
			1:
				gameState = gameStateType.CROSS
				return true
	return false

func _on_restart_button_pressed():
	clearGrid()
	gameState = gameStateType.PLAYING
	isCrossTurn = true
	
func clearGrid():
	for cell in cellArray:
		if cell.isCellOccupied():
			cell.get_child(0).queue_free()
