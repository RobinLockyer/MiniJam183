local Main = {
	extends = Control,
}

function Main:_ready()
	print("Main menu loaded")
end

function Main:_on_play_button_pressed()
	self:get_tree():change_scene_to_file("res://scenes/LevelMap.tscn")
end

function Main:_on_settings_button_pressed()
	self:get_tree():change_scene_to_file("res://scenes/Settings.tscn")
end

return Main
