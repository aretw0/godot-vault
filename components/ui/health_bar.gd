extends Control
class_name UIHealthBar
## UI component for displaying health
##
## Connects to a HealthComponent and displays health visually.

@export var health_component: HealthComponent = null
@export var auto_find_health_component: bool = true

@export_group("Visual")
@export var fill_color: Color = Color.GREEN
@export var low_health_color: Color = Color.RED
@export var low_health_threshold: float = 0.3
@export var smooth_transition: bool = true
@export var transition_speed: float = 10.0

@onready var background: ColorRect = $Background
@onready var fill: ColorRect = $Background/Fill

var _target_scale: float = 1.0

func _ready() -> void:
	if auto_find_health_component and health_component == null:
		# Try to find in parent
		var parent = get_parent()
		if parent is Node:
			health_component = parent.get_node_or_null("HealthComponent")
	
	if health_component:
		health_component.health_changed.connect(_on_health_changed)
		_update_bar(health_component.get_health_percentage())

func _process(delta: float) -> void:
	if smooth_transition and fill:
		fill.scale.x = lerp(fill.scale.x, _target_scale, transition_speed * delta)

func _on_health_changed(current: int, maximum: int) -> void:
	var percentage = float(current) / float(maximum)
	_update_bar(percentage)

func _update_bar(percentage: float) -> void:
	_target_scale = percentage
	
	if not smooth_transition and fill:
		fill.scale.x = percentage
	
	# Change color based on health
	if fill and percentage <= low_health_threshold:
		fill.color = low_health_color
	elif fill:
		fill.color = fill_color
