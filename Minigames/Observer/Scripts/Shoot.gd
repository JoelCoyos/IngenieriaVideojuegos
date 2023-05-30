extends Node2D

export(PackedScene) var laserScene
var timer
var t
var difficulty

func _ready():
	t = Timer.new()
	self.add_child(t)
	pass
	
func ShootRoutine():
	while(true):
		DifficultyLasers()
		t.set_wait_time(GLOBAL.rng.randi_range(1,3))
		t.start()
		yield(t,"timeout")


func InstanceLaser(rotation,speed):
	var laser = laserScene.instance()
	laser.rotationLaser = rotation
	laser.speed = speed
	add_child(laser)

func DifficultyLasers():
	if(difficulty == 1):
		InstanceLaser(90,60)
	elif(difficulty == 2):
		InstanceLaser(45,70)
		InstanceLaser(135,70)
	elif(difficulty == 3):
		InstanceLaser(90,60)
		InstanceLaser(45,60)
		InstanceLaser(135,60)
	elif(difficulty == 4):
		InstanceLaser(90,100)
		InstanceLaser(45,100)
		InstanceLaser(135,100)
	elif(difficulty == 5):
		InstanceLaser(-45,100)
		InstanceLaser(45,100)
		InstanceLaser(90,100)
		InstanceLaser(135,100)
		InstanceLaser(225,100)
	else:
		print("what")
	
