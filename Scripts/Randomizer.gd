extends Node

var rng = RandomNumberGenerator.new()

func Initialize(seed: String = "default"):
	var s = seed.hash()
	rng.seed = s;

func SimplexGrid(width: int, height: int, frequency: float = 0.01) -> Array:
	var noise = FastNoiseLite.new()
	noise.seed = rng.randi();
	noise.frequency = frequency
	var noiseImage: Image = noise.get_image(width, height)
	
	var result = []
	for i in width:
		result.append([]);
		for j in height:
			result[i].append(noiseImage.get_pixel(i,j).get_luminance());
	
	return result;
