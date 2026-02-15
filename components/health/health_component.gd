class_name HealthComponent
extends Node
## Reusable health management component
##
## Attach this to any node that needs health tracking.
## Emits signals when health changes or entity dies.

signal health_changed(current: int, maximum: int)
signal died
signal damage_taken(amount: int)
signal healed(amount: int)

@export_group("Health Settings")
@export var max_health: int = 100
@export var start_at_max: bool = true
@export var can_revive: bool = false

var current_health: int:
	set(value):
		var old_health = current_health
		current_health = clamp(value, 0, max_health)
		health_changed.emit(current_health, max_health)

		if current_health <= 0 and old_health > 0:
			died.emit()
			EventBus.emit("entity_died", {"component": self})

var is_alive: bool:
	get:
		return current_health > 0


func _ready() -> void:
	if start_at_max:
		current_health = max_health


## Takes damage, reducing current health
func take_damage(amount: int) -> void:
	if not is_alive:
		return

	current_health -= amount
	damage_taken.emit(amount)
	EventBus.emit(
		"damage_dealt",
		{"amount": amount, "target": get_parent(), "remaining_health": current_health}
	)


## Heals, increasing current health
func heal(amount: int) -> void:
	if not is_alive and not can_revive:
		return

	var old_health = current_health
	current_health += amount
	var actual_heal = current_health - old_health

	if actual_heal > 0:
		healed.emit(actual_heal)


## Fully restores health
func restore_full() -> void:
	heal(max_health - current_health)


## Returns health as percentage (0.0 to 1.0)
func get_health_percentage() -> float:
	return float(current_health) / float(max_health)


## Instantly kills the entity
func kill() -> void:
	current_health = 0
