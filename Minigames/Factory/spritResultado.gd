extends Node2D

var speed = 30

var valBuscado = {
	caja1 = 0,
	caja2 = 0,
	caja3 = 0
}

#func _ready():
	

func _physics_process(delta):
	position.y += speed*delta
	asignar()

func asignar():
	match (valBuscado.caja1):
		1:  
			match (valBuscado.caja2):
				1:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("111")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("112")
					else:
						$AnimatedSprite.play("113")
				2:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("121")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("122")
					else:
						$AnimatedSprite.play("123")
				3:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("131")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("132")
					else:
						$AnimatedSprite.play("133")
		2:  
			match (valBuscado.caja2):
				1:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("211")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("212")
					else:
						$AnimatedSprite.play("213")
				2:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("221")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("222")
					else:
						$AnimatedSprite.play("223")
				3:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("231")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("232")
					else:
						$AnimatedSprite.play("233")
		3:  
			match (valBuscado.caja2):
				1:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("311")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("312")
					else:
						$AnimatedSprite.play("313")
				2:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("321")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("322")
					else:
						$AnimatedSprite.play("323")
				3:
					if valBuscado.caja3 == 1:
						$AnimatedSprite.play("331")
					elif valBuscado.caja3 == 2:
						$AnimatedSprite.play("332")
					else:
						$AnimatedSprite.play("333")
								

