extends TileMap

@export var tileSet: TileSet

const dirt_Tile: Vector2i = Vector2i(9, 7)
const water_Tile: Vector2i = Vector2i(1, 11)
const village_Tile: Vector2i = Vector2i(11, 15)
const dungeon_Tile: Vector2i = Vector2i(15, 17)

var village_Pos: Vector2i;
var dungeon_Pos: Vector2i;

var size: int

func _center():
	position.x = - (size * 8)
	position.y = - (size * 8)

func Gen(level: int):
	size = 36 - level
	_center()
	_generateFloor()
	_generateRiver()
	_setVillage()
	_setDungeon()

func _input(event):
	if event.is_action_pressed("jump"):
		Gen(1);

func _setVillage():
	var pos = Vector2i(Randomizer.rng.randi_range(0, size-1), Randomizer.rng.randi_range(size/2, size-1))
	
	while (get_cell_atlas_coords(0, pos) != dirt_Tile):
		pos = Vector2i(Randomizer.rng.randi_range(0, size-1), Randomizer.rng.randi_range(size/2, size-1))
	
	village_Pos = pos
	set_cell(0, village_Pos, 0, village_Tile);

func _setDungeon(distanceMin: int = size/2):
	var pos = Vector2i(Randomizer.rng.randi_range(0, size-1), Randomizer.rng.randi_range(0, size/2))
	
	while (Utils.distanceVector2i(pos, village_Pos) < distanceMin):
		pos = Vector2i(Randomizer.rng.randi_range(0, size-1), Randomizer.rng.randi_range(0, size/2))
	
	dungeon_Pos = pos
	set_cell(0, pos, 0, dungeon_Tile);

func _generateFloor():
	for i in size:
		for j in size:
			set_cell(0, Vector2i(i,j), 0, dirt_Tile)

func _generateRiver():
	var simplexArray = Randomizer.SimplexGrid(size, size, 0.05);
	
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
			
			if (simplexArray[localCell.x][localCell.y] > simplexArray[river[i].x][river[i].y]):
				river[i] = localCell
	
	for i in river:
		set_cell(0, i, 0, water_Tile)
