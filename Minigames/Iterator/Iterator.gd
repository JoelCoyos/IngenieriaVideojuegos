extends Minigame


var t

var graph = []
var edgeDic = {}
var graph_width
var graph_height
var nodeScene
var edgeScene
var rng

func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	rng = RandomNumberGenerator.new()
	rng.randomize()
	t.set_wait_time(rng.randi_range(1,3))
	nodeScene = load("res://Minigames//Iterator/GraphNode.tscn")
	edgeScene = load("res://Minigames//Iterator/Edge.tscn")
	pass

func _process(delta):
	pass

func StartMinigame():
	print("Starting minigame")
	t.set_wait_time(2)
	t.start()
	AddNodes()
	AddEdges()
	yield(t, "timeout")
	print("Minigame ended")
	emit_signal("minigame_ended")
	pass

func AddNodes():
	graph_width=5
	graph_height=7

	for i in graph_width:
		graph.append([])
		for j in graph_height:
			graph[i].append(null)
	for i in range(0,graph_width):
		InstanceNode(i,0)
	for i in range(0,graph_width):
		InstanceNode(i,graph_height-1)
	var order =[0,1,2,3,4]
	#for i in range(0,graph_width):
	#	order.append(i)
	order.shuffle()
	print(order)
	for i in range(0,graph_width):
		var nodePos = order[i]
		if(nodePos == 0):
			var node = InstanceNode(nodePos,i+1)
			var nodeConnection = InstanceNode(1,i+1)
			node.connection = nodeConnection
		elif(nodePos == graph_width-1):
			var node = InstanceNode(nodePos,i+1)
			var nodeConnection = InstanceNode(graph_width-2,i+1)
			node.connection = nodeConnection
		else:
			var node = InstanceNode(nodePos,i+1)
			var aux = 1 -2*rng.randi_range(0,1)
			var nodeConnection = InstanceNode(nodePos+aux,i+1)
			node.connection = nodeConnection
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
	node.position = Vector2(300+x*100,100+y*100)
	add_child(node)
	node.x = x
	node.y = y
	graph[x][y]=node
	return node
	pass

func InstanceEdge(pos1,pos2):
	if(pos1.y < pos2.y): #Vertical edge
		var edge = edgeScene.instance()
		add_child(edge)
		var x = pos1.x
		var y = pos1.y
		edge.position = Vector2(300+x*100,100+y*100) + Vector2(0,50)
		edgeDic[[pos1,pos2]]=[edge]
		y=y+1
		while(y < pos2.y):
			edge = edgeScene.instance()
			add_child(edge)
			edge.position = Vector2(300+x*100,100+y*100) + Vector2(0,50)
			edgeDic[[pos1,pos2]].append(edge)
			y=y+1
	else: # Horizontal edge
		var edge = edgeScene.instance()
		add_child(edge)
		if(pos1.x < pos2.x):
			edge.position = graph[pos1.x][pos1.y].position + Vector2(50,0)
		else:
			edge.position = graph[pos1.x][pos1.y].position + Vector2(-50,0)
		edge.rotation_degrees = 90
		edgeDic[[pos1,pos2]]=[edge]
	pass
