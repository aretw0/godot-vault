extends Node2D
## Main example scene demonstrating core systems

@onready var info_label: RichTextLabel = $CanvasLayer/UI/MarginContainer/VBoxContainer/InfoLabel

func _ready() -> void:
	# Register for EventBus events
	EventBus.on("test_event", _on_test_event)
	
	print("Godot Vault initialized successfully!")
	print("Core systems loaded:")
	print("  - EventBus")
	print("  - GameManager")
	print("  - StateMachine")
	print("  - GameUtils")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Test EventBus communication
		EventBus.emit("test_event", {"message": "EventBus is working!"})

func _on_test_event(data: Dictionary) -> void:
	print("EventBus test: ", data.message)
	if info_label:
		info_label.text += "\n\n[color=green]✓ EventBus test successful![/color]"
