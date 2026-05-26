extends Node2D

var plant_instance = null
var plant_ghost = null
var track_to_mouse = false
var active_tile = null
var current_seed_packet = null

#need to do
#clicking another seedpacket removes plant from cursor and replaces it with the one clicked

#clears current plant information
func clear_plant():
	track_to_mouse = false
	plant_instance.queue_free()
	if active_tile != null and plant_ghost != null and plant_ghost.get_parent() != null:
		active_tile.remove_child(plant_ghost)
	plant_instance = null
	plant_ghost = null
	current_seed_packet = null

#places plant inside a lawn_collision on the marker2DPlacement
func plant_on_lawn():
	#check for tile ghost is over & if there is a plant selected
	if active_tile != null and plant_instance != null and !active_tile.occupied:
		track_to_mouse = false
		plant_instance.reparent(active_tile)
		active_tile.occupied = true
		plant_instance.held = false
		plant_instance.global_position = active_tile.find_child("Marker2DPlacement").global_position
		plant_instance = null #clears instance
		
#handles what to do when a seed packet is selected
func seed_packet_pressed(plant_scene, seed_packet):
	if !track_to_mouse:
		current_seed_packet = seed_packet
		track_plant_to_mouse(plant_scene)
	elif seed_packet != current_seed_packet:
		#code for tracking the new plant that was picked
		pass
	else:
		clear_plant()

#function is linked to lawn_collision under background Lawn node
func _on_tile_hovered(tile):
	#Checks if plant is selectd and if something is already planted there
	if plant_instance != null and !tile.occupied:
		active_tile = tile
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
			active_tile = null

func track_plant_to_mouse(plant_scene):
	track_to_mouse = true
	plant_instance = plant_scene.instantiate() #current selected plant
	plant_ghost = plant_scene.instantiate()
	plant_ghost.find_child("Sprite2D").self_modulate.a = .5 #changes ghost opacity
	get_tree().current_scene.add_child(plant_instance)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			plant_on_lawn() #plants plant_instance on active_tile
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and plant_instance != null:
			clear_plant() #clears plant_instance and plant_ghost

func _ready() -> void:
	# Links _on_tile_hovered to each lawn collision scene under background lawn
	for lawn_collision in $"../../Background Assets/Background Lawn".get_children():
		lawn_collision.tile_hovered.connect(_on_tile_hovered)
		lawn_collision.tile_unhovered.connect(_on_tile_unhovered)
	# Links track_plant_to_mouse to seed_packet under seed_bar
	for seed_packets in $"../../Background Assets/Seed_Bar/Seed_Packets".get_children():
		seed_packets.seedpacket_pressed.connect(seed_packet_pressed)

func _process(delta: float) -> void:
	# Tracks plant to mouse, (use a marker for center of plant in the future)
	if track_to_mouse:
		plant_instance.global_position = get_global_mouse_position() + Vector2(0, 75) #Vector 2 to center cursor on plant, use markers later
