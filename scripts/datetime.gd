extends Node

const _MIN_MONTH := 1
const _MAX_MONTH := 12
const _MONTHS := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
const _LEAP_MONTHS := [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]


static func now() -> Dictionary:
	var tm := OS.get_datetime()
	var tz := OS.get_time_zone_info().name as int \
			if OS.get_time_zone_info().name as int > 0 \
			else OS.get_time_zone_info().name as int * -1
	var sg := 1 if OS.get_time_zone_info().name as int > 0 else -1
	return {
		"year": tm.year,
		"month": tm.month,
		'day': tm.day,
		"hour": tm.hour,
		"minute": tm.minute,
		"second":  tm.second,
		"timezone": tz * sg,
	}


static func sum(value: int) -> Dictionary:
	var date := OS.get_date()
	var months := _LEAP_MONTHS if is_leap_year(date.year) else _MONTHS

	var day := (date.day + value) as int
	var month := date.month as int
	var year := date.year as int

	if day > months[month - 1]:
		while true:
			if month + 1 > _MAX_MONTH:
				year += 1

			day -= months[month - 1]
			month = wrapi(month + 1, _MIN_MONTH, _MAX_MONTH + 1)

			if day <= months[month - 1]:
				break

	var tm := OS.get_datetime()
	var tz := OS.get_time_zone_info().name as int \
			if OS.get_time_zone_info().name as int > 0 \
			else OS.get_time_zone_info().name as int * -1
	var sg := 1 if OS.get_time_zone_info().name as int > 0 else -1
	return {
		"year": year,
		"month": month,
		'day': day,
		"hour": tm.hour,
		"minute": tm.minute,
		"second":  tm.second,
		"timezone": tz * sg,
	}


static func to_dict(timestamp: String) -> Dictionary:
	var vec := timestamp.split("T")
	var arr := vec[1].split("-") if vec[1].find("+") == -1 else vec[1].split("+")
	var dt := vec[0].split("-")
	var tm := arr[0].split(":")
	var tz := int(arr[1].split(":")[0]) * -1 \
			if arr[1].find("+") == -1 else int(arr[1].split(":")[0]) * -1
	var sg := 1 if vec[1].find("+") == -1 else -1
	return {
		"year": dt[0] as int, 
		"month": dt[1] as int, 
		'day': dt[2] as int, 
		"hour": tm[0] as int,
		"minute": tm[1] as int,
		"second": tm[2] as int,
		"timezone": tz * sg,
	}


static func to_str(timestamp: Dictionary) -> String:
	var tz: int = timestamp["timezone"] if timestamp["timezone"] > 0 else timestamp["timezone"] * -1
	var sn := "+" if timestamp["timezone"] > 0 else "-"
	return "%d-%02d-%02dT%02d:%02d:%02d%s%02d:00"%[
		timestamp["year"],
		timestamp["month"],
		timestamp["day"],
		timestamp["hour"],
		timestamp["minute"],
		timestamp["second"],
		sn,
		tz,
	]


static func total_seconds(timestamp: Dictionary) -> int:
	var seconds := timestamp["second"] as int
	seconds += int(timestamp["minute"]) * 60
	seconds += int(timestamp["hour"]) * 3600
	seconds += int(timestamp["day"]) * 86400

	var months := _LEAP_MONTHS if is_leap_year(int(timestamp["year"])) else _MONTHS
	for i in int(timestamp["month"]) - 1:
		seconds += months[i] * 86400

	return seconds


static func is_leap_year(year: int) -> bool:
	return year % 400 == 0 if year % 4 != 0 else year % 100 != 0


static func is_after(current: Dictionary, future: Dictionary) -> bool:
	if future["timezone"] != future["timezone"]:
		return false

	if future["year"] < current["year"]:
		return false

	if future["month"] < current["month"] and future["year"] == current["year"]:
		return false

	if future["day"] < current["day"] and future["month"] == current["month"]:
		return false

	if future["hour"] < current["hour"]:
		return false

	if future["minute"] < current["minute"] and future["hour"] == current["hour"]:
		return false

	if future["second"] < current["second"] and future["minute"] == current["minute"]:
		return false

	return true


static func is_before(current: Dictionary, future: Dictionary) -> bool:
	if current["timezone"] != future["timezone"]:
		return false

	if current["year"] < future["year"]:
		return false

	if current["month"] < future["month"] and current["year"] == future["year"]:
		return false

	if current["day"] < future["day"] and current["month"] == future["month"]:
		return false

	if current["hour"] < future["hour"]:
		return false

	if current["minute"] < future["minute"] and current["hour"] == future["hour"]:
		return false

	if current["second"] < future["second"] and current["minute"] == future["minute"]:
		return false

	return true


static func interval(current: Dictionary, future: Dictionary) -> Dictionary:
	var years := 0
	var days := 0
	var hours := 0
	var minutes := 0
	var seconds := 0

	if is_after(current, future):
		var total_seconds_org := total_seconds(current)
		var total_seconds_dst := total_seconds(future)
		# warning-ignore:narrowing_conversion
		var total_seconds: int = max(total_seconds_org, total_seconds_dst) - \
				min(total_seconds_org, total_seconds_dst)

		# warning-ignore:narrowing_conversion
		years = max(current["year"] as float, future["year"] as float) - \
				min(current["year"] as float, future["year"] as float)
		# warning-ignore:integer_division
		days = total_seconds / 86400
		# warning-ignore:integer_division
		hours = (total_seconds % 86400) / 3600
		# warning-ignore:integer_division
		minutes = ((total_seconds % 86400) % 3600) / 60
		# warning-ignore:integer_division
		seconds = ((total_seconds % 86400) % 3600) % 60

	return {
		"years": years,
		'days': days,
		"hours": hours,
		"minutes": minutes,
		"seconds": seconds,
	}
