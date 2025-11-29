extends Node2D

var map_width = 256
var map_height = 128
var noise_scale = .1

var deepwater_threshold = 0.4
var water_threshold = 0.5
var beach_threshold = .55
var plains_threshold = .65
var hill_threshold = .75
var mountains_threshold = .8
var extrememountains_threshold = .85
#deep water, water, beach, plains, hills, mountains,extreme mountains 

@onready var tilemap: TileMapLayer = $TileMapLayer

func generate_map():
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_scale
	
	tilemap.clear()
	
	for x in range(map_width):
		for y in range(map_height):
			var noise_value = noise.get_noise_2d(x,y)
			noise_value = (noise_value +1)/2
			
			var tile_pos = Vector2i(x,y)
			var atlas_coords = Vector2i(0,0)
			
			if noise_value < deepwater_threshold:
				atlas_coords = Vector2i(3,1)
			elif noise_value < water_threshold:
				atlas_coords = Vector2i(3,3)
			elif noise_value < beach_threshold:
				atlas_coords = Vector2i(2,2)
			elif noise_value < plains_threshold:
				atlas_coords = Vector2i(1,2)
			elif noise_value < hill_threshold:
				atlas_coords = Vector2i(1,1)
			elif noise_value < mountains_threshold:
				atlas_coords = Vector2i(2,1)
			elif noise_value < extrememountains_threshold:
				atlas_coords = Vector2i(1,0)
			else:
				atlas_coords = Vector2i(0,3)
			
			tilemap.set_cell(tile_pos,1,atlas_coords)
			
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_map()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
