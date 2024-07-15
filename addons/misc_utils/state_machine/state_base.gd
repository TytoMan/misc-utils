class_name StateBase extends Node


var state_machine: StateMachine


func transit_state(next_state: StateBase) -> void:
	state_machine.transit_state(next_state)


func _on_registered() -> void:
	pass


func _on_enter() -> void:
	pass


func _on_tick(delta: float) -> void:
	pass


func _on_physics_tick(delta: float) -> void:
	pass


func _on_exit() -> void:
	pass
