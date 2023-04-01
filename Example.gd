extends Minigame


var t
func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	pass

func _process(delta):
	pass

func StartMinigame():
	print("Starting minigame")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	t.set_wait_time(rng.randi_range(1,3))
	t.start()
	yield(t, "timeout")
	print("Minigame ended")
	emit_signal("minigame_ended")
	pass

