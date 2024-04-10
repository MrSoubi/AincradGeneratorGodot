extends TileMap

@export var tileSet: TileSet

const dirt_Tile: Vector2i = Vector2i(9, 7)
const water_Tile: Vector2i = Vector2i(1, 11)

var size: int

# Called when the node enters the scene tree for the first time.
func _ready():
	size = 35
	
	_generateFloor()
	_generateRiver()
	

func _generateFloor():
	for i in size:
		for j in size:
			set_cell(0, Vector2i(i,j), 0, dirt_Tile)

func _generateRiver():
	# We generate a noise image of the same size as the level
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.frequency = 0.03
	var noiseImage: Image = noise.get_image(size, size)
	
	# We start by getting the position of the highest value in the first row of the noise image
	var river = []
	river.append(Vector2i(size/2, 0))
	
	for i in range(0, size):
		if (noiseImage.get_pixel(i, 0).get_luminance() > noiseImage.get_pixelv(river[0]).get_luminance()):
			river[0].x = i
	
	for i in range(1, size):
		# Set the next cell of the river beneath the last one
		river.append(river[i-1])
		river[i].y += 1
		
		for j in range(-1, 2):
			var localCell = river[i]
			localCell.x = (river[i].x + j)
			
			if (localCell.x <= 0):
				localCell.x += 1
			
			if (localCell.x >= size):
				localCell.x -= 1
			
			print(localCell)
			if (noiseImage.get_pixelv(localCell).get_luminance() > noiseImage.get_pixelv(river[i]).get_luminance()):
				river[i] = localCell
	
	for i in river:
		set_cell(0, i, 0, water_Tile)
