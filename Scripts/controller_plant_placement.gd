extends Node2D

var active_tile = null
var plant_instance = null
var plant_ghost = null
var pressed = false

#need to do
#place plant on click and remove it from mouse track
#clicking another seedpacket removes plant from cursor and replaces it with the one clicked
#clicking the same seed packet remove plant from cursor
#clicking right click removes plant from cursor

#function is linked to lawn_collision under background Lawn node
func _on_tile_hovered(tile):
	if plant_instance != null:
		#checks if plant_ghost is in the scene already, if so reparents instead
		if plant_ghost.get_parent() == null:
			tile.add_child(plant_ghost)
		else:
			plant_ghost.reparent(tile)
		
		#moves the ghost to each marker
		plant_ghost.global_position = tile.find_child("Marker2DPlacement").global_position

#function is linked to lawn_collision under background Lawn node
func _on_tile_unhovered(tile):
	if plant_instance != null:
		#removes ghost from board if mouse is over no collisions
		if plant_ghost.get_parent() == tile:
			tile.remove_child(plant_ghost)

func track_plant_to_mouse(plant_scene):
	pressed = true
	plant_instance = plant_scene.instantiate()
	plant_ghost = plant_scene.instantiate()
	plant_ghost.find_child("Sprite2D").self_modulate.a = .5 #changes ghost opacity
	get_tree().current_scene.add_child(plant_instance)
	

func _ready() -> void:
	# Links _on_tile_hovered to each lawn collision scene under background lawn
	for lawn_collision in $"../../Background Assets/Background Lawn".get_children():
		lawn_collision.tile_hovered.connect(_on_tile_hovered)
		lawn_collision.tile_unhovered.connect(_on_tile_unhovered)
	# Links track_plant_to_mouse to seed_packet under seed_bar
	for seed_packets in $"../../Background Assets/Seed_Bar/Seed_Packets".get_children():
		seed_packets.seedpacket_pressed.connect(track_plant_to_mouse)

func _process(delta: float) -> void:
	# Tracks plant to mouse, (use a marker for center of plant in the future)
	if pressed:
		plant_instance.global_position = get_global_mouse_position() + Vector2(0, 75) #Vector 2 to center cursor on plant, use markers later
