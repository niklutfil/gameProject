extends CharacterBody2D


var speed = 30
var playerChase = false
var player = null
var health = 100
var playerInAttackZone = false
var canTakeDamage = true


func _physics_process(delta):
	dealWithDamage()
	updateHealth()
	
	if playerChase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("move")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("stand")		

func _on_area_detection_body_entered(body):
	player = body
	playerChase = true
	
func _on_area_detection_body_exited(body):
	player = null
	playerChase = false
	
func slime():
	pass


func _on_slime_hitbox_body_entered(body):
	if body.has_method("player"):
		playerInAttackZone = true


func _on_slime_hitbox_body_exited(body):
	if body.has_method("player"):
		playerInAttackZone = false
		
func dealWithDamage():
	if playerInAttackZone and World.playerCurrentAttack == true:
		if canTakeDamage == true:
			health = health - 20
			$TakeDamegeCooldown.start()
			canTakeDamage = false
			print("slime health = ", health)
			if (health <= 0):
				self.queue_free()


func _on_take_damege_cooldown_timeout():
	canTakeDamage = true

func updateHealth():
	var healthBar = $SlimeHealthBar
	healthBar.value = health
	
	if health >= 100:
		healthBar.visible = true
	else:
		healthBar.visible = true
