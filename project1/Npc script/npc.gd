extends CharacterBody2D

const speed = 30
var currentState = stand

var direction = Vector2.RIGHT
var startPosition

var isRoaming = true
var isChatting = false

var player
var playerInChatZone = false

enum{
	stand,
	newDirection,
	move
}

func _ready():
	randomize()
	startPosition = position

func _process(delta):
	if currentState == 0 or currentState == 1:
		$AnimatedSprite2D.play("stand")
	elif currentState == 2 and !isChatting:
		if direction.x == -1:
			
