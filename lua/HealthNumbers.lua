Hooks:PostHook(HUDTeammate, "init", "init_healthnumber", function(self, ...)
    local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local placement = healthnumber:GetOption("number_placement") < 2 and "center" or healthnumber:GetOption("number_placement") > 2 and "right" or "left"
    local HealthNum = radial_health_panel:text({
		name = "HealthNum",
		visible = true,
		text = "",
		-- color = Color.black:with_alpha(1),
		blend_mode = "normal",
		layer = 3,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		vertical = "top",
		align = placement,
		font_size = main_player and 22 or 18,
		font = "fonts/font_large_mf"
    })
    local Armorsize = radial_health_panel:text({
		name = "ArmorNum",
		visible = true,
		text = "",
		-- color = Color.black:with_alpha(1),
		blend_mode = "normal",
		layer = 3,
		w = radial_health_panel:w(),
		h = radial_health_panel:h(),
		vertical = "bottom",
		align = placement,
		font_size = main_player and 22 or 18,
		font = "fonts/font_large_mf"
    })
end)

Hooks:PostHook(HUDTeammate, "set_health", "set_health_healthnumber", function(self, data, ...)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local HealthNum = radial_health_panel:child("HealthNum")
	local set_health_alpha = healthnumber:GetOption("health_alpha")
	local radial_health = radial_health_panel:child("radial_health")
	local radial_bg = radial_health_panel:child("radial_bg")
	
	radial_health:set_alpha(set_health_alpha)
	radial_bg:set_alpha(set_health_alpha)

	HealthNum:animate(callback(self, self, "_animate_hp"))
	local Value = math.clamp(data.current / data.total, 0, 1)
	local real_value = math.round((data.total * 10) * Value)
	HealthNum:set_text(real_value)
	if real_value > 35 then
      HealthNum:set_color(healthnumber:GetColor("health_color"), Color.black:with_alpha(0.5))
	elseif real_value < 35 then
	  HealthNum:set_color(healthnumber:GetColor("low_color"):with_alpha(0.5))
	end
end)

Hooks:PostHook(HUDTeammate, "set_armor", "set_armor_healthnumber", function(self, data, ...)
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local ArmorNum = radial_health_panel:child("ArmorNum")
	local set_armor_alpha = healthnumber:GetOption("armor_alpha")
	local radial_shield = radial_health_panel:child("radial_shield")
	local radial_bg = radial_health_panel:child("radial_bg")

	radial_shield:set_alpha(set_armor_alpha)
	radial_bg:set_alpha(set_armor_alpha)

	ArmorNum:animate(callback(self, self, "_animate_ap"))
	local Value = math.clamp(data.current / data.total, 0, 1)
	local real_value = math.round((data.total * 10) * Value)
	ArmorNum:set_text(real_value)
	if real_value > 35 then
      ArmorNum:set_color(healthnumber:GetColor("armor_color"), Color.black:with_alpha(0.5))
	elseif real_value < 35 then
	  ArmorNum:set_color(healthnumber:GetColor("low_color"):with_alpha(0.5))
	end
end)

function HUDTeammate:_animate_hp()
    local t = 0
    local Healthsize = healthnumber:GetOption("number_scale")
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local HealthNum = radial_health_panel:child("HealthNum")
	while t < 0.5 do
		t = t + coroutine.yield()
		local n = 1 - math.sin(t * 180)
		HealthNum:set_font_size(math.lerp(Healthsize + 1, Healthsize + 1, n))
	end
	HealthNum:set_font_size(Healthsize)
end

function HUDTeammate:_animate_ap()
    local t = 0
    local Armorsize = healthnumber:GetOption("number_scale")
	local teammate_panel = self._panel:child("player")
	local radial_health_panel = teammate_panel:child("radial_health_panel")
	local ArmorNum = radial_health_panel:child("ArmorNum")
	while t < 0.5 do
		t = t + coroutine.yield()
		local n = 1 - math.sin(t * 180)
		ArmorNum:set_font_size(math.lerp(Armorsize + 1, Armorsize + 1, n))
	end
	ArmorNum:set_font_size(Armorsize)
end