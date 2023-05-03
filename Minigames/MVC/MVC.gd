extends Minigame



var rng
var t

var puzzle = []
var puzzle_height
var puzzle_width
var pieceScene

var xPuzzleStart=400
var yPuzzleStart=200
var pieceDistance=200

var currentBlankSpace

func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	rng = RandomNumberGenerator.new()
	pieceScene = load("res://Minigames//MVC//Scenes//Piece.tscn")
	time=20
	pass

func _process(delta):
	pass

func StartMinigame():
	print("Starting minigame")
	rng.randomize()
	t.set_wait_time(time)
	t.start()
	SetPuzzle()
	yield(t, "timeout")
	EndPuzzle()
	print("Minigame ended")
	emit_signal("minigame_ended")
	pass

func SetPuzzle():
	puzzle_height=3
	puzzle_width=2
	objectiveCount = puzzle_height*puzzle_width -1
	objectiveCleared=0
	var order = range(1,puzzle_height*puzzle_width)
	rng.randomize()
	order.shuffle()
	for x in puzzle_height:
		puzzle.append([])
		for y in puzzle_width:
			puzzle[x].append(null)
	var count=0
	for y in puzzle_width:
		for x in puzzle_height:
			if(!(x==puzzle_height-1 and y == puzzle_width-1)):
				var piece =  pieceScene.instance()
				piece.position = Vector2(xPuzzleStart + x*pieceDistance,yPuzzleStart+ y*pieceDistance)
				piece.x = x
				piece.y = y
				piece.number = order[count]
				count+=1
				piece.SetText(str(piece.number))
				piece.connect("selectPiece",self,"SelectedPiece")
				add_child(piece)
				puzzle[x][y] = piece
	currentBlankSpace = Vector2(puzzle_height-1,puzzle_width-1)
	pass
	
func SelectedPiece(x,y):
	if(currentBlankSpace.distance_to(Vector2(x,y))<=1):
		var piece = puzzle[x][y]
		puzzle[x][y]=null
		puzzle[currentBlankSpace.x][currentBlankSpace.y] = piece
		piece.position = Vector2(xPuzzleStart + currentBlankSpace.x*pieceDistance,yPuzzleStart+ currentBlankSpace.y*pieceDistance)
		piece.x = currentBlankSpace.x
		piece.y = currentBlankSpace.y
		currentBlankSpace = Vector2(x,y)
	pass

func EndPuzzle():
	var count = 1
	for y in puzzle_width:
		for x in puzzle_height:
			if(puzzle[x][y]!=null and puzzle[x][y].number == count):
				print("bien")
				objectiveCleared+=1
			else:
				print("mal")
			count+=1
	pass
