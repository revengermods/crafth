script_name('CraftHelper')
script_author('revenger mods')
script_version('1.3')

require "lib.moonloader" -- ����������� ����������

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

local update_url = "https://raw.githubusercontent.com/revengermods/crafth/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://raw.githubusercontent.com/revengermods/crafth/main/crafthelper.lua" -- ��� ���� ������
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
	sampAddChatMessage(''..color..'[CraftHelper]{ffffff} ������� ��������! ��������:'..color..' /craft ', -1)
	--sampAddChatMessage('Craft Helper{ffffff} ������� ��������! ��������:{9370DB} /craft', -1)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage(''..color..'[CraftHelper] ���� ����������! ������: ' .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage(''..color..'[CraftHelper] ������ ������� ��������! | �����: '..color..'[vk.com/qweeqwz]', -1)
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
	elseif theme == 4 then -- �����
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
	local colours = {u8'�������', u8'����������', u8'������', u8'���������', u8'�����'}	
	if main_window_state then
	imgui.SetNextWindowSize(imgui.ImVec2(400, 400), imgui.Cond.FirstUseEver)
	if not window_pos then
		ScreenX, ScreenY = getScreenResolution()ScreenX, ScreenY = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
	end		
	imgui.Begin(u8"CraftHelper | ������: 1.3", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
	imgui.CenterText(u8" ")
	imgui.SameLine()
	imgui.SetCursorPos(imgui.ImVec2(4, 25))
	imgui.BeginChild('left', imgui.ImVec2(123, -50), true)
	if imgui.Selectable(u8"���������", menu == 14) then menu = 14 
	elseif imgui.Selectable(u8"����������", menu == 1) then menu = 1 
	elseif imgui.Selectable(u8"������", menu == 2) then menu = 2 
	elseif imgui.Selectable(u8"�����", menu == 9) then menu = 9 
	elseif imgui.Selectable(u8"���������", menu == 7) then menu = 7 
	elseif imgui.Selectable(u8"�������", menu == 3) then menu = 3 
	elseif imgui.Selectable(u8"������", menu == 10) then menu = 10 
	elseif imgui.Selectable(u8"�������", menu == 11) then menu = 11 
	elseif imgui.Selectable(u8"������", menu == 12) then menu = 12  
	elseif imgui.Selectable(u8"�������", menu == 13) then menu = 13 end
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild('right', imgui.ImVec2(0, -50), true) 	
	if menu == 1 then
		-- 1 
	imgui.Button(u8'������ ������������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n����� - 10��\n˸� - 50��\n������ - 50��\n��������� - 3000�')
		    imgui.EndTooltip()
		end   
	imgui.Button(u8'������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 12��\n��������� ������� �������� - 42��\n�������� - 3��\n˸� - 40��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'������ ��������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n�������� - 30��\n������ - 40��\n������ - 60��\n������ - 100��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'������ Stranger Things')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'����� Stranger Things')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 30��\n������ - 30��\n����� ������ ����� - 6��\n�������� - 4��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'������ ������ �� ��������� ����������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 4��\n�������� - 4��\n������ - 6��\n��������� - 5000�')
		    imgui.EndTooltip()
		end
		imgui.Button(u8'��������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 90��\n������ - 70��\n����� ������ ����� - 10��\n�������� - 8��\n������ - 6��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'������� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 10��\n������ - 10��\n����� ������ ����� - 4��\n�������� - 2��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'����� ������ �� ������� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 90��\n������ - 60��\n����� ������ ����� - 10��\n�������� - 4��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end
		imgui.Button(u8'����� ���� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 10��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'���������� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n�������� - 30��\n������ - 40��\n������ - 60��\n������ - 100��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 10��\n�������� - 6��\n������ - 6��\n��������� - 5000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'�����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 10��\n�������� - 6��\n������ - 6��\n��������� - 5000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 10��\n�������� - 6��\n������ - 6��\n��������� - 5000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'���� �������� - �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'���������� ����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'�������� Balenciaga')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end
		imgui.Button(u8'�������� Gucci 1')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'�������� Gucci 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'����� Stone Island')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'����� Gucci 1')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'���� � BIT')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'���� Balenciaga')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 4��\n��������� - 5000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'����� ��������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 60��\n������ - 90��\n����� ������ ����� - 10��\n�������� - 14��\n������ - 10��\n��������� - 5000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'����� �� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 50��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 8��\n������ - 6��\n��������� - 5000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8'������ �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 100��\n������ - 60��\n����� ������ ����� - 14��\n�������� - 10��\n������ - 10��\n��������� - 5000�')
		    imgui.EndTooltip()
		end																																															
	imgui.Button(u8'����� �� ������������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 100��\n������ - 100��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8'�������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 25��\n������ - 9��\n������ - 50��\n������ - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 20��\n������ - 3��\n�������� - 5��\n˸� - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'�����������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 18��\n������ - 4��\n����������� - 80��\n������ - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'�����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 13��\n������ - 6��\n˸� - 10��\n������ - 10��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 6��\n�������� - 13��\n������ - 6��\n˸� - 10��\n������ - 10��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'�������� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end																	
	imgui.Button(u8'���� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'���. ����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n����� � ������������� - 2��\n˸� - 100��\n������ - 100��\n����� - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������������ �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 30��\n��������� - 10��\n������� - 1��\n˸� - 3��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n����� - 6��\n��������� - 24��\n˸� - 5��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������- 30��\n����� - 20��\n��������� - 10��\n������ - 5��\n˸� - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 26��\n����� - 6��\n��������� - 2��\n˸� - 5��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'��� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 8��\n����� - 6��\n������ - 4��\n˸� - 5��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 11��\n������ - 12��\n������ - 3��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 14��\n��������� - 15��\n������ - 6��\n������� - 3��\n˸� - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'��������� �� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 50��\n��������� - 35��\n�������� - 15��\n����� � ������������� - 5��\n������ - 4��\n��������� - 4500�')
		    imgui.EndTooltip()
		end	
-------------------------------------------------------------------------------------------------
	imgui.Button(u8'������ (�������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 5��\n˸� - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 5��\n˸� - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8'������ (������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 5��\n˸� - 5��\n��������� - 15000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'�������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 2��\n��������� - 25��\n������ - 5��\n˸� - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �����-�������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 10��\n˸� - 2��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 10��\n˸� - 2��\n��������� - 15000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������ ������-�����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 10��\n˸� - 2��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 10��\n˸� - 2��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n����� - 100��\n������ - 10��\n������ - 10��\n˸� - 2��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���� GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 60��\n˸� - 60��\n������ - 2��\n����� - 6��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���� LOUIS VUITTON')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 60��\n˸� - 60��\n������ - 2��\n����� - 6��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���� LOUIS VUITTON ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 60��\n˸� - 60��\n������ - 2��\n����� - 6��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���� ADIDAS')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 60��\n˸� - 60��\n������ - 2��\n����� - 6��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���� NIKE')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 60��\n˸� - 60��\n������ - 2��\n����� - 6��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� (�������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 60��\n�������� - 2\n˸� - 60��\n�������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 60��\n�������� - 2\n˸� - 60��\n�������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� (����������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 60��\n�������� - 2\n˸� - 60��\n�������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		-------	
	imgui.Button(u8'������� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ����������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ���������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'������� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� Army')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ���� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ���� ����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� BMW')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ��������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ���')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ���� ���')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ������ � ���')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n˸� - 200��\n����� ������� - 1��\n����� ������ - 1��\n����� ����� - 1��\n��������� - 7500�')
		    imgui.EndTooltip()
		end																																																															
	imgui.Button(u8'����������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n������ - 60��\n�������� - 1��\n˸� - 50��\n����� ����� - 1��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
---
	imgui.Button(u8'���������� ���� (�������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 60��\n�������� - 2��\n˸� - 40��\n�������� - 2��\n��������� - 10500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���������� ���� (��������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 60��\n�������� - 2��\n˸� - 40��\n�������� - 2��\n��������� - 10500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���������� ���� (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 60��\n�������� - 2��\n˸� - 40��\n�������� - 2��\n��������� - 10500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'���������� ���� (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 60��\n�������� - 2��\n˸� - 40��\n�������� - 2��\n��������� - 10500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ��� �������� (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 50��\n�������� - 2��\n������ - 1��\n��������� ������� �������� - 1��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ��� �������� (�������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 50��\n�������� - 2��\n������ - 1��\n��������� ������� �������� - 1��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ��� �������� (�������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 50��\n�������� - 2��\n������ - 1��\n��������� ������� �������� - 1��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ��� �������� (������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 50��\n�������� - 2��\n������ - 1��\n��������� ������� �������� - 1��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ��� �������� (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 50��\n�������� - 2��\n������ - 1��\n��������� ������� �������� - 1��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���������� (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���������� (������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���������� (����������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���������� (������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���������� (������������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ ������� (�������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 55��\n��������� - 40��\n�������� - 20��\n����� � ������������� - 1��\n������ - 10��\n��������� - 16500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������ ������� (�������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 55��\n��������� - 40��\n�������� - 20��\n����� � ������������� - 1��\n������ - 10��\n��������� - 16500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������ ������� (�����)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 55��\n��������� - 40��\n�������� - 20��\n����� � ������������� - 1��\n������ - 10��\n��������� - 16500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������ ������� (����������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 55��\n��������� - 40��\n�������� - 20��\n����� � ������������� - 1��\n������ - 10��\n��������� - 16500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������ ������� (������)')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 55��\n��������� - 40��\n�������� - 20��\n����� � ������������� - 1��\n������ - 10��\n��������� - 16500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� - �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 80��\n����� - 4��\n�������� - 1��\n������ - 10��\n������ - 2��\n��������� - 12000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� SUPREME')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� LOUIS VUITTON')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'�������� CHANEL')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'�������� GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8'�������� NIKE')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 70��\n˸� - 70��\n������ - 2��\n����� - 6��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� ���� - ���������� 1')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���� - ���������� 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� ���� - ���������� 3')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���� - ���������� 4')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���� - ���������� 5')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ���� - ���������� 6')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'����� ����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n˸� - 70��\n������ - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end																																																																																																
	imgui.Button(u8'������� ������� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ������� ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ������� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ���� �������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ���� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ������� GUCCI')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����������� ����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'������� ������� ��')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8'������� ������� �� 2')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� - ������')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8'����� �����')
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� ���� - �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ���� - �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� ���� - �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� ���� - �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� � ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ � ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ����� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ����� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ����� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ����� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ����� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ����� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ����� - ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ������ ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ������ - ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� Atletic")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� ����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ � �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ � ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ � ����������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 12��\n�������� - 6��\n������ - 70��\n˸� - 70��\n��������� - 250��\n��������� - 13500�')
		    imgui.EndTooltip()
		end																																																																																																				
	imgui.Button(u8"����� BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n�������� - 10��\n������ - 15��\n˸� - 50��\n������ - 50��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n�������� - 10��\n������ - 15��\n˸� - 50��\n������ - 50��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"���������� BURGER KING")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n�������� - 10��\n������ - 15��\n˸� - 50��\n������ - 50��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 25��\n������ - 25��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	elseif menu == 2 then
	-- ������ (id:394)
	imgui.Button(u8"������ (id:540)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"����� ������ (id:541)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"������ ����� (id:594)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
--
	imgui.Button(u8"����� ��������� (id:595)")
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		imgui.EndTooltip()
	end	
--
	imgui.Button(u8"��� (id:567)")
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		imgui.EndTooltip()
	end	
	imgui.Button(u8"������� (id:568)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"���� (id:570)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"������ (id:571)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"������ (id:572)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"�������� (id:573)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		--
		imgui.Button(u8"������ (id:575)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"������ (id:579)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"���� ���� (id:580)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"��� (id:581)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"����� ������ (id:582)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"����� (id:584)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"����� (id:585)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"���� (id:591)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"������ (id:538)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"��� ������ (id:554)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
		--
		imgui.Button(u8"���� ����� (id:555)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"����� ��� (id:556)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"���� ������� (id:557)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 100��\n˸� - 100��\n����� ������ ����� - 10��\n��������� - 10��\n����� ������� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end																														
	imgui.Button(u8"������ (id:394)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ (id:395)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ ���� (id:396)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� (id:398)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� �������� (id:399)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end		
------------------------------------------------------------------------------------------------------
	imgui.Button(u8"��� ���� (id:400)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"��������� (id:402)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� (id:403)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ (id:404)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"��������� (id:405)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end			
---------------------------------------------------------------------------------------------------
	imgui.Button(u8"���������� (id:406)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ (id:407)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� (id:408)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� (id:409)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 1��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���� ������ (id:410)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end	
		-------------
	imgui.Button(u8"Noize MC (id:412)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
			imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���� ���� (id:413)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 3��\n��������� - 1000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���� �������� (id:416)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 90��\n˸� - 90��\n����� ������ ����� - 2��\n��������� - 1000�')
		    imgui.EndTooltip()
		end																																															
	elseif menu == 9 then
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 1��\n��������� - 150�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 2��\n������������� ���� - 2��\n��������� - 900�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 14��\n��������� - 10��\n������� - 1��\n������ - 21��\n��������� - 3000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"����������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 20��\n������ - 20��\n���������������� ���� - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ������ �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 1��\n������ - 1��\n��������� - 3000�')
		    imgui.EndTooltip()
		end				
	elseif menu == 12 then
	imgui.Button(u8"Glock Pink")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"Makarov Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end															
	imgui.Button(u8"TT Brown")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Red")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Deagle Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Colt Python Eagle")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"AK574 Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n�������� - 15��\n������ - 18��\n������ - 90��\n˸� - 90��\n��������� - 75000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"M249 Deserted")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n�������� - 75��\n������ - 60��\n������ - 180��\n˸� - 180��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"M249 Vietnam")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n�������� - 75��\n������ - 60��\n������ - 180��\n˸� - 180��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	elseif menu == 3 then
	imgui.Button(u8"���� ��� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 200��\n������ - 40��\n�������� - 10��\n������ - 10��\n����������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ��� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 100��\n������ - 10��\n��������� - 300000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ��� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 50��\n��������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 3��\n��������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ��� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� - 5��\n������ - 5��\n������ - 10��\n��������� - 1��\n������� - 1��\n��������� - 300000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n����� - 1��\n��������� - 1��\n������� - 1��\n������ - 5��\n��������� - 300000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ��� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������� - 3��\n��������� - 15000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"�������� ��� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 2��\n������ - 50��\n�������� - 2��\n��������� - 15000�')
		    imgui.EndTooltip()
		end	
		imgui.Separator()
		imgui.CenterText(u8"���� ��� ����������")
		imgui.Separator()	
		---
		imgui.Button(u8"������ �������������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������������� ���� - 1��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������������� ���� - 1��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�������� �������� - 10��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"����� �� ����������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 5��\n������� - 5��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"��������� �� ����������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 20��\n��������� - 200��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"������� ���������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 10��\n������� - 5��\n����� - 1��\n��������� - 0�')
		    imgui.EndTooltip()
		end	--������� ������ ���
		imgui.Button(u8"������� ������ ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'�� - 1��\n���� - 1��\n������� - 1��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"������� ����������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n������� - 3��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"����������� ���������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� ���������� ��� - 2��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"����������� ������ ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� ������ ��� - 2��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"����������� ����������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� ����������� ��� - 2��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		---	
		imgui.Button(u8"������ ���������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����������� ���������� ��� - 3��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"������ ������ ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����������� ������ ��� - 3��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"������ ����������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����������� ����������� ��� - 3��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		---	
		imgui.Button(u8"���� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 5��\n������ - 5��\n������� - 1��\n��� - 15��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"���� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 5��\n������ - 5��\n������� - 1��\n��� - 15��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"���� Marvel")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 5��\n������ - 5��\n������� - 1��\n��� - 15��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
		imgui.Button(u8"���� ������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 5��\n������ - 5��\n������� - 1��\n��� - 15��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
		imgui.Button(u8"���� ������������ �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 5��\n������ - 5��\n������� - 1��\n��� - 15��\n��������� - 0�')
		    imgui.EndTooltip()
		end											
		---															
	elseif menu == 13 then
	imgui.Button(u8"Vivo V25")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n������ - 10��\n�������� - 10��\n������� - 10��\n������ - 10��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 13 pro Max Graphite")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 25��\n�������� - 50��\n������� - 30��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 13 pro Max Alpine Green")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 25��\n�������� - 50��\n������� - 30��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 13 pro Max Sierra Blue")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 25��\n�������� - 50��\n������� - 30��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 13 pro Max Gold")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 25��\n�������� - 50��\n������� - 30��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 13 pro Max Silver")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 25��\n�������� - 50��\n������� - 30��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 14 pro Max Space Black")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 30��\n�������� - 50��\n������� - 30��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 14 pro Max Deep Purple")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 30��\n�������� - 50��\n������� - 30��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Apple Iphones 14 pro Max Silver")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 30��\n�������� - 50��\n������� - 30��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Apple Iphones 14 pro Max Gold")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 30��\n�������� - 50��\n������� - 30��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Asus Rog Phone 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 30��\n�������� - 50��\n������� - 30��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Google Pixel 7 Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 15��\n�������� - 20��\n������� - 25��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Honor 50")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 15��\n�������� - 20��\n������� - 25��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Huawei Mate 50 Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 15��\n�������� - 20��\n������� - 25��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Xiaomi 12T Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 15��\n�������� - 20��\n������� - 25��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Xiaomi 12T Ultra")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 15��\n�������� - 20��\n������� - 25��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Motorola Edge 3D Ultra")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n������ - 10��\n�������� - 15��\n������� - 17��\n������ - 8��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Nothing Phone")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 1��\n������ - 2��\n�������� - 3��\n������� - 2��\n������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"Oppo Fino X5 Pro")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n������ - 10��\n�������� - 15��\n������� - 17��\n������ - 8��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Poco F4 GT")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n������ - 10��\n�������� - 15��\n������� - 17��\n������ - 8��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Samsung Galaxy S23 Ultra")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 15��\n�������� - 20��\n������� - 25��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"Sony Xperia 1 Iv")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n������ - 10��\n�������� - 15��\n������� - 17��\n������ - 8��\n��������� - 3000�')
		    imgui.EndTooltip()
		end					
	elseif menu == 11 then
	imgui.Button(u8"������ ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����������� ������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
-----------------------------------------------------------------------
	imgui.Button(u8"������ ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����� ��� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ �������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ ��������� ��� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������ ���������� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� ������� - 100��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	elseif menu == 10 then	
	imgui.Button(u8"������ (������) (Carbon Ring)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ (������) (Carbon Two)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ (������) (Cradient Two)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ (������) (Grid)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� (Ducktaili)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� (Reaper)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������� (Daytona)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� (Curse)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 4��\n��������� - 400��\n����� - 250��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
-- ������� ------------------------------------------------------------	
	imgui.Button(u8"����� - 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 7")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 8")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 9")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 10")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� - 11")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 12")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 13")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 14")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 15")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 16")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 17")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� - 80��\n�������� � ������� - 30��\n����� ������ ����� - 50��\n������ - 25��\n˸� - 25��\n��������� - 21000�')
		    imgui.EndTooltip()
		end
	-- ����� -------------------------------------------------------
	imgui.Button(u8"����� - 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 7")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 8")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 9")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 10")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 11")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 12")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 13")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 14")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 15")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 16")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� - 17")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ����� ������� - 1��\n���������� ����� ��������� - 1��\n�������� - 2��\n��������� - 400��\n������ - 15��\n��������� - 21000�')
		    imgui.EndTooltip()
		end		
	-- ��������� -----
	elseif menu == 14 then
		-- ���
		imgui.Text(u8'����� ���?') imgui.SameLine() imgui.Link('https://vk.com/srevenreg', u8'��� ����!')
		-- ������ ��
		imgui.Text(u8'�����:') imgui.SameLine() imgui.Link('https://vk.com/srevenreg', u8'revenger mods.')
		-- ��� �������
		imgui.Text(u8'���� �������:') imgui.SameLine() imgui.Link('https://vk.com/topic-217349315_49351051', u8'����!')
		imgui.Separator()
	  	imgui.Text(u8' ����� ����:')
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
		imgui.Button(u8"���������� ���������� VIP")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'���������� ���������� VIP (30�) - 4��\n��� - 500��\n������ - 500��\n������� - 100��\n������ - 100��\n��������� - 150000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 3��\n��������� - 150�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n��������� - 150�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 5��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 20��\n�������� - 10��\n��������� ������� �������� - 10��\n��������� - 0�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 18��\n������ - 18��\n������ - 3��\n������ - 2��\n������� - 1��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ��� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ ������ - 1��\n������� ��������� - 1��\n����� ������������� ������ - 1��\n������ - 1��\n������ - 1��\n��������� - 75000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��������� ������� �������� - 30��\n������ - 8��\n������� - 1��\n��������� - 58��\n������ - 45��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 500��\n�������� - 20��\n��������� - 70��\n������ - 25��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 200��\n˸� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 200��\n˸� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 150��\n����� - 5��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 150��\n����� - 5��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 150��\n����� - 5��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 150��\n����� - 5��\n��������� - 9000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 10��\n������ - 150��\n����� - 5��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 50��\n˸� - 5��\n����� - 100��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 50��\n˸� - 5��\n����� - 100��\n��������� - 9000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 350��\n˸� - 350��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n˸� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n˸� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n˸� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n˸� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n˸� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n˸� - 300��\n������ - 30��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n˸� - 300��\n������ - 30��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n˸� - 300��\n������ - 30��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n˸� - 300��\n������ - 30��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ��� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n˸� - 300��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ��� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n˸� - 300��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ��� 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n˸� - 300��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ������� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n˸� - 500��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ������� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n˸� - 500��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n������ - 30��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n������ - 30��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n������ - 30��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n�������� - 1��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
		--- ������
	imgui.Button(u8"������ ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ������������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 600��\n����� - 300��\n��������� - 4500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 600��\n����� - 300��\n��������� - 4500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 600��\n����� - 300��\n��������� - 4500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 600��\n����� - 300��\n��������� - 4500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 600��\n����� - 300��\n��������� - 4500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���� 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'˸� - 600��\n����� - 300��\n��������� - 4500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n������ - 700��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 500��\n������ - 500��\n˸� - 400��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ���� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n������ - 50��\n˸� - 70��\n��������� - 7500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� ���� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n������ - 50��\n˸� - 70��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ���� 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n������ - 50��\n˸� - 70��\n��������� - 7500�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� ���� 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n������ - 50��\n˸� - 70��\n��������� - 7500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 100��\n������ - 10��\n��������� - 8100�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 250��\n����� - 5��\n��������� - 9000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 250��\n����� - 10��\n��������� - 9000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 250��\n����� - 10��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 250��\n����� - 10��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 250��\n����� - 10��\n��������� - 9000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 20��\n������ - 250��\n����� - 10��\n��������� - 9000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n������ - 500��\n����� - 5��\n˸� - 70��\n��������� - 10500�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� �������� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� �����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ������������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� �����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� �����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� �������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ����-������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ������ �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� Mcdonalds")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ������ ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ������ � �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n��������� - 1��\n������ - 5��\n�������� - 2��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ � ������� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ � ������� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ � ������� 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ � ������� 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ � ������� 5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ � ������� 6")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ � ������� 7")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ � ������� 8")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n������ - 400��\n������ - 40��\n��������� - 6000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 100��\n������ - 120��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n������ - 40��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n������ - 40��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n������ - 40��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n������ - 40��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n������ - 40��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n������ - 40��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 200��\n������ - 40��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 70��\n��� - 200��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 300��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n��� - 400��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n��� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������� - 1��\n��� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n��� - 350��\n������ - 350��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ � ����� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 600��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ������ � ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 600��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����(������)")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 600��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 600��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 700��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� ������ 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 500��\n����� - 600��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� ������ 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 500��\n����� - 600��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"��������� ������ 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 500��\n����� - 600��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ���� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ���� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������� ������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 340��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 340��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 400��\n��� - 40��\n������ - 400��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 300��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� � �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 100��\n��� - 200��\n������ - 200��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ���� � ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n��� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 100��\n��� - 200��\n������ - 10��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� ���� � ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 100��\n��� - 200��\n������ - 10��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"��� ����� �� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 300��\n������ - 200��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� � ������ 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n��� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"�������� � ������ 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n��� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� � ������ 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n��� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������� � ������ 4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 120��\n��� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� � ����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'����� - 150��\n��� - 450��\n������ - 60��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n��� - 100��\n����� - 100��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� ���� � �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n��� - 100��\n����� - 100��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"��������� ������ 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 300��\n����� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"��������� ������ 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 300��\n����� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 200��\n����� - 200��\n������ - 20��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �� ��� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 200��\n����� - 200��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 100��\n����� - 80��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �� ��� ���")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'��� - 100��\n����� - 100��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �� ��� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45�\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� � ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� � ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���� � ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 450��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� � ����������� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� � ����������� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ M4")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����������� ��������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ���������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ �������� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ �������� 3")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ AK-47")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ ��-5")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 40��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 20��\n����� - 200��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 20��\n����� - 200��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 20��\n����� - 200��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 40��\n������ - 20��\n����� - 200��\n��������� - 3000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"���������� ����� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� �� ������ �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"���������� ����� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������������ �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 60��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� �����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n����� - 300��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� � ���� ����� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 60��\n����� - 450��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� � ���� ����� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 60��\n����� - 450��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"�������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������� �������� 1")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� 2")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n��������� - 3000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"����� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"����� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"����� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"���������� �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 15��\n������ - 15��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n��� - 150��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������ �������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"����� �������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end			
	imgui.Button(u8"����� �������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end
	imgui.Button(u8"������ �������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"������� �������� ����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 45��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 45��\n������ - 60��\n��������� - 3000�')
		    imgui.EndTooltip()
		end	
	imgui.Button(u8"�����")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 30��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 15��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"������ ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 15��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 30��\n������ - 15��\n��������� - 3000�')
		    imgui.EndTooltip()
		end		
	imgui.Button(u8"����� ������")
		if imgui.IsItemHovered() then
		    imgui.BeginTooltip()
		    imgui.Text(u8'������ - 150��\n������ - 15��\n��������� - 3000�')
		    imgui.EndTooltip()
		end																																																																																																																																																																																										
	end
	imgui.EndChild()
	----------------------------------------------------------------
	imgui.SetCursorPos(imgui.ImVec2(30, 350))
	if imgui.Button(u8'�����',imgui.ImVec2(165,35)) then
	    os.execute('start https://vk.com/srevenreg')
    end
    imgui.SetCursorPos(imgui.ImVec2(205, 350))
   	if imgui.Button(u8'�������',imgui.ImVec2(165,35)) then
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