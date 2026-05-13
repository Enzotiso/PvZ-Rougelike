extends Node2D

var attack_projectile = preload("res://Scenes/attack_projectile.tscn")

var offCooldown = true

# Spawns the Projectiles the plant shoots
func spawn_projectile():
	var projectile_instance = attack_projectile.instantiate()
	projectile_instance.position = $Marker2D.position #offset to shoot from plant head
	add_child(projectile_instance)
	
# A timer between plant shots
func cooldown():
	offCooldown = false
	await get_tree().create_timer(1.5).timeout
	offCooldown = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
		# Actually make sure this can only activate for enemies in the plant's row
		# So maybe theres a way to set layers 1-5 depending on the row the plant is placed in
		# Then have the same for the row the enemies are spawned in so even if lower enemy sprites overlap
		# It still only activates for enemies in that specific row	
func _process(delta: float) -> void:
	if $RayCastRight.is_colliding() and offCooldown:	# Detects if enemy is in path of plant, then fires at it
		spawn_projectile()
		cooldown()
