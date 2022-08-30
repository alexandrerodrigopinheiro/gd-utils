extends Node2D

const Datetime := preload("res://scripts/datetime.gd")
const Utils := preload("res://scripts/utils.gd")
const Format := preload("res://scripts/format.gd")

func _ready() -> void:
	var now := Datetime.now()
	var fut := Datetime.to_dict("2023-09-30T23:30:30-03:00")

	print("DATETIME")
	prints("now", Datetime.now())
	prints("sum", Datetime.sum(15))
	prints("sub", Datetime.sum(-15))

	prints("is_after", Datetime.is_after(now, fut))
	prints("is_before", Datetime.is_before(now, fut))
	prints("interval", Datetime.interval(now, fut))

	prints("to_str", Datetime.to_str(now))
	prints("to_dict", Datetime.to_dict(Datetime.to_str(now)))

	print("FORMAT")
	prints("to_monetary", Format.to_monetary(12486565455.9356))
	prints("to_datetime_pretty", Format.to_datetime_pretty(now))

	print("UTILS")
	Utils.pause_input(self, true)
	Utils.pause_process(self, true)
	Utils.pause_scene(self, true)
