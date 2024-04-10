extends Node

var rng = RandomNumberGenerator.new()

func Initialize(seed: String = "default"):
	var s = 0;
	
	for c in seed:
		s += int(c);
	
	rng.seed = s;

func Irand(from: int = 0, to: int = 4294967295) -> int:
	return rng.randi_range(from, to);

func Frand(from: float = 0.0, to: float = 1.0) -> float:
	return rng.randf_range(from, to);

func SimplexGrid(width: int, height: int, frequency: float = 0.01) -> Array:
	var noise = FastNoiseLite.new()
	noise.seed = Irand()
	noise.frequency = frequency
	var noiseImage: Image = noise.get_image(width, height)
	
	var result = []
	for i in width:
		result.append([]);
		for j in height:
			result[i].append(noiseImage.get_pixel(i,j).get_luminance());
	
	return result;
