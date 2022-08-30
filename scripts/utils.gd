extends Node


static func pause_input(node: Node, paused: bool, deep:= true) -> void:
	node.set_process_input(!paused)
	node.set_process_unhandled_input(!paused)
	node.set_process_unhandled_key_input(!paused)

	if not deep:
		return

	for child in node.get_children():
		pause_input(child, paused, deep)


static func pause_process(node: Node, paused: bool, deep:= true) -> void:
	node.set_process(!paused)
	node.set_process_internal(!paused)

	node.set_physics_process(!paused)
	node.set_physics_process_internal(!paused)

	if not deep:
		return

	for child in node.get_children():
		pause_process(child, paused)


static func pause_scene(node: Node, paused: bool, deep:= true) -> void:
	node.set_process(!paused)
	node.set_process_internal(!paused)

	node.set_physics_process(!paused)
	node.set_physics_process_internal(!paused)

	node.set_process_input(!paused)
	node.set_process_unhandled_input(!paused)
	node.set_process_unhandled_key_input(!paused)

	if not deep:
		return

	for child in node.get_children():
		pause_scene(child, paused)
