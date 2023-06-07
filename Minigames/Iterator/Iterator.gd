extends Minigame


var t

var graph = []
var edgeDic = {}
var graph_width
var graph_height
var nodeScene
var edgeScene
var rng
var objectiveNode
var gameIsOver
var currentObjectiveNode

var initialGraphX
var initialGraphY

func _init():
	pass

func _ready():
	controls = "Mouse"
	t = Timer.new()
	self.add_child(t)
	rng = RandomNumberGenerator.new()
	rng.randomize()
	t.set_wait_time(rng.randi_range(1,3))
	nodeScene = load("res://Minigames//Iterator/GraphNode.tscn")
	edgeScene = load("res://Minigames//Iterator/Edge.tscn")
	pass

# warning-ignore:unused_argument
func _process(delta):
	pass

func StartMinigame():
	currentObjectiveNode=0
	SetDifficulty()
	t.set_wait_time(time)
	t.start()
	graph_width=objectiveCount
	graph_height=graph_width+2
	gameIsOver=false
	objectiveNode = rng.randi_range(0,graph_width-1)
	AddNodes()
	graph[0][graph_height-1].TweenScale()
	AddEdges()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass

func AddNodes():
	initialGraphY = 100
	if(graph_width%2 == 0):
		initialGraphX = 640 - ((graph_width)/2-0.5)*100
	else:
		initialGraphX = 640 - ((graph_width-1)/2)*100
	for i in graph_width:
		graph.append([])
		for j in graph_height:
			graph[i].append(null)
	for i in range(0,graph_width):
		InstanceNode(i,0)
	for i in range(0,graph_width):
		InstanceNode(i,graph_height-1)
	var order = range(0,graph_width)
	order.shuffle()
	for i in range(0,graph_width):
		var nodePos = order[i]
		var node = InstanceNode(nodePos,i+1)
		var nodeConnection
		if(nodePos == 0):
			nodeConnection = InstanceNode(1,i+1)
		elif(nodePos == graph_width-1):
			nodeConnection = InstanceNode(graph_width-2,i+1)
		else:
			var aux = 1 -2*rng.randi_range(0,1)
			nodeConnection = InstanceNode(nodePos+aux,i+1)
		node.connection = nodeConnection
		nodeConnection.connection = node
	pass
	
func SelectedNode(selectedPos):
	if(gameIsOver):
		return
	var y = 0
	var x = selectedPos
	var endNode
	var ended = false
	while(ended==false):
		graph[currentObjectiveNode][graph_height-1].StopTween()
		var startingGraph = graph[x][y]
		y=y+1
		while(graph[x][y]==null):
			graph
			y = y+1
		var node = graph[x][y]
		for edge in edgeDic[[Vector2(startingGraph.x,startingGraph.y),Vector2(node.x,node.y)]]:
			edge.FillEdge("down")
			yield(edge.animation,"animation_finished")
		if(y==graph_height-1):
			endNode=x
			ended = true
		elif(node.connection!=null):
			x = node.connection.x
			y = node.connection.y
			for edge in edgeDic[[Vector2(node.x,node.y),Vector2(node.connection.x,node.connection.y)]]:
				if(abs(node.x) < abs(node.connection.x)):
					edge.FillEdge("right")
				else:
					edge.FillEdge("left")
				yield(edge.animation,"animation_finished")
	if(endNode == currentObjectiveNode):
		objectiveCleared+=1
		if(currentObjectiveNode==graph_width-1):
			gameIsOver=true
			emit_signal("minigame_ended")
		else:
			currentObjectiveNode = currentObjectiveNode+1
			graph[currentObjectiveNode][graph_height-1].TweenScale()
	else:
		gameIsOver=true
		emit_signal("minigame_ended")
	pass	
	
func AddEdges():
	for x in graph_width:
		var node = graph[x][0]
		var y =1
		while(y < graph_height):
			while(graph[x][y]==null):
				y=y+1
			InstanceEdge(Vector2(node.x,node.y),Vector2(x,y))
			node = graph[x][y]
			y=y+1
	for i in graph_width:
		for j in graph_height:
			if(graph[i][j] and graph[i][j].connection!=null):
				var node = graph[i][j]
				InstanceEdge(Vector2(node.x,node.y),Vector2(node.connection.x,node.connection.y))
	pass

func InstanceNode(x,y):
	var node = nodeScene.instance()
	node.position = Vector2(initialGraphX+x*100,initialGraphY+y*100)
	add_child(node)
	node.x = x
	node.y = y
	graph[x][y]=node
	node.connect("selectStartingNode",self,"SelectedNode")
	node.AddNode()
	return node
	pass

func InstanceEdge(pos1,pos2):
	if(pos1.y < pos2.y): #Vertical edge
		var edge = edgeScene.instance()
		add_child(edge)
		var x = pos1.x
		var y = pos1.y
		edge.position = Vector2(initialGraphX+x*100,initialGraphY+y*100) + Vector2(0,50)
		edgeDic[[pos1,pos2]]=[edge]
		y=y+1
		while(y < pos2.y):
			edge = edgeScene.instance()
			add_child(edge)
			edge.position = Vector2(initialGraphX+x*100,initialGraphY+y*100) + Vector2(0,50)
			edgeDic[[pos1,pos2]].append(edge)
			y=y+1
	else: # Horizontal edge
		var edge = edgeScene.instance()
		add_child(edge)
		if(pos1.x < pos2.x):
			edge.position = graph[pos1.x][pos1.y].position + Vector2(51,0)
		else:
			edge.position = graph[pos1.x][pos1.y].position + Vector2(-50,0)
		edge.rotation_degrees = 90
		edgeDic[[pos1,pos2]]=[edge]
		edgeDic[[pos2,pos1]]=[edge] #Esto es medio feo pero ya fue. 
		#Forma posible de arreglarlo, poner un set en la clave del diccionary??
	pass

func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 2
		time = 20
	elif(difficulty == 2):
		objectiveCount = 3
		time = 25
	elif(difficulty == 3):
		objectiveCount= 4
		time = 30
	elif(difficulty == 4):
		objectiveCount = 5
		time = 25
	elif(difficulty == 5):
		objectiveCount = 5
		time = 20
	pass
