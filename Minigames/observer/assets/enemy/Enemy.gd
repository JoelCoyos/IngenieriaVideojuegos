extends Area2D

export (PackedScene) var Explosion# var expllosion del tipo packedScene

#la ponemos mediante un export para ponerle luego la referencia a nuestra escena explosicon que aun no existe
var speed

signal deathPlayer

func _ready():
	$AnimatedSprite.play()
	speed = GLOBAL.random(150,300)

func  _physics_process(delta):
	position.y += speed*delta#se mueve en linea recta
	

func death_enemy():
	queue_free()
	explosion_ctrl()
	
func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionPosition2D.global_position
	get_tree().call_group("level","add_child",explosion)
	
	
func _on_Enemy_body_entered(body):# detecta si el enemigo entro en contacto con el player//el player es un cuerpo fisico
	if body.is_in_group("player"):
		emit_signal("deathPlayer")
		death_enemy()
		body.queue_free()
#enemy

func _on_VisibilityNotifier2D_screen_exited():#envia senial cuando el enemigo no esta en pantalla
	queue_free()

