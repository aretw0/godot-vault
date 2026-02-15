extends Camera2D
class_name FollowCamera
## Smooth camera that follows a target
##
## Attach to a scene and set the target to the node you want to follow.
## Camera will smoothly follow with configurable lerp speed.

@export_group("Target")
@export var target: Node2D = null
@export var auto_find_player: bool = true

@export_group("Follow Settings")
@export var follow_speed: float = 5.0
@export var offset_from_target: Vector2 = Vector2.ZERO

@export_group("Limits")
@export var use_limits: bool = false
@export var limit_rect: Rect2 = Rect2(-1000, -1000, 2000, 2000)

@export_group("Shake")
@export var shake_decay: float = 5.0

var _shake_amount: float = 0.0
var _shake_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	if auto_find_player and target == null:
		target = get_tree().get_first_node_in_group("player")
	
	if use_limits:
		limit_left = int(limit_rect.position.x)
		limit_top = int(limit_rect.position.y)
		limit_right = int(limit_rect.position.x + limit_rect.size.x)
		limit_bottom = int(limit_rect.position.y + limit_rect.size.y)

func _process(delta: float) -> void:
	if target == null:
		return
	
	# Follow target
	var target_pos = target.global_position + offset_from_target
	global_position = GameUtils.smooth_lerp_vec2(
		global_position,
		target_pos,
		follow_speed,
		delta
	)
	
	# Apply shake
	if _shake_amount > 0:
		_shake_amount = max(0, _shake_amount - shake_decay * delta)
		_shake_offset = GameUtils.random_point_in_circle(_shake_amount)
		offset = _shake_offset
	else:
		offset = Vector2.ZERO

## Triggers a camera shake effect
func shake(amount: float) -> void:
	_shake_amount = amount

## Sets a new target to follow
func set_target(new_target: Node2D) -> void:
	target = new_target
