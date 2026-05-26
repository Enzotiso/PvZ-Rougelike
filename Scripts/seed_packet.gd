extends Node2D

var plant_scene
signal seedpacket_pressed()

# Called when the node enters the scene tree for the first time.
# Needs to change based on plants selected in plase_1
func _ready() -> void:
	plant_scene = preload("res://Scenes/attack-plant.tscn")

# signals that the button was pressed to controller_plantPlacement
func _on_button_seedpacket_button_up() -> void:
	seedpacket_pressed.emit(plant_scene)
