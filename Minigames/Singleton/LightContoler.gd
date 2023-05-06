extends Light2D

func _ready():
	self.enabled = false
 
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if self.enabled == true:
			self.enabled = false
		else:
			self.enabled = true
