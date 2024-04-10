extends TileMap

@export var tileSet: TileSet

const dirt_Tile: Vector2i = Vector2i(9, 7)
const water_Tile: Vector2i = Vector2i(1, 11)

var size: int

# Called when the node enters the scene tree for the first time.
func _ready():
	size = 35
	
	Randomizer.Initialize();
	
	_generateFloor()
	_generateRiver()
	

func _generateFloor():
	for i in size:
		for j in size:
			set_cell(0, Vector2i(i,j), 0, dirt_Tile)

func _generateRiver():
	var simplexArray = Randomizer.SimplexGrid(size, size);
	
	# We start by getting the position of the highest value in the first row of the noise image
	var river = []
	river.append(Vector2i(size/2, 0))
	
	for i in range(0, size):
		if (simplexArray[i][0] > simplexArray[river[0].x][river[0].y]):
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
			if (simplexArray[localCell.x][localCell.y] > simplexArray[river[i].x][river[i].y]):
				river[i] = localCell
	
	for i in river:
		set_cell(0, i, 0, water_Tile)
