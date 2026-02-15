class_name State
extends Node
## Base State class for use with StateMachine
##
## Extend this class to create custom states for your state machine.
## Override enter(), exit(), update(), and physics_update() as needed.


## Called when entering this state
func enter(_data: Dictionary = {}) -> void:
	pass


## Called when exiting this state
func exit() -> void:
	pass


## Called every frame while in this state
func update(_delta: float) -> void:
	pass


## Called every physics frame while in this state
func physics_update(_delta: float) -> void:
	pass
