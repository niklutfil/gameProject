extends Node2D



func _process(delta):
	change_scenes()

func _on_level_11_exitpoint_body_entered(body):
	if body.has_method("player"):
		World.transitionScene = true


func _on_level_11_exitpoint_body_exited(body):
	if body.has_method("player"):
		World.transitionScene = false
		
func change_scenes():
	if World.transitionScene == true:
		if World.currentScene == "level1.1":
			get_tree().change_scene_to_file("res://Level 1 script/level_1.tscn")
			World.finish_changescenes()
