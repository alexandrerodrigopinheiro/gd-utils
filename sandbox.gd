extends Node2D

const Timedate := preload("res://scripts/datetime.gd")

var _timedate := Timedate.new()

func _ready() -> void:
	var now := _timedate.now()
	var fut := _timedate.to_dict("2023-09-30T23:30:30-03:00")

	prints("now", _timedate.now())
	prints("sum", _timedate.sum(15))
	prints("sub", _timedate.sum(-15))

	prints("is_after", _timedate.is_after(now, fut))
	prints("is_before", _timedate.is_before(now, fut))
	prints("interval", _timedate.interval(now, fut))

	prints("to_str", _timedate.to_str(now))
	prints("to_dict", _timedate.to_dict(_timedate.to_str(now)))
