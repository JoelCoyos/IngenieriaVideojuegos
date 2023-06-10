extends Minigame


var t
var rng
func _init():
	pass

func _ready():
	t = Timer.new()
	self.add_child(t)
	rng = RandomNumberGenerator.new()
	pass

func _process(delta):
	pass

func StartMinigame():
	print("Starting minigame")
	rng.randomize()
	t.set_wait_time(rng.randi_range(1,3))
	t.start()
	yield(t, "timeout")
	print("Minigame ended")
	emit_signal("minigame_ended")
	pass

