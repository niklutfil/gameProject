extends Node2D

func _ready():
	if World.gameFirstLoadin == true:
		$Player.position.x = World.playerStartLevel1Posx
		$Player.position.y = World.playerStartLevel1Posy
	else:
		$Player.position.x = World.playerExitLevel1_1Posx
		$Player.position.y = World.playerExitLevel1_1Posy

func _process(delta):
	changeScene()

func _on_level_1_transition_point_body_entered(body):
	if body.has_method("player"):
		World.transitionScene = true


func _on_level_1_transition_point_body_exited(body):
	if body.has_method("player"):
		World.transitionScene = false
		print("Transition conditions reset.")
		
func changeScene():
	if World.transitionScene == true:
		if World.currentScene == "level1":
			get_tree().change_scene_to_file("res://Level 1 script/level_1(1).tscn")
			World.gameFirstLoadin = false
			World.finish_changescenes()
