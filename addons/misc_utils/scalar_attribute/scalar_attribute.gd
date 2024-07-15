class_name ScalarAttribute extends RefCounted


signal on_changed(delta: float)
signal on_maximized
signal on_minimized


var max_value: float = 1.0:
	set(value):
		max_value = maxf(value, min_value)
	get:
		return max_value

var min_value: float = 0.0:
	set(value):
		min_value = minf(value, max_value)
	get:
		return min_value

var current_value: float:
	set(value):
		value = clampf(current_value, min_value, max_value)
		if not is_equal_approx(value, current_value):
			on_changed.emit(value - current_value)
			if is_equal_approx(value, max_value):
				on_maximized.emit()
			elif is_equal_approx(value, min_value):
				on_minimized.emit()
			current_value = value
	get:
		return current_value


func _init(in_max_value: float = 1.0, in_min_value: float = 0.0) -> void:
	max_value = in_max_value
	min_value = in_min_value
	maximize()


func get_fraction() -> float:
	if is_equal_approx(min_value, max_value):
		return 1.0
	
	return (current_value - min_value) / (max_value - min_value)


func maximize() -> void:
	current_value = max_value


func minimize() -> void:
	current_value = min_value
