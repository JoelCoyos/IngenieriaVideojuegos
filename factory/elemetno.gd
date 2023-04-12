extends Area2D

var speed = 20

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
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")


func _physics_process(delta):
	position.y += speed*delta
	$MarginContainer/Label.text=str(valPretendido)
	$Label2.text=str(valAdquirido)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Area2D_area_entered(area):
#	if area.is_in_group("caja1"):
#		print(caja1)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
