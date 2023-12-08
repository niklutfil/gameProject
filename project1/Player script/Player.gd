extends CharacterBody2D

const speed = 150
var currentDirection = "none"

func _ready():
	$AnimatedSprite2D.play("stand_front")
	
func _physics_process(delta):
	playerMovement()

func playerMovement():
	if Input.is_action_pressed("right"):
		currentDirection = "right"
		playAnimation(1)
		velocity.x = speed
		velocity.y = 0
		
	elif Input.is_action_pressed("left"):
		currentDirection = "left"
		playAnimation(1)
		velocity.x = -speed
		velocity.y = 0
		
	elif Input.is_action_pressed("up"):
		currentDirection = "up"
		playAnimation(1)
		velocity.y = -speed
		velocity.x = 0
		
	elif Input.is_action_pressed("down"):
		currentDirection = "down"
		playAnimation(1)
		velocity.y = speed
		velocity.x = 0
		
	else:
		playAnimation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func playAnimation(movement):
	var direction = currentDirection
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			animation.play("stand_side")
	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			animation.play("stand_side")
	if direction == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_behind")
		elif movement == 0:
			animation.play("stand_behind")
	if direction == "down":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_front")
		elif movement == 0:
			animation.play("stand_front")
