extends TileMap
class_name Map
tool

var index:float
var n:float
var locked:bool 
export var size:int = 512 
var def_tiles = preload("res://Assets/cells.tres")
var sea_level = 0.5
var beach_size = 0.12

export var noise:OpenSimplexNoise = OpenSimplexNoise.new()

func _enter_tree():
	scale = Vector2(1,1)
	if!locked: 
		#only runs in editor
		tile_set = def_tiles
		cell_size = Vector2(32,32)
		update_cells() 
	

func exit_tree():
	pass

func _ready():
#	update_cells()
	pass # Replace with function body.

func update_cells():
	for x in range(size):
		for y in range(size):
			n = island(x,y)
			if n > sea_level:
				set_cell(x,y,0)
			elif n >(sea_level - beach_size):
				set_cell(x,y,2)
			else:
				set_cell(x,y,1)

func island(x:float,y:float):
	var disX = float(abs(x - size * 0.5))
	var disY = float(abs(y - size * 0.5))
	var dis = sqrt(disX*disX + disY*disY)
	
	var max_width = size * 0.5 -10.0
	var del = dis/max_width
	var gradient= del*del
	n = (1+noise.get_noise_2d(x,y)) * max(0.0,1.0-gradient)
	return n
