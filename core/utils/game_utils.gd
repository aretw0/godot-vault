extends Node
class_name GameUtils
## Collection of useful utility functions

## Safely frees a node after a delay
static func delayed_free(node: Node, delay: float = 0.0) -> void:
	if delay > 0.0:
		await node.get_tree().create_timer(delay).timeout
	node.queue_free()

## Clamps a vector to a maximum magnitude
static func clamp_vector(vec: Vector2, max_magnitude: float) -> Vector2:
	if vec.length() > max_magnitude:
		return vec.normalized() * max_magnitude
	return vec

## Returns a random point within a circle
static func random_point_in_circle(radius: float) -> Vector2:
	var angle = randf() * TAU
	var distance = sqrt(randf()) * radius
	return Vector2(cos(angle), sin(angle)) * distance

## Converts seconds to a time string (MM:SS)
static func seconds_to_time_string(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	return "%02d:%02d" % [mins, secs]

## Lerps a value with framerate independence
static func smooth_lerp(current: float, target: float, speed: float, delta: float) -> float:
	return lerp(current, target, 1.0 - exp(-speed * delta))

## Lerps a Vector2 with framerate independence
static func smooth_lerp_vec2(current: Vector2, target: Vector2, speed: float, delta: float) -> Vector2:
	return current.lerp(target, 1.0 - exp(-speed * delta))
