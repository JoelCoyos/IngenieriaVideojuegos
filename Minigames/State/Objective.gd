extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Objective_area_entered(area):
	if(area.get_groups().size()>0 and area.get_groups()[0]=="Cone"):
		area.queue_free()
	pass # Replace with function body.
