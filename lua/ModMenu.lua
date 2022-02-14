Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_healthnumber", function( loc )
	local localization = healthnumber._path .. "loc/"
	local GetFiles = _G.file.GetFiles
	local Idstring = _G.Idstring
	local activelanguagekey = SystemInfo:language():key()
	for __, filename in ipairs(GetFiles(localization)) do
		if Idstring(filename:match("^(.*).json$") or ""):key() == activelanguagekey then
			loc:load_localization_file(localization .. filename)
		    break
		end
	end
	loc:load_localization_file(localization .. "english.json", false)
end)

Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenus_healthnumber", function(menu_manager, nodes)
    MenuCallbackHandler.OpenhealthnumberModOptions = function(self, item)
        healthnumber.Menu = healthnumber.Menu or healthnumberMenu:new()
		healthnumber.Menu:Open()

        Hooks:PostHook(MenuManager, "update", "update_menu_healthnumber", function(self, t, dt)
            if healthnumber.Menu and healthnumber.Menu.update and healthnumber.Menu._enabled then
                healthnumber.Menu:update(t, dt)
            end
        end)
	end

	local node = nodes["blt_options"]

	local item_params = {
		name = "healthnumber_OpenMenu",
		text_id = "healthnumber_title",
		help_id = "healthnumber_desc",
		callback = "OpenhealthnumberModOptions",
		localize = true,
	}
	local item = node:create_item({type = "CoreMenuItem.Item"}, item_params)
    node:add_item(item)
end)