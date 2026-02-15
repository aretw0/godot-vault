class_name StateMachine
extends Node
## Generic State Machine implementation
##
## A reusable state machine that can be used for AI, player controllers,
## UI flows, and any other state-based logic.
##
## Usage:
##   var sm = StateMachine.new()
##   sm.add_state("idle", idle_state)
##   sm.add_state("walk", walk_state)
##   sm.set_initial_state("idle")
##   sm.transition_to("walk")

signal state_changed(from_state: String, to_state: String)

var _states: Dictionary = {}
var _current_state: Node = null
var _current_state_name: String = ""


## Adds a state to the machine
func add_state(state_name: String, state_node: Node) -> void:
	_states[state_name] = state_node
	add_child(state_node)
	state_node.set_process(false)
	state_node.set_physics_process(false)


## Sets the initial state (doesn't call enter)
func set_initial_state(state_name: String) -> void:
	if not _states.has(state_name):
		push_error("State '%s' does not exist" % state_name)
		return

	_current_state = _states[state_name]
	_current_state_name = state_name
	_current_state.set_process(true)
	_current_state.set_physics_process(true)

	if _current_state.has_method("enter"):
		_current_state.enter()


## Transitions to a new state
func transition_to(new_state_name: String, data: Dictionary = {}) -> void:
	if not _states.has(new_state_name):
		push_error("State '%s' does not exist" % new_state_name)
		return

	if _current_state_name == new_state_name:
		return

	var previous_state_name = _current_state_name

	# Exit current state
	if _current_state != null:
		if _current_state.has_method("exit"):
			_current_state.exit()
		_current_state.set_process(false)
		_current_state.set_physics_process(false)

	# Enter new state
	_current_state = _states[new_state_name]
	_current_state_name = new_state_name
	_current_state.set_process(true)
	_current_state.set_physics_process(true)

	if _current_state.has_method("enter"):
		_current_state.enter(data)

	state_changed.emit(previous_state_name, new_state_name)


## Returns the current state name
func get_current_state() -> String:
	return _current_state_name


## Returns the current state node
func get_current_state_node() -> Node:
	return _current_state


## Processes the current state
func _process(delta: float) -> void:
	if _current_state != null and _current_state.has_method("update"):
		_current_state.update(delta)


## Physics processes the current state
func _physics_process(delta: float) -> void:
	if _current_state != null and _current_state.has_method("physics_update"):
		_current_state.physics_update(delta)
