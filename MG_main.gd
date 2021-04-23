tool
extends EditorPlugin

var dock
const root = "res://addons/2DMapGenerator"


func _enter_tree():
	#plugin initialisation
	#load the editor dock
	dock = load(root+"/DockMenu/Dock.tscn").instance()
	dock.name = "Map Noise Settings"
	#add the dock to the ui
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock)
	pass

func _exit_tree():
	#plugin cleanup
	#remove dock
	remove_control_from_docks(dock)
	#erase control from memory
	dock.free()
	pass
