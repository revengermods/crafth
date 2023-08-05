script_name('CraftHelper')
script_author('revenger mods')
script_version('1.3')

require "lib.moonloader" -- подключение библиотеки

local dlstatus = require('moonloader').download_status
local inicfg = require("inicfg")
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

-- config:

local cfgName = "\\CraftHelper.ini"

local cfg = inicfg.load({
    main = {
		theme = 0
    },
}, "CraftHelper")


if not doesFileExist('moonloader/config/CraftHelper.ini') then inicfg.save(cfg, cfgName) end

local menu = 14
local color = '{00b052}'
local result = imgui.ImInt(cfg.main.theme)


local main_window_state = imgui.ImBool(false)


update_state = false

local script_vers = 5
local script_vers_text = "1.13"

local update_url = "https://raw.githubusercontent.com/revengermods/crafth/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "https://raw.githubusercontent.com/revengermods/crafth/main/crafthelper.lua" -- тут свою ссылку
local script_path = thisScript().path



function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	if cfg.main.theme == 0 then themeSettings(0) color = '{ff4747}'
	elseif cfg.main.theme == 1 then themeSettings(1) color = '{9370DB}'
	elseif cfg.main.theme == 2 then themeSettings(2) color = '{00a550}'
	elseif cfg.main.theme == 3 then themeSettings(3) color = '{CD853F}'
	elseif cfg.main.theme == 4 then themeSettings(4) color = '{808080}'				
	else cfg.main.theme = 0 themeSettings(0) color = '{ff4747}' end

	sampRegisterChatCommand("craft", cmd_imgui)
	sampAddChatMessage(''..color..'[CraftHelper]{ffffff} успешно загружен! Активаия:'..color..' /craft ', -1)
	--sampAddChatMessage('Craft Helper{ffffff} успешно загружен! Активаия:{9370DB} /craft', -1)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage(''..color..'[CraftHelper] Есть обновление! Версия: ' .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)	


	imgui.Process = false

	-------------------------------------------------------------------

	while true do
	  wait(0)

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage(''..color..'[CraftHelper] Скрипт успешно обновлен! | Связь: '..color..'[vk.com/qweeqwz]', -1)
                    thisScript():reload()
                end
            end)
            break
        end	  

	  if main_window_state.v == false then
	  	imgui.Process = false
	  end	
	end
end 

function themeSettings(theme)
 imgui.SwitchContext()
 local style = imgui.GetStyle()
 local ImVec2 = imgui.ImVec2
 local style = imgui.GetStyle()
 local colors = style.Colors
 local clr = imgui.Col
 local ImVec4 = imgui.ImVec4
 style.WindowPadding = imgui.ImVec2(8, 8)
 style.WindowRounding = 6
 style.ChildWindowRounding = 5
 style.FramePadding = imgui.ImVec2(5, 3)
 style.FrameRounding = 3.0
 style.ItemSpacing = imgui.ImVec2(5, 4)
 style.ItemInnerSpacing = imgui.ImVec2(4, 4)
 style.IndentSpacing = 21
 style.ScrollbarSize = 10.0
 style.ScrollbarRounding = 13
 style.GrabMinSize = 8
 style.GrabRounding = 1
 style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
 style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
 if theme == 0 or nil then 
 	colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
	colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
	colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
	colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
	colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
	colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
	colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
	colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
	colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
	colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
	colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
	colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
	colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
	colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
	colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
	colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
	colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
	colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
	colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
	colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
	colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
	colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
	colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
	colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
	colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
	colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
	colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
	colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
	colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
	colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
	colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
	colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
  elseif theme == 1 then
    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(0.57, 0.38, 0.99, 1.00);
    colors[clr.SliderGrab]             = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(0.50, 0.29, 0.98, 1.00);
    colors[clr.Button]                 = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(0.58, 0.40, 0.99, 1.00);
    colors[clr.ButtonActive]           = ImVec4(0.45, 0.22, 0.98, 1.00);
    colors[clr.Header]                 = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(0.56, 0.38, 0.98, 1.00);
    colors[clr.HeaderActive]           = ImVec4(0.45, 0.21, 0.99, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(0.50, 0.28, 1.00, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(0.57, 0.38, 1.00, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(0.47, 0.24, 1.00, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(0.57, 0.38, 1.00, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(0.45, 0.22, 0.99, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(0.42, 0.17, 0.99, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(0.53, 0.33, 0.99, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
   elseif theme == 2 then
		colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
	    colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00)
	    colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
	    colors[clr.ChildWindowBg]          = ImVec4(0.10, 0.10, 0.10, 1.00)
	    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
	    colors[clr.Border]                 = ImVec4(0.70, 0.70, 0.70, 0.40)
	    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	    colors[clr.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 1.00)
	    colors[clr.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
	    colors[clr.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
	    colors[clr.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 0.80)
	    colors[clr.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
	    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
	    colors[clr.MenuBarBg]              = ImVec4(0.00, 0.80, 0.38, 1.00)
	    colors[clr.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
	    colors[clr.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
	    colors[clr.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
	    colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
	    colors[clr.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
	    colors[clr.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
	    colors[clr.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
	    colors[clr.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
	    colors[clr.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
	    colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
	    colors[clr.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
	    colors[clr.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
	    colors[clr.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
	    colors[clr.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
	    colors[clr.CloseButton]            = ImVec4(0.00, 0.82, 0.39, 1.00)
	    colors[clr.CloseButtonHovered]     = ImVec4(0.00, 0.88, 0.42, 1.00)
	    colors[clr.CloseButtonActive]      = ImVec4(0.00, 1.00, 0.48, 1.00)
	    colors[clr.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
	    colors[clr.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
	    colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
	    colors[clr.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
	    colors[clr.ModalWindowDarkening]   = ImVec4(0.17, 0.17, 0.17, 0.48)
	elseif theme == 3 then -- orange
		colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
		colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
		colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
		colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
		colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
		colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
		colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
		colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
		colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
		colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
		colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
		colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
		colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.12, 0.12, 0.12, 1.00);
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.36, 0.36, 0.36, 1.00);
		colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
		colors[clr.CheckMark]              = ImVec4(0.76, 0.45, 0.00, 1.00);
		colors[clr.SliderGrab]             = ImVec4(0.76, 0.45, 0.00, 1.00);
		colors[clr.SliderGrabActive]       = ImVec4(0.71, 0.38, 0.00, 1.00);
		colors[clr.Button]                 = ImVec4(0.76, 0.45, 0.00, 1.00);
	  	colors[clr.ButtonHovered]          = ImVec4(0.94, 0.45, 0.00, 1.00);
	  	colors[clr.ButtonActive]           = ImVec4(0.71, 0.38, 0.00, 1.00);
		colors[clr.Header]                 = ImVec4(0.76, 0.45, 0.00, 1.00);
		colors[clr.HeaderHovered]          = ImVec4(0.94, 0.45, 0.00, 1.00);
		colors[clr.HeaderActive]           = ImVec4(0.71, 0.38, 0.00, 1.00);
		colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
		colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
		colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
		colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
		colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
		colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
		colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
		colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
		colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
	elseif theme == 4 then -- серая
		colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
		colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
		colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
		colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
		colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
		colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
		colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
		colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
		colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
		colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
		colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
		colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
		colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.12, 0.12, 0.12, 1.00);
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.36, 0.36, 0.36, 1.00);
		colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
		colors[clr.CheckMark]              = ImVec4(0.37, 0.37, 0.37, 1.00);
		colors[clr.SliderGrab]             = ImVec4(0.37, 0.37, 0.37, 1.00);
		colors[clr.SliderGrabActive]       = ImVec4(0.33, 0.33, 0.33, 1.00);
		colors[clr.Button]                 = ImVec4(0.37, 0.37, 0.37, 1.00);
		colors[clr.ButtonHovered]          = ImVec4(0.46, 0.46, 0.46, 1.00);
		colors[clr.ButtonActive]           = ImVec4(0.33, 0.33, 0.33, 1.00);
		colors[clr.Header]                 = ImVec4(0.37, 0.37, 0.37, 1.00);
		colors[clr.HeaderHovered]          = ImVec4(0.46, 0.46, 0.46, 1.00);
		colors[clr.HeaderActive]           = ImVec4(0.33, 0.33, 0.33, 1.00);
		colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
		colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
		colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
		colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
		colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
		colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
		colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
		colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
		colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);		 	
 end
end


function cmd_imgui()
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

function imgui.OnDrawFrame()
	local colours = {u8'Красная', u8'Фиолетовая', u8'Зелёная', u8'Оранжевая', u8'Серая'}	
	if main_window_state then
	imgui.SetNextWindowSize(imgui.ImVec2(400, 400), imgui.Cond.FirstUseEver)
	if not window_pos then
		ScreenX, ScreenY = getScreenResolution()ScreenX, ScreenY = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
	end		
	imgui.Begin(u8"CraftHelper | Версия: 1.3", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
	imgui.CenterText(u8" ")
	imgui.SameLine()
	imgui.SetCursorPos(imgui.ImVec2(4, 25))
	imgui.BeginChild('left', imgui.ImVec2(123, -50), true)
	if imgui.Selectable(u8"Настройки", menu == 14) then menu = 14 
	elseif imgui.Selectable(u8"Аксессуары", menu == 1) then menu = 1 
	elseif imgui.Selectable(u8"Одежда", menu == 2) then menu = 2 
	elseif imgui.Selectable(u8"Химия", menu == 9) then menu = 9 
	elseif imgui.Selectable(u8"Обработка", menu == 7) then menu = 7 
	elseif imgui.Selectable(u8"Теплица", menu == 3) then menu = 3 
	elseif imgui.Selectable(u8"Тюнинг", menu == 10) then menu = 10 
	elseif imgui.Selectable(u8"Чертежи", menu == 11) then menu = 11 
	elseif imgui.Selectable(u8"Оружие", menu == 12) then menu = 12  
	elseif imgui.Selectable(u8"Телефон", menu == 13) then menu = 13 end
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild('right', imgui.ImVec2(0, -50), true) 	
	if menu == 1 then
		-- 1 
	imgui.Button(u8'Гитара Акустическая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 5шт\nДрова - 10шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end   
	imgui.Button(u8'Удочка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 12шт\nДревесина высшего качества - 42шт\nАлюминий - 3шт\nЛён - 40шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Медаль Ведьмака')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nАлюминий - 30шт\nБронза - 40шт\nКамень - 60шт\nХлопок - 100шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Рюкзак Stranger Things')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Кепка Stranger Things')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 30шт\nХлопок - 30шт\nКусок редкой ткани - 6шт\nАлюминий - 4шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Голова Каширо Из Унесенных Призраками')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 4шт\nАлюминий - 4шт\nБронза - 6шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end
		imgui.Button(u8'Безликий')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 90шт\nХлопок - 70шт\nКусок редкой ткани - 10шт\nАлюминий - 8шт\nБронза - 6шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Тетрадь смерти')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 10шт\nХлопок - 10шт\nКусок редкой ткани - 4шт\nАлюминий - 2шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'Маска Чучела Из Ходячий Замка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 90шт\nХлопок - 60шт\nКусок редкой ткани - 10шт\nАлюминий - 4шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end
		imgui.Button(u8'Маска Конь Бюджек')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 10шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Бронежилет Бюджек')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nАлюминий - 30шт\nБронза - 40шт\nКамень - 60шт\nХлопок - 100шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Стэн')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 10шт\nАлюминий - 6шт\nБронза - 6шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'Кенни')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 10шт\nАлюминий - 6шт\nБронза - 6шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'Кайл')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 10шт\nАлюминий - 6шт\nБронза - 6шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'Шлем Человека - Муровья')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Громсекира Тора')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Барсетка Balenciaga')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end
		imgui.Button(u8'Барсетка Gucci 1')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Барсетка Gucci 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Кепка Stone Island')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Кепка Gucci 1')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Очки в BIT')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'Очки Balenciaga')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 4шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'Маска Удильщик')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 60шт\nХлопок - 90шт\nКусок редкой ткани - 10шт\nАлюминий - 14шт\nБронза - 10шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Шляпа Со Свечкой')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 50шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 8шт\nБронза - 6шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'Крылья Давинчи')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 100шт\nХлопок - 60шт\nКусок редкой ткани - 14шт\nАлюминий - 10шт\nБронза - 10шт\nСтоимость - 5000р')
		    imgui.EndTooltip()
		end																																															
	imgui.Button(u8'Маска от коронавируса')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 100шт\nХлопок - 100шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8'Молоток')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 25шт\nБронза - 9шт\nКамень - 50шт\nХлопок - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Канистра на бедро')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 20шт\nБронза - 3шт\nКанистра - 5шт\nЛён - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'Фотоаппарат')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 18шт\nБронза - 4шт\nФотоаппарат - 80шт\nХлопок - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'Кирка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 13шт\nБронза - 6шт\nЛён - 10шт\nХлопок - 10шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Грабли')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 6шт\nАлюминий - 13шт\nБронза - 6шт\nЛён - 10шт\nХлопок - 10шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дилдо на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'Вибратор на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'Жезл на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Мед. сумка на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nНабор с инструментами - 2шт\nЛён - 100шт\nХлопок - 100шт\nДрова - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Огнетушитель на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nКамень - 30шт\nМатериалы - 10шт\nСеребро - 1шт\nЛён - 3шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Клюшка на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nДрова - 6шт\nМатериалы - 24шт\nЛён - 5шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Бита на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень- 30шт\nДрова - 20шт\nМатериалы - 10шт\nХлопок - 5шт\nЛён - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Лопата на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 26шт\nДрова - 6шт\nМатериалы - 2шт\nЛён - 5шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Кий на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 8шт\nДрова - 6шт\nМеталл - 4шт\nЛён - 5шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Тесак на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nМатериалы - 11шт\nКамень - 12шт\nБронза - 3шт\nХлопок - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Топор на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 14шт\nМатериалы - 15шт\nКамень - 6шт\nСеребро - 3шт\nЛён - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Велосипед на спину')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 50шт\nМатериалы - 35шт\nАлюминий - 15шт\nНабор с инструментами - 5шт\nБронза - 4шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end	
-------------------------------------------------------------------------------------------------
	imgui.Button(u8'Гитара (Красная)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 5шт\nЛён - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Гитара (Белая)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 5шт\nЛён - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'Гитара (Черная)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 5шт\nЛён - 5шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Бумбокс')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 2шт\nМатериалы - 25шт\nХлопок - 5шт\nЛён - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Гитара Темно-Зеленая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 10шт\nЛён - 2шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Гитара Зеленая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 10шт\nЛён - 2шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Гитара Красно-Белая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 10шт\nЛён - 2шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Гитара Красная')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 10шт\nЛён - 2шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Гитара Синяя')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nДрова - 100шт\nБронза - 10шт\nХлопок - 10шт\nЛён - 2шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Кейс GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 60шт\nЛён - 60шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Кейс LOUIS VUITTON')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 60шт\nЛён - 60шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Кейс LOUIS VUITTON Черная')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 60шт\nЛён - 60шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Кейс ADIDAS')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 60шт\nЛён - 60шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Кейс NIKE')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 60шт\nЛён - 60шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Мотошлем (Красный)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 60шт\nАлюминий - 2\nЛён - 60шт\nКанистра - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Мотошлем (Белый)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 60шт\nАлюминий - 2\nЛён - 60шт\nКанистра - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Мотошлем (Фиолетовый)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 60шт\nАлюминий - 2\nЛён - 60шт\nКанистра - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		-------	
	imgui.Button(u8'Нашивка Полиция')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Росгвардия')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Навальный')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'Нашивка Конопля')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Army')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Герб России')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Герб СССР')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка BMW')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Пистолет')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Фсб')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Нашивка Флаг США')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Нашивка Король и Шут')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 200шт\nЛён - 200шт\nШкура медведя - 1шт\nШкура кабана - 1шт\nШкура оленя - 1шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end																																																															
	imgui.Button(u8'Респиратор')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 5шт\nХлопок - 60шт\nАлюминий - 1шт\nЛён - 50шт\nШкура оленя - 1шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
---
	imgui.Button(u8'Спортивный Шлем (Красный)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 60шт\nАлюминий - 2шт\nЛён - 40шт\nКанистра - 2шт\nСтоимость - 10500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Спортивный Шлем (Огненный)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 60шт\nАлюминий - 2шт\nЛён - 40шт\nКанистра - 2шт\nСтоимость - 10500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Спортивный Шлем (Серый)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 60шт\nАлюминий - 2шт\nЛён - 40шт\nКанистра - 2шт\nСтоимость - 10500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Спортивный Шлем (Белый)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 60шт\nАлюминий - 2шт\nЛён - 40шт\nКанистра - 2шт\nСтоимость - 10500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Доска Для Серфинга (Белая)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 50шт\nАлюминий - 2шт\nБронза - 1шт\nДревесина высшего качества - 1шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Доска Для Серфинга (Красная)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 50шт\nАлюминий - 2шт\nБронза - 1шт\nДревесина высшего качества - 1шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Доска Для Серфинга (Зеленая)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 50шт\nАлюминий - 2шт\nБронза - 1шт\nДревесина высшего качества - 1шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Доска Для Серфинга (Желтая)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 50шт\nАлюминий - 2шт\nБронза - 1шт\nДревесина высшего качества - 1шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Доска Для Серфинга (Синяя)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 50шт\nАлюминий - 2шт\nБронза - 1шт\nДревесина высшего качества - 1шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Сумка Бизнесмена (Серая)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Сумка Бизнесмена (Желтая)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Сумка Бизнесмена (Коричневая)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Сумка Бизнесмена (Черная)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Сумка Бизнесмена (Разноцветная)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Крылья Ангелов (Зеленые)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 55шт\nМатериалы - 40шт\nАлюминий - 20шт\nНабор с инструментами - 1шт\nБронза - 10шт\nСтоимость - 16500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Крылья Ангелов (Голубые)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 55шт\nМатериалы - 40шт\nАлюминий - 20шт\nНабор с инструментами - 1шт\nБронза - 10шт\nСтоимость - 16500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Крылья Ангелов (Синие)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 55шт\nМатериалы - 40шт\nАлюминий - 20шт\nНабор с инструментами - 1шт\nБронза - 10шт\nСтоимость - 16500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Крылья Ангелов (Фиолетовые)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 55шт\nМатериалы - 40шт\nАлюминий - 20шт\nНабор с инструментами - 1шт\nБронза - 10шт\nСтоимость - 16500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Крылья Ангелов (Черные)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 55шт\nМатериалы - 40шт\nАлюминий - 20шт\nНабор с инструментами - 1шт\nБронза - 10шт\nСтоимость - 16500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Парик Розовый')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Парик Русый')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Парик Элвиса')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Парик Дворянина')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Парик Япошки')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Парик Деда')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Кепка - Козырек')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Парик Клоуна')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 80шт\nДрова - 4шт\nАлюминий - 1шт\nМеталл - 10шт\nХлопок - 2шт\nСтоимость - 12000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Барсетка SUPREME')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Барсетка LOUIS VUITTON')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'Барсетка CHANEL')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Барсетка GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'Барсетка NIKE')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nХлопок - 70шт\nЛён - 70шт\nБронза - 2шт\nДрова - 6шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска Медведя')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска Убийцы')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Маска Мото - Головореза 1')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска Мото - Головореза 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Маска Мото - Головореза 3')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска Мото - Головореза 4')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска Мото - Головореза 5')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска Мото - Головореза 6')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Маска Коня')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Маска Клоуна')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nЛён - 70шт\nХлопок - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end																																																																																																
	imgui.Button(u8'Дамская сумочка белая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамская сумочка черная')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамская сумочка розовая')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамский клач красный')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дамский клач синий')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дамская сумочка GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Леопардовый клач')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Дамская сумочка МК')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'Дамская сумочка МК 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Сумка - уточка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'Синяя сумка')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Зеленая сумка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Леденец")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ватрушка Сине - Белая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Ватрушка Сине - Зеленая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ватрушка Сине - Серая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Ватрушка Разноцветная")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ватрушка Ночная")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ватрушка Сине - Красная")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Новогодняя Шапка Санты")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодние Рожки Оленя")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Коричневая Шляпка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Голубая Шляпка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Коровьи Ушки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Ушки С Бантиками")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шляпка С Бантиком")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Новогодняя Шапка Зеленая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Новогодняя Шапка Красная")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Шапка Фиолетовая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Шапка Салатовая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Шапка Полосатая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Шапка Белая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Новогодняя Шапка Сиреневая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Шапка - Елочка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Колпак Красная")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Колпак Зеленый")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Новогодняя Колпак Темный")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Новогодняя Колпак Фиолетовый")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Новогодняя Колпак - Тортик")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Рюкзак Лыжника")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Снежный Рюкзак")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Желтый Шарф")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Украинский Шарф")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Шарф Москва")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шарф Россия")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шарф Зенит")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шарф ЦСКА")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шарф Atletic")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шарф Зенит Синий")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Рюкзак С Елкой")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Рюкзак С Танцором")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Рюкзак С Графической Елкой")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Маска Белая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Маска Желтая")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Маска Пса")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Маска Снеговика")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Маска Оленя")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Новогодний Посох")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 12шт\nАлюминий - 6шт\nХлопок - 70шт\nЛён - 70шт\nМатериалы - 250шт\nСтоимость - 13500р')
		    imgui.EndTooltip()
		end																																																																																																				
	imgui.Button(u8"Шапка BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 2шт\nАлюминий - 10шт\nМеталл - 15шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Маска BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 2шт\nАлюминий - 10шт\nМеталл - 15шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Бронежилет BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 2шт\nАлюминий - 10шт\nМеталл - 15шт\nЛён - 50шт\nХлопок - 50шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Очки киберпанк")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 25шт\nХлопок - 25шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	elseif menu == 2 then
	-- Амиран (id:394)
	imgui.Button(u8"Гордон (id:540)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Иосиф Сталин (id:541)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Доктор Браун (id:594)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
--
	imgui.Button(u8"Слава Дворецков (id:595)")
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		imgui.EndTooltip()
	end	
--
	imgui.Button(u8"Дит (id:567)")
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		imgui.EndTooltip()
	end	
	imgui.Button(u8"Эрнесто (id:568)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Норо (id:570)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Квенси (id:571)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Сигерс (id:572)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Устанько (id:573)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		--
		imgui.Button(u8"Браток (id:575)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Ромеро (id:579)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Джон Сноу (id:580)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Миа (id:581)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Артур Морган (id:582)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Джоел (id:584)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Эмгыр (id:585)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Леви (id:591)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Джонни (id:538)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Шон Майклэ (id:554)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
		--
		imgui.Button(u8"Халк Хоган (id:555)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Трипл Эйч (id:556)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Крис Джерико (id:557)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 100шт\nЛён - 100шт\nКусок редкой ткани - 10шт\nКраситель - 10шт\nШкура медведя - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end																														
	imgui.Button(u8"Амиран (id:394)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Литвин (id:395)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Эдвард Билл (id:396)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Хабиб (id:398)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Диана Шурыгина (id:399)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end		
------------------------------------------------------------------------------------------------------
	imgui.Button(u8"Ева Элфи (id:400)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Оскимирон (id:402)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Павленко (id:403)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Бузова (id:404)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Лукашенко (id:405)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end			
---------------------------------------------------------------------------------------------------
	imgui.Button(u8"Ресторатор (id:406)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Техник (id:407)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Баста (id:408)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Дзюба (id:409)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 1шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Иван Ургант (id:410)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end	
		-------------
	imgui.Button(u8"Noize MC (id:412)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Саша Грей (id:413)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 3шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ричи Галлиани (id:416)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 90шт\nЛён - 90шт\nКусок редкой ткани - 2шт\nСтоимость - 1000р')
		    imgui.EndTooltip()
		end																																															
	elseif menu == 9 then
	imgui.Button(u8"Аптечка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Наркотики - 1шт\nСтоимость - 150р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Адреналин")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Наркотики - 2шт\nНаркотический гриб - 2шт\nСтоимость - 900р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Смазка для разгона")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 14шт\nМатериалы - 10шт\nСеребро - 1шт\nКамень - 21шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"Охлаждающая жидкасть")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 20шт\nХлопок - 20шт\nДистиллированная вода - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Кусок редкой ткани")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 1шт\nХлопок - 1шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end				
	elseif menu == 12 then
	imgui.Button(u8"Glock Pink")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"Makarov Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"TT Brown")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Red")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Colt Python Eagle")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"AK574 Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Скорпион Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nАлюминий - 15шт\nБронза - 18шт\nХлопок - 90шт\nЛён - 90шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"M249 Deserted")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 150шт\nАлюминий - 75шт\nБронза - 60шт\nХлопок - 180шт\nЛён - 180шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"M249 Vietnam")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 150шт\nАлюминий - 75шт\nБронза - 60шт\nХлопок - 180шт\nЛён - 180шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	elseif menu == 3 then
	imgui.Button(u8"Стол для смешивания")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 200шт\nМеталл - 40шт\nАлюминий - 10шт\nХлопок - 10шт\nПлоскогубцы - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Бочка для воды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 100шт\nМеталл - 10шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Лоток для растений")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 50шт\nПроволока - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Лампа освещения")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Серебро - 3шт\nПроволока - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Помпа для перекачки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Алюминий - 5шт\nБронза - 5шт\nМеталл - 10шт\nПроволока - 1шт\nВеревка - 1шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Опрыскиватель")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 20шт\nЗамок - 1шт\nНапильник - 1шт\nВеревка - 1шт\nМеталл - 5шт\nСтоимость - 300000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Ведро для воды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nВеревка - 3шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Канистра для воды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 2шт\nХлопок - 50шт\nАлюминий - 2шт\nСтоимость - 15000р')
		    imgui.EndTooltip()
		end	
		imgui.Separator()
		imgui.CenterText(u8"Стол для смешивания")
		imgui.Separator()	
		---
		imgui.Button(u8"Семена Наркотического гриба")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Накротический гриб - 1шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Наркотики")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Накротический гриб - 1шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Удобрения")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Погибшие растения - 10шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Отвар От Наркозависимости")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Мак - 5шт\nАптечка - 5шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Лекарство От Психрасстройства")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Мак - 20шт\nНаркотики - 200шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Простой Фермерский Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 10шт\nНапиток - 5шт\nЦветы - 1шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	--Простой Рудный Чай
		imgui.Button(u8"Простой Рудный Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Яд - 1шт\nКола - 1шт\nСеребро - 1шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Простой Диетический Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лимонад - 1шт\nАптечка - 3шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Продвинутый Фермерский Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Простой Фермерский Чай - 2шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Продвинутый Рудный Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Простой Рудный Чай - 2шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Продвинутый Диетический Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Простой Диетический Чай - 2шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		---	
		imgui.Button(u8"Чистый Фермерский Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Продвинутый Фермерский Чай - 3шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Чистый Рудный Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Продвинутый Рудный Чай - 3шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Чистый Диетический Чай")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Продвинутый Диетический Чай - 3шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		---	
		imgui.Button(u8"Авто Ящик")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 10шт\nБронза - 5шт\nМеталл - 5шт\nСеребро - 1шт\nЛен - 15шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Мото Ящик")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 10шт\nБронза - 5шт\nМеталл - 5шт\nСеребро - 1шт\nЛен - 15шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Ящик Marvel")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 10шт\nБронза - 5шт\nМеталл - 5шт\nСеребро - 1шт\nЛен - 15шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"Ящик Джентельмены")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 10шт\nБронза - 5шт\nМеталл - 5шт\nСеребро - 1шт\nЛен - 15шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"Ящик Американских Звезд")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 10шт\nБронза - 5шт\nМеталл - 5шт\nСеребро - 1шт\nЛен - 15шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end											
		---															
	elseif menu == 13 then
	imgui.Button(u8"Vivo V25")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 5шт\nМеталл - 10шт\nАлюминий - 10шт\nСеребро - 10шт\nБронза - 10шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 13 pro Max Graphite")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 20шт\nМеталл - 25шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 13 pro Max Alpine Green")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 20шт\nМеталл - 25шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 13 pro Max Sierra Blue")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 20шт\nМеталл - 25шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 13 pro Max Gold")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 20шт\nМеталл - 25шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 13 pro Max Silver")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 20шт\nМеталл - 25шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 14 pro Max Space Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 30шт\nМеталл - 30шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 14 pro Max Deep Purple")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 30шт\nМеталл - 30шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 14 pro Max Silver")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 30шт\nМеталл - 30шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 14 pro Max Gold")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 30шт\nМеталл - 30шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Asus Rog Phone 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 30шт\nМеталл - 30шт\nАлюминий - 50шт\nСеребро - 30шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Google Pixel 7 Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 10шт\nМеталл - 15шт\nАлюминий - 20шт\nСеребро - 25шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Honor 50")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 10шт\nМеталл - 15шт\nАлюминий - 20шт\nСеребро - 25шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Huawei Mate 50 Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 10шт\nМеталл - 15шт\nАлюминий - 20шт\nСеребро - 25шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Xiaomi 12T Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 10шт\nМеталл - 15шт\nАлюминий - 20шт\nСеребро - 25шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Xiaomi 12T Ultra")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 10шт\nМеталл - 15шт\nАлюминий - 20шт\nСеребро - 25шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Motorola Edge 3D Ultra")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 5шт\nМеталл - 10шт\nАлюминий - 15шт\nСеребро - 17шт\nБронза - 8шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Nothing Phone")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 1шт\nМеталл - 2шт\nАлюминий - 3шт\nСеребро - 2шт\nБронза - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Oppo Fino X5 Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 5шт\nМеталл - 10шт\nАлюминий - 15шт\nСеребро - 17шт\nБронза - 8шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Poco F4 GT")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 5шт\nМеталл - 10шт\nАлюминий - 15шт\nСеребро - 17шт\nБронза - 8шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Samsung Galaxy S23 Ultra")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 10шт\nМеталл - 15шт\nАлюминий - 20шт\nСеребро - 25шт\nБронза - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Sony Xperia 1 Iv")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 5шт\nМеталл - 10шт\nАлюминий - 15шт\nСеребро - 17шт\nБронза - 8шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end					
	elseif menu == 11 then
	imgui.Button(u8"Чертеж Гучи")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Луи Витон")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Шанель")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Найк")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Адидас")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Суприм")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Чертеж Одежды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Музыкальных инструментов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Дисков")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Шлемов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
-----------------------------------------------------------------------
	imgui.Button(u8"Чертеж Причесок")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Барбер")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Сумок Бизнесмена")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Винилов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Бамперов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Спойлеров")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Крыльев Ангела")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Предметов Майнинга")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Масок")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Досок Для Серфинга")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Костяных масок")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Нашивок")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Чертеж Головных Уборов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Чертеж Шарфов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Чертеж Предметов Для Участка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Чертеж Новогодних Предметов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Капотов")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Чертеж Предметов Теплицы")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Кусок чертежа - 100шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	elseif menu == 10 then	
	imgui.Button(u8"Бампер (Задний) (Carbon Ring)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Бампер (Задний) (Carbon Two)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Бампер (Задний) (Cradient Two)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Бампер (Задний) (Grid)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Спойлер (Ducktaili)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Спойлер (Reaper)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Спойлер (Daytona)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Спойлер (Curse)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 4шт\nМатериалы - 400шт\nДрова - 250шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
-- Виниллы ------------------------------------------------------------	
	imgui.Button(u8"Винил - 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Винил - 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 7")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 8")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 9")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 10")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Винил - 11")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Винил - 12")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Винил - 13")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Винил - 14")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Винил - 15")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Винил - 16")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Винил - 17")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Краситель - 80шт\nБалончик с краской - 30шт\nКусок редкой ткани - 50шт\nХлопок - 25шт\nЛён - 25шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end
	-- Диски -------------------------------------------------------
	imgui.Button(u8"Диски - 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 7")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 8")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 9")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 10")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 11")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 12")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 13")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 14")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 15")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 16")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диски - 17")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Улучшенная часть корпуса - 1шт\nУлучшенная часть двигателя - 1шт\nАлюминий - 2шт\nМатериалы - 400шт\nМеталл - 15шт\nСтоимость - 21000р')
		    imgui.EndTooltip()
		end		
	-- Настройки -----
	elseif menu == 14 then
		-- баг
		imgui.Text(u8'Нашли баг?') imgui.SameLine() imgui.Link('https://vk.com/srevenreg', u8'Вам сюда!')
		-- группа вк
		imgui.Text(u8'Автор:') imgui.SameLine() imgui.Link('https://vk.com/srevenreg', u8'revenger mods.')
		-- ещё скрипты
		imgui.Text(u8'Наши скрипты:') imgui.SameLine() imgui.Link('https://vk.com/topic-217349315_49351051', u8'клик!')
		imgui.Separator()
	  	imgui.Text(u8' Выбор темы:')
		if imgui.Combo('##1', result, colours, -1) then cfg.main.theme = result.v save()
			if cfg.main.theme == 0 then themeSettings(0) color = '{ff4747}'
			elseif cfg.main.theme == 1 then themeSettings(1) color = '{9370DB}'
			elseif cfg.main.theme == 2 then themeSettings(2) color = '{00a550}'
			elseif cfg.main.theme == 3 then themeSettings(3) color = '{CD853F}'
			elseif cfg.main.theme == 4 then themeSettings(4) color = '{808080}'								
			else cfg.main.theme = 0 themeSettings(0) color = '{ff4747}' end
		end
		imgui.Separator()
	elseif menu == 7 then
		imgui.Button(u8"Сертификат Дополнения VIP")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Сертификат Дополнения VIP (30д) - 4шт\nЛен - 500шт\nХлопок - 500шт\nСеребро - 100шт\nЗолото - 100шт\nСтоимость - 150000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"Алюминий")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 3шт\nСтоимость - 150р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Материалы")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 5шт\nСтоимость - 150р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Бронзовая рулетка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Бронза - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Серебряная рулетка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Серебро - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Золотая рулетка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Золото - 5шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Отмычка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 20шт\nАлюминий - 10шт\nДревесина высшего качества - 10шт\nСтоимость - 0р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Точильный Камень")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 18шт\nХлопок - 18шт\nМеталл - 3шт\nБронза - 2шт\nСеребро - 1шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Заточка Для Удочки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Водное дерево - 1шт\nКрепкие водоросли - 1шт\nКусок качественного железа - 1шт\nБронза - 1шт\nЗолото - 1шт\nСтоимость - 75000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Эхолот Для Рыбалки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Древесина высшего качества - 30шт\nМеталл - 8шт\nСеребро - 1шт\nМатериалы - 58шт\nХлопок - 45шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Солнечные Панели")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 500шт\nАлюминий - 20шт\nМатериалы - 70шт\nХлопок - 25шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Стул 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 200шт\nЛён - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Стул 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 200шт\nЛён - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Зонтик 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 150шт\nНитки - 5шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Зонтик 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 150шт\nНитки - 5шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Зонтик 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 150шт\nНитки - 5шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Зонтик 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 150шт\nНитки - 5шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Зонтик 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 10шт\nХлопок - 150шт\nНитки - 5шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Качели 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 50шт\nЛён - 5шт\nДрова - 100шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Качели 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 50шт\nЛён - 5шт\nДрова - 100шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Диван")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nХлопок - 350шт\nЛён - 350шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Цветок 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛён - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Цветок 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛён - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Цветок 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛён - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Цветок 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛён - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Цветок 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛён - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Беседка 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛён - 300шт\nМеталл - 30шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Беседка 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛён - 300шт\nМеталл - 30шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Беседка 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛён - 300шт\nМеталл - 30шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Беседка 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛён - 300шт\nМеталл - 30шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Надувной Мяч 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nЛён - 300шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Надувной Мяч 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nЛён - 300шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Надувной Мяч 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nЛён - 300шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Надувной Дельфин 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nЛён - 500шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Надувной Дельфин 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nЛён - 500шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Мангал 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nБронза - 30шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Мангал 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nБронза - 30шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Мангал 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nБронза - 30шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Казан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nАлюминий - 1шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
		--- флажок
	imgui.Button(u8"Флажок ЛГБТ")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Армения")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Узбекистан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Таджикистан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Молдавия")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Флажок Беларусь")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Россия")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Казахстан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Флажок Кыргыстан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Туркменистан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Украина")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Флажок Азербайджан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Куст 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 600шт\nДрова - 300шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Куст 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 600шт\nДрова - 300шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Куст 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 600шт\nДрова - 300шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Куст 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 600шт\nДрова - 300шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Куст 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 600шт\nДрова - 300шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Куст 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лён - 600шт\nДрова - 300шт\nСтоимость - 4500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Спортивная Площадка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nХлопок - 700шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Бассейн")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 500шт\nХлопок - 500шт\nЛён - 400шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Надувной круг 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nХлопок - 50шт\nЛён - 70шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Надувной круг 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nХлопок - 50шт\nЛён - 70шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Надувной круг 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nХлопок - 50шт\nЛён - 70шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Надувной круг 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nХлопок - 50шт\nЛён - 70шт\nСтоимость - 7500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Кирпичная печь")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nКамень - 100шт\nБронза - 10шт\nСтоимость - 8100р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Теннисный стол")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 250шт\nНитки - 5шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Шатер 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 250шт\nНитки - 10шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Шатер 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 250шт\nНитки - 10шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шатер 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 250шт\nНитки - 10шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шатер 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 250шт\nНитки - 10шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Шатер 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 20шт\nХлопок - 250шт\nНитки - 10шт\nСтоимость - 9000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Батут")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nХлопок - 500шт\nНитки - 5шт\nЛён - 70шт\nСтоимость - 10500р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Зеленый мусорный бак")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Желтый мусорный бак")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Синий мусорный бак")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Магазина Оружия")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Бара")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Магазина Одежды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Магазина Садоводства")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Отеля")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Кинотеатра")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Букмекерской Конторы")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Зоомагазина")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Магазина Аксессуаров")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Магазина Видеокарт")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Шашлычки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Ателье")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Пятерочка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Ломбарда")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Вкусвилл")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Магнит")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Диски")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Лесопилки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Магазина Механики")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Тест-Драйва")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Аренды Машин")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Автобазара")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Вывеска Mcdonalds")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Аренды Скутеров")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Вывеска Вкусно И Точка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nПроволока - 1шт\nХлопок - 5шт\nАлюминий - 2шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Столик С Лавками 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Столик С Лавками 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Столик С Лавками 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Столик С Лавками 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Столик С Лавками 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Столик С Лавками 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Столик С Лавками 7")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Столик С Лавками 8")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nМеталл - 400шт\nХлопок - 40шт\nСтоимость - 6000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Кресло Качалка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 100шт\nКамень - 120шт\nМеталл - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Белый Светильник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 200шт\nМеталл - 40шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Синий Светильник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 200шт\nМеталл - 40шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Зеленый Светильник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 200шт\nМеталл - 40шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Красный Светильник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 200шт\nМеталл - 40шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Желтый Светильник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 200шт\nМеталл - 40шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Голубой Светильник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 200шт\nМеталл - 40шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Фиолетовый Светильник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Камень - 200шт\nМеталл - 40шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Костер")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 70шт\nЛен - 200шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Красный Мангал")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Серый Мангал")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Железный Стул")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Красный Стул")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Железный Стул")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 300шт\nМеталл - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Лавочка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nЛен - 400шт\nМеталл - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Железный Стул")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nЛен - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Мяч")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Парашют - 1шт\nЛен - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Диван")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nЛен - 350шт\nХлопок - 350шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Цветок В Сером Горшке")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 600шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Красный Цветок В Горшке")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 600шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Куст(Кактус)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 600шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Большой Куст")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 600шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Цветы")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 700шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Небольшое Дерево 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 500шт\nДрова - 600шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Небольшое Дерево 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 500шт\nДрова - 600шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Небольшое Дерево 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 500шт\nДрова - 600шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Большой Куст 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Большой Куст 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Папоротник")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Пляжный Куст")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Зеленый Пляжный Лежак")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 340шт\nМеталл - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Серый Пляжный Лежак")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 340шт\nМеталл - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Тент")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 400шт\nЛен - 40шт\nМеталл - 400шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Лавочка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 300шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Бутылки С Вином")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 100шт\nЛен - 200шт\nХлопок - 200шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Красный Стол")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Красный Стол В Клетку")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nЛен - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Черный Стул")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 100шт\nЛен - 200шт\nМеталл - 10шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Красный Стул В Клетку")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 100шт\nЛен - 200шт\nМеталл - 10шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Два Стула Со Столом")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 300шт\nМеталл - 200шт\nХлопок - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Растение В Горшке 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛен - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Растение В Горшке 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛен - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Растение В Горшке 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛен - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Растение В Горшке 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 120шт\nЛен - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Растение В Форме Лавки")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Дрова - 150шт\nЛен - 450шт\nМеталл - 60шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Белая Ваза")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nЛен - 100шт\nДрова - 100шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Серая Ваза С Цветком")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nЛен - 100шт\nДрова - 100шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Настенный Цветок 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 300шт\nДрова - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Настенный Цветок 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 300шт\nДрова - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Деревянный Стул")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 200шт\nДрова - 200шт\nМеталл - 20шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Коробки Из Под Пиццы")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 200шт\nДрова - 200шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Пицца")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 100шт\nДрова - 80шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Коробки Из Под Еды")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Лен - 100шт\nДрова - 100шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Коробки Из Под Пиццы")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Бронза - 45т\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Пачка С Деньгами")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Мешок С Деньгами")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Сейф С Деньгами")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 450шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Пакетик С Наркотиками 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Пакетик С Наркотиками 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Оружие M4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Оружие Снайперская Винтовка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Оружие Револьвер")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Оружие Дигл")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Оружие Дробовик 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Оружие Дробовик 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Оружие Дробовик 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Оружие AK-47")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Оружие МП-5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 40шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Железная Мусорка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 20шт\nДрова - 200шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Прозрачная Мусорка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 20шт\nДрова - 200шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Пластиковая Мусорка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 20шт\nДрова - 200шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Серая Мусорка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 40шт\nБронза - 20шт\nДрова - 200шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"Деревянный Забор 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Синий Забор")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Забор Из Мелких Досок")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Деревянный Забор 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Высокий Забор")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Металический Забор")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ограждение")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 60шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Стеклянный Забор")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nДрова - 300шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Забор В Виде Сетки 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 60шт\nДрова - 450шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Забор В Виде Сетки 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 60шт\nДрова - 450шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Ноутбук")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Бутылка Алкоголя 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Бутылка Алкоголя 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"Серая Колонка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Магнитофон")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Белый Домофон")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Серый Домофон")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Коричневый Чемодан")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 15шт\nБронза - 15шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Сумка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nЛен - 150шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Черная Колонка")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"Синий Неоновый Свет")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"Белый Неоновый Свет")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Розовый Неоновый Свет")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"Желтый Неоновый Свет")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Зеленый Неоновый Свет")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Красный Неоновый Свет")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 45шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Котел")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 45шт\nБронза - 60шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Скейт")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 30шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Красная Гитара")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 15шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Черная Гитара")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 15шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Белая Гитара")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Металл - 30шт\nБронза - 15шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Карта Города")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'Хлопок - 150шт\nМеталл - 15шт\nСтоимость - 3000р')
		    imgui.EndTooltip()
		end																																																																																																																																																																																										
	end
	imgui.EndChild()
	----------------------------------------------------------------
	imgui.SetCursorPos(imgui.ImVec2(30, 350))
	if imgui.Button(u8'Автор',imgui.ImVec2(165,35)) then
	    os.execute('start https://vk.com/srevenreg')
    end
    imgui.SetCursorPos(imgui.ImVec2(205, 350))
   	if imgui.Button(u8'Закрыть',imgui.ImVec2(165,35)) then
	    main_window_state.v = not main_window_state.v
    end
imgui.End()
end
end   


function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function save()
	inicfg.save(cfg, 'CraftHelper.ini')
end


function imgui.Link(link,name,myfunc)
	myfunc = type(name) == 'boolean' and name or myfunc or false
	name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
	local size = imgui.CalcTextSize(name)
	local p = imgui.GetCursorScreenPos()
	local p2 = imgui.GetCursorPos()
	local resultBtn = imgui.InvisibleButton('##'..link..name, size)
	if resultBtn then
		if not myfunc then
		    os.execute('explorer '..link)
		end
	end
	imgui.SetCursorPos(p2)
	if imgui.IsItemHovered() then
		imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], name)
		imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
	else
		imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.Button], name)
	end
	return resultBtn
end

function imgui.offset(text)
    local offset = 130
    imgui.Text(text)
    imgui.SameLine()
    imgui.SetCursorPosX(offset)
    imgui.PushItemWidth(190)
end
function imgui.prmoffset(text)
    local offset = 87
    imgui.Text(text)
    imgui.SameLine()
    imgui.SetCursorPosX(offset)
    imgui.PushItemWidth(190)
end