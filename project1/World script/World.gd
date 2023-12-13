extends Node

var playerCurrentAttack = false

var currentScene = "level1" #current level indication
var transitionScene = false

var playerExitLevel1_1Posx = 344
var playerExitLevel1_1Posy = -16
var playerStartLevel1Posx = 0#302
var playerStartLevel1Posy = 0#108

var gameFirstLoadin = true

func finish_changescenes():
	if transitionScene == true:
		transitionScene = false
		if currentScene == "level1":
			currentScene = "level1.1"
		else:
			currentScene = "Level1"
