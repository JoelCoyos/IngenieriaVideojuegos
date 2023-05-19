extends Area2D

var speed = 30
var areaActual = 0

var valPretendido = {
	caja1 = 0,
	caja2 = 0,
	caja3 = 0
}

var valAdquirido = {
	caja1 = 0,
	caja2 = 0,
	caja3 = 0
}

func _ready():
	$AnimatedSprite.play("default")
	
func adVelocity(inc):
	speed+=inc

#las imagenes son muy chicas //ver escalado u otro pack u como definirlas en el button achicando
		# se resuelve con la opcion expand del button
func changeCaja1():
	if valAdquirido.caja1 == 1:
		$AnimatedSprite.play("colorBlue")
	elif valAdquirido.caja1 == 2: 
		$AnimatedSprite.play("colorGreen")
	elif valAdquirido.caja1 == 3: 
		$AnimatedSprite.play("colorYellow")
#	else:
#		$AnimatedSprite.play("corrupto")

func changeCaja2():
	match (valAdquirido.caja1):
		1:  
			if valAdquirido.caja2 == 1:
				$AnimatedSprite.play("circleBlue")
			elif valAdquirido.caja2 == 2:
				$AnimatedSprite.play("frontBlue")
			elif valAdquirido.caja2 == 3:
				$AnimatedSprite.play("sheepBlue")
		2:
			if valAdquirido.caja2 == 1:
				$AnimatedSprite.play("circleGren")
			elif valAdquirido.caja2 == 2:
				$AnimatedSprite.play("frontGreen")
			elif valAdquirido.caja2 == 3:
				$AnimatedSprite.play("sheepGreen")
		3:
			if valAdquirido.caja2 == 1:
				$AnimatedSprite.play("circleYellow")
			elif valAdquirido.caja2 == 2:
				$AnimatedSprite.play("frontYellow")
			elif valAdquirido.caja2 == 3:
				$AnimatedSprite.play("sheepYellow")
		_:
			$AnimatedSprite.play("corrupto")
	
func changeCaja3():
	match (valAdquirido.caja1):
		1:  
			match (valAdquirido.caja2):
				1:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("111")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("112")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("113")
				2:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("121")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("122")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("123")
				3:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("131")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("132")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("133")
		2:  
			match (valAdquirido.caja2):
				1:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("211")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("212")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("213")
				2:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("221")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("222")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("223")
				3:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("231")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("232")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("233")
		3:  
			match (valAdquirido.caja2):
				1:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("311")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("312")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("313")
				2:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("321")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("322")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("323")
				3:
					if valAdquirido.caja3 == 1:
						$AnimatedSprite.play("331")
					elif valAdquirido.caja3 == 2:
						$AnimatedSprite.play("332")
					elif valAdquirido.caja3 == 3:
						$AnimatedSprite.play("333")
								
	
func _physics_process(delta):
	position.y += speed*delta
	
	if areaActual == 1:
		changeCaja1()
	elif areaActual == 2:
		changeCaja2()
	elif areaActual == 3:
		changeCaja3()
	#$MarginContainer/Label.text=str(valPretendido)
	#$Label2.text=str(valAdquirido)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Area2D_area_entered(area):
#	if area.is_in_group("caja1"):
#		print(caja1)


func _on_VisibilityNotifier2D_screen_exited():
	print()
	#queue_free() si lo pongo se actualiza el indice de tablas y salt aeeror entonces lo dejo y digo que cuando termine el minijuego se borre todo
	#cuando se haga el cambio de escena se deberia borrar todos los que existan
