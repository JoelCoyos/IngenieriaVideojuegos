extends Minigame

export (PackedScene) var Enemy
export (PackedScene) var EnemyOBS
var t
var rng
var possibleColors = [Color8(255,0,0),Color8(0,255,0),Color8(0,0,255),Color8(255,255,255)]
var observableColor
# Called when the node enters the scene tree for the first time.
func _ready():
	t = Timer.new()
	rng = RandomNumberGenerator.new()
	rng.randomize()
	self.add_child(t)
	$BgMusic.play()  #accedo a la musica
	$EnemyTimer.start()
	$TimerOBS.start()
	objectiveCount = 3 #Temporal
	objectiveCleared = 0
	time = 15
	$TimerOBS.wait_time = (time-5)/objectiveCount #Temporal, se ajusta con la dificultad
	randomize()#lo utilizo para conseguir un estado de aleatoriedad,si no lo usaramos,cuando usemos cualquier otro
	#otro metodo para obtener un nro aleatorio este se repetiria(no seria aleatorio realmente)
	#pass # Replace with function body.
	
func StartMinigame():
	print("Starting minigame")
	t.set_wait_time(time)
	t.start()
	observableColor = possibleColors[rng.randi_range(0,possibleColors.size()-1)]
	possibleColors.erase(observableColor)
	$EnemyObservable.modulate = observableColor
	$Player.connect("deathPlayer",self,"DeathPlayer")
	SetDifficulty()
	yield(t, "timeout")
	emit_signal("minigame_ended")
	pass
	
	
func _physics_process(delta):
	$MarginContainer/ParallaxBackground
	get_node("MarginContainer/ParallaxBackground").scroll_base_offset += Vector2(0,1) * 8 * delta
	get_node("MarginContainer/ParallaxBackgroundNube1").scroll_base_offset += Vector2(0,1) * 24 * delta
	get_node("MarginContainer/ParallaxBackgroundNube2").scroll_base_offset += Vector2(0,1) * 34 * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HUD_game_over():
	$BgMusic.stop()


func _on_EnemyTimer_timeout():
	get_node("MarginContainer/EnemyPath2D/EnemySpawnPathFollow2D").set_offset(randi())#toma posicion en un pto aleatorio
	var enemy = EnemyOBS.instance()#guardamos la referencia a nuestra escena enem6
	enemy.position = get_node("MarginContainer/EnemyPath2D/EnemySpawnPathFollow2D").position
	enemy.connect("deathPlayer",self,"DeathPlayer")
	enemy.currentColor = possibleColors[rng.randi_range(0,possibleColors.size()-1)]
	enemy.isObservable = false
	enemy.difficulty = difficulty
	add_child(enemy)#instanciamos la escena
	$EnemyTimer.wait_time = GLOBAL.random(1,4)
	$EnemyTimer.start()
	

func _on_TimerOBS_timeout():
	get_node("MarginContainer/EnemyPath2D/EnemySpawnPathFollow2D").set_offset(randi())#toma posicion en un pto aleatorio
	var enemyOBS = EnemyOBS.instance()#guardamos la referencia a nuestra escena enem6
	enemyOBS.position = get_node("MarginContainer/EnemyPath2D/EnemySpawnPathFollow2D").position
	enemyOBS.connect("touchObserver",self,"TouchObserver")
	enemyOBS.currentColor = observableColor
	enemyOBS.isObservable = true
	add_child(enemyOBS)#instanciamos la escena
	#$TimerOBS.wait_time = GLOBAL.random(5,8)
	$TimerOBS.start()
	
func TouchObserver():
	objectiveCleared+=1
	if(objectiveCleared==objectiveCount):
		emit_signal("minigame_ended")
	pass
	
func DeathPlayer():
	emit_signal("minigame_ended")
	print("Minigame ended")
	
	
func SetDifficulty():
	if(difficulty ==1):
		objectiveCount = 5
		time = 20

	elif(difficulty == 2):
		objectiveCount = 8
		time = 20

	elif(difficulty == 3):
		objectiveCount= 4
		time = 25

	elif(difficulty == 4):
		objectiveCount = 10
		time = 25

	elif(difficulty == 5):
		objectiveCount = 15
		time = 30

	pass

