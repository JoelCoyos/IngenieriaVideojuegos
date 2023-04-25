extends Node2D

export (PackedScene) var Enemy
export (PackedScene) var EnemyOBS

# Called when the node enters the scene tree for the first time.
func _ready():
	$BgMusic.play()  #accedo a la musica
	$EnemyTimer.start()
	$TimerOBS.start()
	randomize()#lo utilizo para conseguir un estado de aleatoriedad,si no lo usaramos,cuando usemos cualquier otro
	#otro metodo para obtener un nro aleatorio este se repetiria(no seria aleatorio realmente)
	#pass # Replace with function body.

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
	var enemy = Enemy.instance()#guardamos la referencia a nuestra escena enem6
	add_child(enemy)#instanciamos la escena
	enemy.position = get_node("MarginContainer/EnemyPath2D/EnemySpawnPathFollow2D").position
	$EnemyTimer.wait_time = GLOBAL.random(1,4)
	$EnemyTimer.start()
	

func _on_TimerOBS_timeout():
	get_node("MarginContainer/EnemyPath2D/EnemySpawnPathFollow2D").set_offset(randi())#toma posicion en un pto aleatorio
	var enemyOBS = EnemyOBS.instance()#guardamos la referencia a nuestra escena enem6
	add_child(enemyOBS)#instanciamos la escena
	enemyOBS.position = get_node("MarginContainer/EnemyPath2D/EnemySpawnPathFollow2D").position
	$TimerOBS.wait_time = GLOBAL.random(5,8)
	$TimerOBS.start()
