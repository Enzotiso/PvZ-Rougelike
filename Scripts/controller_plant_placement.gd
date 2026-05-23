extends Node2D

var active_tile

#need to do
#connect to this to the seed_packets generated in seed_bar
#place ghost of current plant on marker when _on_tile_hovered is called
#place plant on click and remove it from mouse track
#actually probs just move the mouse track logic to here and only have seed_packet send plant info




#function is linked to lawn_collision under background Lawn node
func _on_tile_hovered(tile):
	active_tile = tile
	#plant_instance.global_position = tile.global_position
	print("here", tile)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for tile in $"../../Background Assets/Background Lawn".get_children():
		tile.tile_hovered.connect(_on_tile_hovered)
