extends CharacterBody2D

var slimeInAttackRange = false
var slimeAttackCooldown = true
var health = 100
var playerAlive = true
var attackIp = false

const speed = 150
var currentDirection = "none"

func _ready():
	$AnimatedSprite2D.play("stand_front")
	
func _physics_process(delta):
	playerMovement()
	slimeAttack()
	attack()
	currentCamera()
	updateHealth()
	
	if health <= 0:
		playerAlive = false # go to main menu or respond
		health = 0
		print("player have been dead")
		self.queue_free()

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
			if attackIp == false:
				animation.play("stand_side")
	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			if attackIp == false:
				animation.play("stand_side")
	if direction == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_behind")
		elif movement == 0:
			if attackIp == false:
				animation.play("stand_behind")
	if direction == "down":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_front")
		elif movement == 0:
			if attackIp == false:
				animation.play("stand_front")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("slime"):
		slimeInAttackRange = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("slime"):
		slimeInAttackRange = false
		
func slimeAttack():
	if slimeInAttackRange and slimeAttackCooldown == true:
		health = health - 10
		slimeAttackCooldown = false
		$AttackCooldown.start()
		print("health")


func _on_attack_cooldown_timeout():
	slimeAttackCooldown = true

func attack():
	var direction = currentDirection
	
	if Input.is_action_just_pressed("attack"):
		World.playerCurrentAttack =  true
		attackIp = true
		if direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack_side")
			$DealAttackTimer.start()
		if direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack_side")
			$DealAttackTimer.start()
		if direction == "down":
			$AnimatedSprite2D.play("attack_front")
			$DealAttackTimer.start()
		if direction == "up":
			$AnimatedSprite2D.play("attack_behind")
			$DealAttackTimer.start()	

func _on_deal_attack_timer_timeout():
	$DealAttackTimer.stop()
	World.playerCurrentAttack = false
	attackIp =false

func currentCamera():
	if World.currentScene == "level1":
		$Level1Camera.enabled = true
		$Level1_1Camera.enabled = false
	elif World.currentScene == "level1.1":
		$Level1Camera.enabled = false
		$Level1_1Camera.enabled = true

func updateHealth():
	var healthBar = $PlayerHealthBar
	healthBar.value = health
	
	if health >= 100:
		healthBar.visible = true
	else:
		healthBar.visible = true

func _on_regenerate_timer_timeout():
	if health <= 100:
		health = health + 20 
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
