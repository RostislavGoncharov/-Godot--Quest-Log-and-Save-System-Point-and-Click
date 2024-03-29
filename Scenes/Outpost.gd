extends Node2D

var screen_number = int(GameDataManager.get_value("screen_number"))

func _ready():
	Player.get_node("Camera/NavigationUI/TextureButton").connect("pressed", self, "_on_TextureButton_pressed")
#	Player.get_node("Camera").set_offset(Vector2(0, 0))
	
func _process(delta):
	
	if screen_number == 2:
		Player.get_node("Camera/NavigationUI/TextureButton").set_disabled(true)
	elif screen_number < 2:
		Player.get_node("Camera/NavigationUI/TextureButton").set_disabled(false)

# Move camera to the next part of the level
func next_stage():
	var camera_point 
	
	screen_number += 1
	
	if screen_number > 2:
		return
	
	match screen_number:
		0:
			camera_point = $Stage1/CameraPoint1
		1: 
			camera_point = $Stage2/CameraPoint2
			GameDataManager.set_value("game_state", "Cycle_2")
		2: 
			camera_point = $Stage3/CameraPoint3
		_:
			pass
		
	Player.get_node("Camera").fade_out()
	yield(get_tree().create_timer(1), "timeout")
	Player.get_node("Camera").set_offset(Vector2(0, camera_point.global_position.y)) 
	Player.get_node("Camera").fade_in()
			

func _on_TextureButton_pressed():
	next_stage()
	

func _on_TextureButton_mouse_entered():
	$Stage3/TextureButton/RichTextLabel.set_deferred("visible", true)


func _on_TextureButton_mouse_exited():
	$Stage3/TextureButton/RichTextLabel.set_deferred("visible", false)

func _on_ExitTextureButton_pressed():
	get_tree().quit()
	
