@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var text := ""
	var credits_file := FileAccess.open("res://credits.csv", FileAccess.READ)
	while not credits_file.eof_reached():
		var line := credits_file.get_csv_line()
		text += "[center][url=%s]%s created by %s[/url][/center]\n" % Array(line)
	print(text)
