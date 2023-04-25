extends Sprite

export var animation = "transition"

func _ready():
	pass 


func _process(delta):
	pass

func MinigameTransition():
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var screenshot =  ImageTexture.new()
	screenshot.create_from_image(img)
	texture = screenshot
	var anim = $AnimationPlayer
	anim.play(animation)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.
