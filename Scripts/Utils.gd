extends Node

func distanceVector2i(v1: Vector2i, v2: Vector2i) -> int:
	var vec1 = Vector2(v1.x, v1.y);
	var vec2 = Vector2(v2.x, v2.y);
	return int(vec1.distance_to(vec2));
