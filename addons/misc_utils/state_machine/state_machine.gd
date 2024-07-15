class_name StateMachine extends Node


signal enter_state(state: StateBase)
signal exit_state(state: StateBase)

@export var initial_state: StateBase

var states: Array[StateBase]
var current_state: StateBase


func _ready() -> void:
	assert(initial_state, "initial_state is null.")
	current_state = initial_state
	
	_register_states()


func _process(delta: float) -> void:
	current_state._on_tick(delta)


func _physics_process(delta: float) -> void:
	current_state._on_physics_tick(delta)


func transit_state(next_state: StateBase) -> void:
	assert(next_state, "An invalid state was specified for transit_state.")
	current_state._on_exit()
	exit_state.emit(current_state)
	current_state = next_state
	enter_state.emit(current_state)
	current_state._on_enter()


func _register_states() -> void:
	var children := get_children()
	
	for child in children:
		if child is StateBase:
			var state := child as StateBase
			states.push_back(state)
			state.state_machine = self as StateMachine
			state._on_registered()
	
	assert(states, "There are no states in this state machine")
