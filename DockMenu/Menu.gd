extends VBoxContainer
tool

var world:Map
var path: NodePath 

#local
var l_seed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_PathInput_text_changed(new_text):
	var pth = NodePath(new_text)
	world = get_tree().edited_scene_root.get_node_or_null(pth)
	$HSplitContainer2/SeedEdit.text = String(world.noise.seed)
	$HSplitContainer3/OctavesEdit.text = String(world.noise.octaves)
	$HSplitContainer4/PeriodEdit.text = String(world.noise.period)
	$HSplitContainer5/PeristenceEdit.text = String(world.noise.persistence)
	$HSplitContainer6/LacunarityEdit.text = String(world.noise.lacunarity)
	
	$HSplitContainer7/VSplitContainer2/SeaSlider.value = world.sea_level
	$HSplitContainer7/VSplitContainer2/SeaLabel.text = String(world.sea_level)
	$HSplitContainer8/VSplitContainer/BeachSlider.value = world.beach_size
	$HSplitContainer8/VSplitContainer/BeachLabel.text = String(world.beach_size)
	
	print(world)


func _on_Generate_pressed():
	if world:
		world.update_cells()
	else:
		print("no world loaded")
	pass # Replace with function body.

func _on_SeedEdit_text_changed(new_text):
	if int(new_text):
		world.noise.seed = int(new_text)
		world.update_cells()


func _on_OctavesEdit_text_changed(new_text):
	if int(new_text):
		world.noise.octaves = int(new_text)
		world.update_cells()


func _on_PeriodEdit_text_changed(new_text):
	if int(new_text):
		world.noise.period = int(new_text)
		world.update_cells()


func _on_PeristenceEdit_text_changed(new_text):
	if float(new_text):
		world.noise.persistence = float(new_text)
		world.update_cells()


func _on_LacunarityEdit_text_changed(new_text):
	if int(new_text):
		world.noise.lacunarity = int(new_text)
		world.update_cells()


func _on_BeachSlider_value_changed(value):
	$HSplitContainer8/VSplitContainer/BeachLabel.text = String(value)
	world.beach_size = value
	pass # Replace with function body.


func _on_SeaSlider_value_changed(value):
	$HSplitContainer7/VSplitContainer2/SeaLabel.text = String(value)
	world.sea_level = value
	pass # Replace with function body.


func _on_Button_pressed():
	if (world.locked):
		$lockConfirm.popup_centered()
	else:
		world.locked = true
		$Button.text = "UNLOCK"

func _on_lockConfirm_confirmed():
	world.locked = false
	$Button.text = "LOCK"
	pass # Replace with function body.
