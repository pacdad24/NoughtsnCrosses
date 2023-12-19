extends Node2D

var isCrossTurn: bool = true
var cellArray: Array[Node]
var endState: endType
var crossScene: PackedScene = load("res://cross.tscn")
var noughtScene: PackedScene = load("res://nought.tscn")

enum endType {NOUGHT, CROSS, DRAW}

# Called when the node enters the scene tree for the first time.
func _ready():
	cellArray = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Main function processing mouse click
func _input(event):
	if not endState:
		if event is InputEventMouseButton: 
			if event.pressed:
				var turnShape: Polygon2D = getCurrentTurnShape()
				var closestCell: Node2D = getClosestCell(event)
				if not isCellOccupied(closestCell): 
					closestCell.add_child(turnShape)
					if checkForEnd():
						print(endState)
					else:
						isCrossTurn = not isCrossTurn
			
# Alternates between cross and nought scenes
func getCurrentTurnShape() -> Polygon2D:
	if isCrossTurn:
		return crossScene.instantiate()
	else:
		return noughtScene.instantiate()

# Determines the cell closest to the mouse click event
func getClosestCell(event: InputEventMouseButton) -> Node2D:
	var distanceArray: Array[float]
	for cellCount in 9:
		distanceArray.push_back(cellArray[cellCount].global_position.distance_to(event.position))
	return cellArray[distanceArray.find(distanceArray.min())]
	
# Shows if the closest cell is already occupied by a cross or nought
func isCellOccupied(cell: Node2D) -> bool:
	return cell.get_child_count() > 0

# Shows if all cells are occupied or not
func isGridFull() -> bool:
	var checkedCellsOccupied: bool = true
	for cellCount in 9:
		checkedCellsOccupied = checkedCellsOccupied and isCellOccupied(cellArray[cellCount])
	return checkedCellsOccupied

func checkForEnd() -> bool:
	if checkForWin():
		return true
	elif isGridFull():
		endState = endType.DRAW
		return true
	return false
	
	
func checkForWin() -> bool: 
	if checkLine(cellArray[0], cellArray[1], cellArray[2]):
		return true
	elif checkLine(cellArray[3], cellArray[4], cellArray[5]):
		return true
	elif checkLine(cellArray[6], cellArray[7], cellArray[8]):
		return true
	elif checkLine(cellArray[0], cellArray[3], cellArray[6]):
		return true
	elif checkLine(cellArray[1], cellArray[4], cellArray[7]):
		return true
	elif checkLine(cellArray[2], cellArray[5], cellArray[8]):
		return true
	elif checkLine(cellArray[0], cellArray[4], cellArray[8]):
		return true
	elif checkLine(cellArray[2], cellArray[4], cellArray[6]):
		return true
	return false
	
	
func checkLine(cell1: Node2D, cell2: Node2D, cell3: Node2D) -> bool:
	if isCellOccupied(cell1) and isCellOccupied(cell2) and isCellOccupied(cell3):
		if cell1.get_path_to(cell1.get_child(0)) == cell2.get_path_to(cell2.get_child(0)) and cell1.get_path_to(cell1.get_child(0)) == cell3.get_path_to(cell3.get_child(0)):
			if cell1.get_path_to(cell1.get_child(0)).get_name(0) == "Cross":
				endState = endType.CROSS
			else:
				endState = endType.NOUGHT
			return true
		else:
			return false
	else:
		return false
	
	
	
	
	
	
	
