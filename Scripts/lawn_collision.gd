extends Node2D

signal tile_hovered(tile)
signal tile_unhovered(tile)

#grabs the plant info and makes a ghost of plant at marker2DPlacement
func _on_static_body_2d_mouse_shape_entered(shape_idx: int) -> void:
	tile_hovered.emit(self)

#Removes Ghost
func _on_static_body_2d_mouse_shape_exited(shape_idx: int) -> void:
	tile_unhovered.emit(self)
