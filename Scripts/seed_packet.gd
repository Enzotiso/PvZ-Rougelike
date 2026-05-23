extends Node2D

var pressed = false
var plant_scene
var plant_instance


#Needs some way to tell which plant is in this packet
#Place copy of plant over players cursor
#When mousing over a correct placement, ghost of plant over that
#Places plant only on select spaces on the lawn grid
#Can be canceled with right click, clicking the button again, or by trying to place a plant where it isnt allowed 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plant_scene = preload("res://Scenes/attack-plant.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pressed:
		plant_instance.global_position = get_global_mouse_position() + Vector2(-50,-50) #Vector 2 to center cursor on plant, use markers later


func _on_button_seedpacket_button_up() -> void:
	pressed = true
	plant_instance = plant_scene.instantiate()
	get_tree().current_scene.add_child(plant_instance)
