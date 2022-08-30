extends Node


static func to_monetary(value: float) -> String:
	var txt := ("%0.2f"%value).replace(".", "")
	var comma := ","
	var dot := "."

	match TranslationServer.get_locale():
		"pt_BR":
			comma = ","
			dot = "."
		"es_CR":
			comma = ","
			dot = "."
		"en_US":
			comma = "."
			dot = ","
		_:
			comma = ","
			dot = "."
			continue

	if txt.empty():
		return "0%s00"%comma

	if txt.length() == 1:
		return "0%s0%s"%[comma, txt]

	if txt.length() == 2:
		return "0%s%s"%[comma, txt]

	var out := ""
	var idx := int(txt.length() - 2)
	for i in txt.length() - 2:
		if idx % 3 == 0:
			out += dot
		out += txt[i]
		idx -=1

	if out[0] == dot:
		out.erase(0, 1)

	return out + comma + ("%0.2f"%value).split(".")[1]


static func to_datetime_pretty(timestamp: Dictionary) -> String:
	match TranslationServer.get_locale():
		"pt_BR":
			return "%02d/%02d/%02d %02d:%02d:%02d"%[ timestamp["day"], timestamp["month"], timestamp["year"], timestamp["hour"], timestamp["minute"], timestamp["second"] ]
		"es_CR":
			return "%02d/%02d/%02d %02d:%02d:%02d"%[ timestamp["day"], timestamp["month"], timestamp["year"], timestamp["hour"], timestamp["minute"], timestamp["second"] ]
		"en_US":
			return "%02d/%02d/%02d %02d:%02d:%02d"%[ timestamp["month"], timestamp["day"], timestamp["year"], timestamp["hour"], timestamp["minute"], timestamp["second"] ]
		_:
			continue
	return "%02d/%02d/%02d %02d:%02d:%02d"%[ timestamp["day"], timestamp["month"], timestamp["year"], timestamp["hour"], timestamp["minute"], timestamp["second"] ]
