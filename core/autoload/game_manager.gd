extends Node
## Global Game Manager
##
## Manages game-wide state and provides convenient access to common operations.
## This is an autoload singleton.

## Game state enumeration
enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }

var current_state: GameState = GameState.MENU
var score: int = 0
var time_scale: float = 1.0:
	set(value):
		time_scale = value
		Engine.time_scale = value


## Pauses the game
func pause_game() -> void:
	get_tree().paused = true
	current_state = GameState.PAUSED
	EventBus.emit("game_paused")


## Resumes the game
func resume_game() -> void:
	get_tree().paused = false
	current_state = GameState.PLAYING
	EventBus.emit("game_resumed")


## Restarts the current scene
func restart_scene() -> void:
	get_tree().reload_current_scene()


## Loads a scene by path
func load_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)


## Quits the game
func quit_game() -> void:
	get_tree().quit()
