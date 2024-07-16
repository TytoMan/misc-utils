class_name StateMachine extends Node


signal enter_state(state: StateBase)
signal exit_state(state: StateBase)

@export var initial_state: StateBase

var current_state: StateBase


func _ready() -> void:
	_init_state_machine()


func transit_state(next_state: StateBase) -> void:
	assert(next_state, "An invalid state was specified for transit_state.")
	_state_exit_process()
	current_state = next_state
	_state_enter_process()


func _init_state_machine() -> void:
	var children := get_children()
	for child in children:
		if child is StateBase:
			var state := child as StateBase
			state.process_mode = Node.PROCESS_MODE_DISABLED
			state.request_transit_state.connect(transit_state)
			state._on_registered()
	
	assert(initial_state, "initial_state is null.")
	current_state = initial_state
	_state_enter_process()


func _state_enter_process() -> void:
	current_state._on_state_enter()
	enter_state.emit(current_state)
	current_state.process_mode = Node.PROCESS_MODE_INHERIT


func _state_exit_process() -> void:
	current_state.process_mode = Node.PROCESS_MODE_DISABLED
	exit_state.emit(current_state)
	current_state._on_state_exit()
