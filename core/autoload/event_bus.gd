extends Node
## Global Event Bus for decoupled communication
##
## The EventBus provides a central hub for game-wide event communication,
## allowing systems to communicate without direct dependencies.
##
## Usage:
##   EventBus.emit("player_died", { "position": player_pos })
##   EventBus.on("player_died", _on_player_died)

## Dictionary to store event listeners
var _listeners: Dictionary = {}


## Emits an event with optional data
func emit(event_name: String, data: Variant = null) -> void:
	if not _listeners.has(event_name):
		return

	for callback in _listeners[event_name]:
		if data != null:
			callback.call(data)
		else:
			callback.call()


## Registers a callback for an event
func on(event_name: String, callback: Callable) -> void:
	if not _listeners.has(event_name):
		_listeners[event_name] = []

	if not _listeners[event_name].has(callback):
		_listeners[event_name].append(callback)


## Unregisters a callback from an event
func off(event_name: String, callback: Callable) -> void:
	if not _listeners.has(event_name):
		return

	_listeners[event_name].erase(callback)


## Clears all listeners for an event
func clear(event_name: String) -> void:
	if _listeners.has(event_name):
		_listeners.erase(event_name)


## Clears all event listeners
func clear_all() -> void:
	_listeners.clear()
