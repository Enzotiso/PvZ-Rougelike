extends Node2D

#Preloads seedpacket
const Seedpacket = preload("res://Scenes/seed_packet.tscn")




# Remake this function when you recreate the seed packet selection menu
func populateSeedBar():
	var new_instance = Seedpacket.instantiate()
	new_instance.global_position = $Sprite2D/Marker2DSeedslot1.global_position
	$Seed_Packets.add_child(new_instance)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populateSeedBar()
