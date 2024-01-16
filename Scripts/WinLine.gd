class_name WinLine
extends Object

var cell1: Cell
var cell2: Cell
var cell3: Cell


func _init(cellA: Cell, cellB: Cell, cellC: Cell):
	cell1 = cellA
	cell2 = cellB
	cell3 = cellC

func checkLine() -> int:
	if cell1.isCellOccupied() and cell2.isCellOccupied() and cell3.isCellOccupied():
		if cell1.get_path_to(cell1.get_child(0)) == cell2.get_path_to(cell2.get_child(0)) and cell1.get_path_to(cell1.get_child(0)) == cell3.get_path_to(cell3.get_child(0)):
			if cell1.get_path_to(cell1.get_child(0)).get_name(0) == "Cross":
				return 1
			else:
				return 0
	return -1
