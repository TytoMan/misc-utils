@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("EasySave", "RefCounted", preload("res://addons/misc_utils/easy_save/easy_save.gd"), null)
	add_custom_type("ScalarAttribute", "RefCounted", preload("scalar_attribute/scalar_attribute.gd"), null)
	add_custom_type("Spectator3D", "Camera3D", preload("spectator/spectator3d.gd"), null)
	add_custom_type("StateBase", "Node", preload("state_machine/state_base.gd"), null)
	add_custom_type("StateMachine", "Node", preload("state_machine/state_machine.gd"), null)


func _exit_tree() -> void:
	remove_custom_type("EasySave")
	remove_custom_type("ScalarAttribute")
	remove_custom_type("Spectator")
	remove_custom_type("StateBase")
	remove_custom_type("StateMachine")
