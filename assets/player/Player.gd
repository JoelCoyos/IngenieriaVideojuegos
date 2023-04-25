extends KinematicBody2D

export (PackedScene) var Explosion

const SPEED = 130
onready var motion =Vector2.ZERO # /onready declara un valor inmediatamente, sin tener que hacerlo en _ready
onready var screensize = get_viewport_rect().size#tamanio de la ventana



func _ready():
	$AnimatedSprite.play()

func _physics_process(delta):
	motion_ctrl()
	animation_ctrl()
	motion = move_and_collide(motion * delta)


func get_axis() -> Vector2:#devuelve un vector2
	var axis = Vector2.ZERO
	#axis.x = int(Input.is_action_just_pressed("ui_right")) - int (Input.is_action_pressed("ui_left"))
	axis.x = int(Input.is_action_pressed("ui_right")) - int (Input.is_action_pressed("ui_left"))
	# si derecha 1 - 0 = 1////si no pulsamos nada 0 - 0 = 0//// si izq 0 - 1 = -1
	axis.y = int(Input.is_action_pressed("ui_down")) - int (Input.is_action_pressed("ui_up"))
	return axis


func motion_ctrl(): #controla el movimiento
	if get_axis() == Vector2.ZERO:# no pulsamos ninguna tecla
		motion = Vector2.ZERO
	else:#getaxis devolvera 1 0 -1 segun corresponda
		motion = get_axis().normalized() * SPEED#el normalized es para no moverme en diagonal mas rapido
	#limitar movimiento del personaje
	position.x = clamp(position.x,0,screensize.x)#valor :actual, minimo, maximo
	position.y = clamp(position.y,0,screensize.y)


func  animation_ctrl(): #controlador de animacione
	if get_axis().x == 1:
		$AnimatedSprite.animation = "horizontal"
		$AnimatedSprite.flip_h = true  #invierte el sprite
	elif get_axis().x == -1:
		$AnimatedSprite.animation = "horizontal"
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.animation = "vertical"

func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $Position2D.global_position
	get_tree().call_group("level","add_child",explosion)
	
func death_enemy():
	queue_free()
	explosion_ctrl()



