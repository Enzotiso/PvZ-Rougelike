extends Node2D
#for bullets to appear over plants
#Y Sort Enabled under ordering & set z Index to 100

# Sets speed of this projectile
@export var speed := 400.0
var direction := Vector2.RIGHT

func _ready() -> void:
	$Sprite2D.modulate = Color(0.5, 0.5, 0.5)

# deletes projectle on enemy hit
func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()

# Moves projectile towards the enemy
func _process(delta):
	position += direction * speed * delta
