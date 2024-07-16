class_name StateBase extends Node


signal request_transit_state(next_state: StateBase)


func transit_state(next_state: StateBase) -> void:
	request_transit_state.emit(next_state)


func _on_registered() -> void:
	pass


func _on_state_enter() -> void:
	pass


func _on_state_exit() -> void:
	pass
