script_author('@BGDN for Banderas Family')
script_name("adHelper")
local script__version = '2.2'
script_version(script__version)
local keys = require "vkeys"
script_description('Підрахунок к-ті оголошень в ЗМІ та інвайтів')
require("lib.moonloader")
local copas = require 'copas'
local http = require 'copas.http'
local imgui = require 'imgui'
local encoding = require 'encoding'
local requests = require 'requests'
requests.http_socket, requests.https_socket = http, http
local json = require("cjson")
local base64 = require("base64")
local encoding = require 'encoding'
local as_action = require('moonloader').audiostream_state
encoding.default = 'CP1251'
u8= encoding.UTF8
local dlstatus = require('moonloader').download_status
------------------ImGUI----------------------------
imgui.Spinner = require('imgui_addons').Spinner
local secondary_window_state = imgui.ImBool(false)
local main_window_state = imgui.ImBool(false)
local third_window_state = imgui.ImBool(false)
local fourth_window_state = imgui.ImBool(false)
local fifth_window_state = imgui.ImBool(false)
local sixth_window_state = imgui.ImBool(false)
local seventh_window_state = imgui.ImBool(false)
local choiceTG_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local text_buffer2 = imgui.ImBuffer(256)
local text_buffer3 = imgui.ImBuffer(256)
local text_buffer4 = imgui.ImBuffer(256)
local text_buffer5 = imgui.ImBuffer(256)
local text_buffer6 = imgui.ImBuffer(256)
local text_buffer7 = imgui.ImBuffer(256)
local text_buffer8 = imgui.ImBuffer(2048)
local text_buffer9 = imgui.ImBuffer(256)
local text_buffer14 = imgui.ImBuffer(256)
local text_buffer15 = imgui.ImBuffer(256)
local text_buffer16 = imgui.ImBuffer(256)
local text_buffer17 = imgui.ImBuffer(256)
local text_buffer18 = imgui.ImBuffer(256)
local text_buffer_notebook = imgui.ImBuffer(256)
local text_buffer_add_bl = imgui.ImBuffer(256)
local slider = imgui.ImInt(1)
local slider_font_size = imgui.ImInt(1)
local slider_font_family = imgui.ImInt(0)
local slider_font_size_staff = imgui.ImInt(0)
local checked_notepad = imgui.ImBool(false)
local checked_piar = imgui.ImBool(false)
local checked_not = imgui.ImBool(false)
local checked_giv = imgui.ImBool(false)
local checked_time = imgui.ImBool(false)
local checked_info9 = imgui.ImBool(false)
local checked_tax = imgui.ImBool(false)
local checked_stats = imgui.ImBool(false)
local checked_online_screen = imgui.ImBool(false)
local text_buffer_not_time1 = imgui.ImBuffer(256)
local text_buffer_not_time2 = imgui.ImBuffer(256)
local text_buffer_not_time3 = imgui.ImBuffer(256)
-------------------------------------------------------------------------------
local mynick, dsandtg, GivPlayers, update_link, notebook_text, text_private_notepad, uidhunt, blacklist_text, new_text_blacklist, myTG,myip = "","","","","", "","","","","",""
local sw, sh = getScreenResolution()
local effil = require 'effil'
local ffi = require "ffi"
ffi.cdef[[
    bool SetCursorPos(int X, int Y);
]]
ffi.cdef[[
     void keybd_event(int keycode, int scancode, int flags, int extra);
]]
ffi.cdef[[
    short GetAsyncKeyState(int vKey);
]]
local allSum = 0
local PosWindowX, PosWindowY, SizeWindowX, SizeWindowY = sw/1.185, sh/2, 300, 150 
local TimerReq = 0
require 'sampfuncs' 
local premium = false
local sampev = require 'lib.samp.events' 
local StepAD = 0
local StepInv = 0
local requestTimer, styleimg, countVIP , TimerUpdate, PosPadX, PosPadY, TimeSalary, line_uid, TimerUPDBlacklist, player_time = 0,0,0,0,0,0,0,0,0,0
local Sum = 0
local active, get, notontimer1, notontimer2, paytax,check_tax, take_salary, update_status, numberpl, send_message, state_button_send, check_uid, check_uid_blacklist,accessibility, not_vr, ad_piar_delay = false, false,false,false,false,false,false,false,false, true, true,false,false,false,false,false
local notontimer3,notontimer4,notontimer5 = false,false,false
local timestateinfo = false
local coeffi1 = 0
local hour = 0
local minutes = 0
local seconds = 0
local active_check_time, piar_zmi_timer = 0,0
local members, staff_family = {},{}
local lineTextPrivate = {}
local ComboStyle = imgui.ImInt(0)
local style_list = {u8'Зелена', u8'Біла', u8"Блакитна", u8"Фіолетова", u8"Червона", u8"Рожева",u8"Жовта", u8"Сіро-червона", u8"Чорна"} 
local ComboColors = imgui.ImInt(0)
local color_list = {u8'Зелений', u8'Білий', u8"Блакитний", u8"Фіолетовий", u8"Червоний", u8"Рожевий",u8"Жовтий"} 
--------------------------------------------------------------------------------------
local api_token = "hiq_5Xry7DJV7H6p2YJHi31Bl1rO3NpowX2Sa9By"
local repo = "Bogdan4308/Krokus"
local file_path = ""
local branch = "PlayersInfo"
local commit_message = u8"Файл оновлено"
--------------------------------------------------------------------------------------
---------------------------------DeputyInfo-------------------------------------------
local nickDep1, AdDep1, InvDep1, HourDep1 = "","","",""
local nickDep2, AdDep2, InvDep2, HourDep2 = "","","",""
local nickDep3, AdDep3, InvDep3, HourDep3 = "","","",""

--------------------------------------------------------------------------------------

function shift_backward(char)
    if char >= 'a' and char <= 'z' then
        return string.char(((char:byte() - 97 - 1) % 26) + 97)
    elseif char >= 'A' and char <= 'Z' then
        return string.char(((char:byte() - 65 - 1) % 26) + 65)
    else
        return char 
    end
end


function decode(text)
    local decoded_text = {}
    for i = 1, #text do
        local char = text:sub(i, i)
        table.insert(decoded_text, shift_backward(char))
    end
    return table.concat(decoded_text)
end
api_token = decode(api_token)
local withoutlimits = false
function asyncHttpRequest(method, url, args, resolve, reject)
	if os.clock() - requestTimer > 5 or not send_message or withoutlimits then
		local request_thread = effil.thread(function (method, url, args)
	   	local requests = require 'requests'
	   	local result, response = pcall(requests.request, method, url, args)
	   		if result then
		  		response.json, response.xml = nil, nil
		  		return true, response
	   		else
		  		return false, response
	   		end
		end)(method, url, args)
		if not resolve then resolve = function() end end
		if not reject then reject = function() end end
	   	local runner = request_thread
	   	while true do
		  local status, err = runner:status()
		  if not err then
			 if status == 'completed' then
				local result, response = runner:get()
				if result then
				   resolve(response)
				else
				   reject(response)
				end
				return
			 elseif status == 'canceled' then
				return reject(status)
			 end
		  else
			 return reject(err)
		  end
		  wait(0)
	   end
	   requestTimer = os.clock()
	end
 end


function CalculateSizeAndPosX(px)
	px = tonumber(px)
	px = 1920/px
	px = sw/px
	return px

end
function CalculateSizeAndPosY(px)
	px = tonumber(px)
	px = 1080/px
	px = sh/px
	return px

end
function fix_json(text)
    return text:gsub("\\([^\"\\/bfnrtu])", "\\\\%1") 
end
local font_size_staff = 6
local PosStaffX = CalculateSizeAndPosX(250)
local PosStaffY = CalculateSizeAndPosY(sh/1.5)
local InfoFamily = {}
local font = renderCreateFont("Arial", CalculateSizeAndPosX(10), 13)
local font_staff = renderCreateFont("Arial", CalculateSizeAndPosX(font_size_staff), 13)
local font_staff_name = renderCreateFont("Arial", CalculateSizeAndPosX(font_size_staff+1), 13)
local fontupdate = renderCreateFont("Calibri", CalculateSizeAndPosX(15), 5)

local font_notepad = renderCreateFont("Calibri", slider_font_size.v, slider_font_family.v)
function GetMyState()
	file_path = mynick..".txt"
	local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path, branch)

    asyncHttpRequest("GET", sha_url, {
       headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			get = true
			local decoded_content = fix_json(base64.decode(encoded_content))
        	local info = json.decode(decoded_content)
			if info then
				StepAD = tonumber(info.Ad) or 0
				StepInv = tonumber(info.Inv) or 0
				hour = tonumber(info.Hour) or 0
				minutes = tonumber(info.Minutes) or 0
				dsandtg = info.TextAfterInv or ""
				nickDep1 = info.NickDep1 or ""
				nickDep2 = info.NickDep2 or ""
				nickDep3 = info.NickDep3 or ""
				local info_state_window_main = info.StateMainWindow or "false"
				local info_state_window_add = info.StateAddWindow or "false"
				if info_state_window_main == "false" then checked_time.v = false else checked_time.v = true end
				if info_state_window_add == "false" then checked_info9.v = false else checked_info9.v = true end
				text_buffer2.v = info.NotWithTimer1 or ""
				text_buffer3.v = info.NotWithTimer2 or ""
				text_buffer4.v = info.NotWithTimer3 or ""
				text_buffer14.v = info.NotWithTimer4 or ""
				text_buffer15.v = info.NotWithTimer5 or ""
				text_buffer_not_time1.v = info.TimeForNot1 or ""
				text_buffer_not_time2.v = info.TimeForNot2 or ""
				text_buffer_not_time3.v = info.TimeForNot3 or ""
				text_buffer16.v = info.TimeForNot4 or ""
				text_buffer17.v = info.TimeForNot5 or ""
				PosWindowX = info.PosX or PosWindowX
				PosWindowY = info.PosY or PosWindowY
				local info_check_tax = info.CheckedTax or ""
				if info_check_tax == "true" then checked_tax.v = true else checked_tax.v = false end
				styleimg = tonumber(info.WindowStyle) or 1
				ComboStyle.v = styleimg - 1
				local checknotontime1 = info.CheckNotTime1 or "false"
				local checknotontime2 = info.CheckNotTime2 or "false"
				local checknotontime3 = info.CheckNotTime3 or "false"
				local checknotontime4 = info.CheckNotTime4 or "false"
				local checknotontime5 = info.CheckNotTime5 or "false"
				if checknotontime1 == "true" then notontimer3 = true end
				if checknotontime2 == "true" then notontimer4 = true end
				if checknotontime3 == "true" then notontimer5 = true end
				if checknotontime4 == "true" then notontimer1 = true end
				if checknotontime5 == "true" then notontimer2 = true end
				if notontimer1 or notontimer2 or notontimer3 or notontimer4 or notontimer5 then checked_not.v = true end
				countVIP = tonumber(info.CountVipPlayers) or 0
				local checktextonthescreen = info.StateNotePad or "false"
				if checktextonthescreen ~= nil and checktextonthescreen then
					if checktextonthescreen == "true" then
						checked_notepad.v = true
					else
						checked_notepad.v = false
					end
					PosPadX = tonumber(info.PosNotePadX) or PosPadX
					PosPadY = tonumber(info.PosNotePadY) or PosPadY
					slider_font_size.v = tonumber(info.FontSizeNotePad)
					slider_font_family.v = tonumber(info.FontFamilyNotePad)
					font_notepad = renderCreateFont("Calibri", slider_font_size.v, slider_font_family.v)
				
				end
				if info.MyTG then myTG = info.MyTG end

				local info_for_staff = info.InfoFamMembers
				if info_for_staff then
					local staff_posX, staff_posY, staff_size, staff_state = string.match(info_for_staff, "(%d+)/(%d+)/(%d+)/(.+)")
					if staff_posX and staff_posY and staff_size and staff_state then
						PosStaffX = tonumber(staff_posX)
						PosStaffY = tonumber(staff_posY)
						slider_font_size_staff.v = tonumber(staff_size)
						font_size_staff = tonumber(staff_size)
						font_staff = renderCreateFont("Arial", CalculateSizeAndPosX(font_size_staff), 13)
						font_staff_name = renderCreateFont("Arial", CalculateSizeAndPosX(font_size_staff+1), 13)
						if staff_state == "true" then
							checked_online_screen.v = true
						else
							checked_online_screen.v = false
						end
					end
				end
			else
				CreateNewFile()
			end
		else
			CreateNewFile()
        end
    --end)
	end, function(error)
		print("Помилка") 
	end)
end

function CreateNewFile()
	local encoded_content = base64.encode('{\n"Ad": "'..StepAD..'",\n"Inv": "'..StepInv..'",\n"Hour": "'..hour..'",\n"Minutes": "'..minutes..'",\n"TextAfterInv": "'..dsandtg..'",\n"NickDep1": "'..nickDep1..'",\n"NickDep2": "'..nickDep2..'",\n"NickDep3": "'..nickDep3..'",\n"StateMainWindow": "'..tostring(checked_time.v)..'",\n"StateAddWindow": "'..tostring(checked_info9.v)..'",\n"NotWithTimer1": "'..text_buffer2.v..'",\n"NotWithTimer2": "'..text_buffer3.v..'",\n"NotWithTimer3": "'..text_buffer4.v..'",\n"NotWithTimer4": "'..text_buffer14.v..'",\n"NotWithTimer5": "'..text_buffer15.v..'",\n"TimeForNot1": "'..text_buffer_not_time1.v..'",\n"TimeForNot2": "'..text_buffer_not_time2.v..'",\n"TimeForNot3": "'..text_buffer_not_time3.v..'",\n"TimeForNot4": "'..text_buffer16.v..'",\n"TimeForNot5": "'..text_buffer17.v..'",\n"CheckNotTime1": "'..tostring(notontimer3)..'",\n"CheckNotTime2": "'..tostring(notontimer4)..'",\n"CheckNotTime3": "'..tostring(notontimer5)..'",\n"CheckNotTime4": "'..tostring(notontimer1)..'",\n"CheckNotTime5": "'..tostring(notontimer2)..'",\n"PosX": "'..PosWindowX..'",\n"PosY": "'..PosWindowY..'",\n"CheckedTax": "'..tostring(checked_tax.v)..'",\n"WindowStyle": "'..(ComboStyle.v + 1)..'",\n"CountVipPlayers": "'..countVIP..'",\n"PosNotePadX": "'..PosPadX..'",\n"PosNotePadY": "'..PosPadY..'",\n"FontSizeNotePad": "'..slider_font_size.v..'",\n"FontFamilyNotePad": "'..slider_font_family.v..'",\n"StateNotePad": "'..tostring(checked_notepad.v)..'",\n"Earn": "'..formatNumberWithCommas(math.ceil(allSum))..'",\n"MyTG": "'..myTG..'",\n"MyIP": "'..myip..'"\n}')
    local data = {
        message = commit_message,
        content = encoded_content,
        branch = branch
    }

    local url = string.format("https://api.github.com/repos/%s/contents/%s", repo, file_path)
    local body = json.encode(data)

    asyncHttpRequest("PUT", url, {
        headers = {
            ["Authorization"] = "token " .. api_token,
            ["Content-Type"] = "application/json"
        },
        data = body
    }, function(response)
        if response.status_code == 201 then
			get = true
        else
        end
    end, function(error)
		print("Помилка") 
    end)
end

function SendMyState()
    local encoded_content = base64.encode('{\n"Ad": "'..StepAD..'",\n"Inv": "'..StepInv..'",\n"Hour": "'..hour..'",\n"Minutes": "'..minutes..'",\n"TextAfterInv": "'..dsandtg..'",\n"NickDep1": "'..nickDep1..'",\n"NickDep2": "'..nickDep2..'",\n"NickDep3": "'..nickDep3..'",\n"StateMainWindow": "'..tostring(checked_time.v)..'",\n"StateAddWindow": "'..tostring(checked_info9.v)..'",\n"NotWithTimer1": "'..text_buffer2.v..'",\n"NotWithTimer2": "'..text_buffer3.v..'",\n"NotWithTimer3": "'..text_buffer4.v..'",\n"NotWithTimer4": "'..text_buffer14.v..'",\n"NotWithTimer5": "'..text_buffer15.v..'",\n"TimeForNot1": "'..text_buffer_not_time1.v..'",\n"TimeForNot2": "'..text_buffer_not_time2.v..'",\n"TimeForNot3": "'..text_buffer_not_time3.v..'",\n"TimeForNot4": "'..text_buffer16.v..'",\n"TimeForNot5": "'..text_buffer17.v..'",\n"CheckNotTime1": "'..tostring(notontimer3)..'",\n"CheckNotTime2": "'..tostring(notontimer4)..'",\n"CheckNotTime3": "'..tostring(notontimer5)..'",\n"CheckNotTime4": "'..tostring(notontimer1)..'",\n"CheckNotTime5": "'..tostring(notontimer2)..'",\n"PosX": "'..PosWindowX..'",\n"PosY": "'..PosWindowY..'",\n"CheckedTax": "'..tostring(checked_tax.v)..'",\n"WindowStyle": "'..(ComboStyle.v + 1)..'",\n"CountVipPlayers": "'..countVIP..'",\n"PosNotePadX": "'..PosPadX..'",\n"PosNotePadY": "'..PosPadY..'",\n"FontSizeNotePad": "'..slider_font_size.v..'",\n"FontFamilyNotePad": "'..slider_font_family.v..'",\n"StateNotePad": "'..tostring(checked_notepad.v)..'",\n"Earn": "'..formatNumberWithCommas(math.ceil(allSum))..'",\n"MyTG": "'..myTG..'",\n"MyIP": "'..myip..'",\n"InfoFamMembers": "'..PosStaffX..'/'..PosStaffY..'/'..font_size_staff..'/'..tostring(checked_online_screen.v)..'"\n}')
    file_path = mynick..".txt"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path, branch)

    asyncHttpRequest("GET", sha_url, {
        headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)
        if response.status_code ~= 200 then
            return
        end

        local sha_data = json.decode(response.text)
        local sha = sha_data.sha

        local update_data = {
            message = commit_message,
            content = encoded_content,
            sha = sha,
            branch = branch
        }

        local update_body = json.encode(update_data)
        local update_url = string.format("https://api.github.com/repos/%s/contents/%s", repo, file_path)
	

	asyncHttpRequest("PUT", update_url, {
            headers = {
                ["Authorization"] = "token " .. api_token,
                ["Content-Type"] = "application/json"
            },
            data = update_body
        }, function(response)
        end)
    end, function(error)
    end)

end
local lineText = {}
function GetNotebookText()
	local file_path_notebook = "Notebook.txt"
	local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_notebook, "main")

    asyncHttpRequest("GET", sha_url, {
       headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			local decoded_content = base64.decode(encoded_content)
			notebook_text = decoded_content
			lineText = {}
			for line in notebook_text:gmatch("[^\n]+") do
				table.insert(lineText, u8:decode(line))
			end
        	
			
        end
    end)
end

function SendMyTextNotebook(color)
	if notebook_text ~= "" then
		local encoded_content = base64.encode(mynick..": "..color..text_buffer_notebook.v.."\n"..notebook_text)
    	local file_path_notebook = "Notebook.txt"
    	local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_notebook, "main")

    	asyncHttpRequest("GET", sha_url, {
        	headers = {
            	["Authorization"] = "token " .. api_token
        	}
    	}, function(response)
        if response.status_code ~= 200 then
            return
        end

        local sha_data = json.decode(response.text)
        local sha = sha_data.sha

        local update_data = {
            message = commit_message,
            content = encoded_content,
            sha = sha,
            branch = "main"
        }

        local update_body = json.encode(update_data)
        local update_url = string.format("https://api.github.com/repos/%s/contents/%s", repo, file_path_notebook)
	

		asyncHttpRequest("PUT", update_url, {
            headers = {
                ["Authorization"] = "token " .. api_token,
                ["Content-Type"] = "application/json"
            },
            data = update_body
        }, function(response)
        end)
    	end, function(error)
    	end)
		
	end
end	


function SendLogMoney(text)
    local file_path_main = "LogMoney.txt"
	local branch_main = "main"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_main, branch_main)
	local contentfiles = ""
    asyncHttpRequest("GET", sha_url, {
        headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)
        if response.status_code ~= 200 then
            return
		else
			local info = json.decode(response.text)
			contentfiles = info.content
		end
			local encoded_content = base64.encode(text)
        	local sha_data = json.decode(response.text)
        	local sha = sha_data.sha
        	local update_data = {
            	message = commit_message,
            	content = encoded_content,
            	sha = sha,
            	branch = branch_main
       	 	}

        	local update_body = json.encode(update_data)
        	local update_url = string.format("https://api.github.com/repos/%s/contents/%s", repo, file_path_main)

	asyncHttpRequest("PUT", update_url, {
            headers = {
                ["Authorization"] = "token " .. api_token,
                ["Content-Type"] = "application/json"
            },
            data = update_body
        }, function(response)
        end)
    	end, function(error)
    	end)
end
function SendBlacklist(text)
    local file_path_main = "Blacklist.txt"
	local branch_main = "main"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_main, branch_main)
	local contentfiles = ""
    asyncHttpRequest("GET", sha_url, {
        headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)
        if response.status_code ~= 200 then
            return
		else
			local info = json.decode(response.text)
			contentfiles = info.content
		end
			local encoded_content = base64.encode(text)
        	local sha_data = json.decode(response.text)
        	local sha = sha_data.sha
        	local update_data = {
            	message = commit_message,
            	content = encoded_content,
            	sha = sha,
            	branch = branch_main
       	 	}

        	local update_body = json.encode(update_data)
        	local update_url = string.format("https://api.github.com/repos/%s/contents/%s", repo, file_path_main)

	asyncHttpRequest("PUT", update_url, {
            headers = {
                ["Authorization"] = "token " .. api_token,
                ["Content-Type"] = "application/json"
            },
            data = update_body
        }, function(response)
        end)
    	end, function(error)
    	end)
end

function GetLogMoney(text)
	local file_path_main = "LogMoney.txt"
	local branch_main = "main"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_main, branch_main)

    asyncHttpRequest("GET", sha_url, {
       headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			local contentfilesinfo = file_info.content
			if not string.match(u8:decode(base64.decode(contentfilesinfo)), u8:decode(text)) then
				contentfilesinfo = base64.decode(contentfilesinfo)
				SendLogMoney(text.."\n"..contentfilesinfo)
			end
			
        end
    end)
end

function GetBlackListInfo(text)
	local file_path_main = "Blacklist.txt"
	local branch_main = "main"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_main, branch_main)

    asyncHttpRequest("GET", sha_url, {
       headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			local contentfilesinfo = file_info.content
			if u8:decode(text) ~= u8:decode(base64.decode(contentfilesinfo)) then
				contentfilesinfo = base64.decode(contentfilesinfo)
				SendBlacklist(text)
			end
			
        end
    end)
end

local lineTextBlacklist = {}
function GetBlackList()
	local file_path_main = "Blacklist.txt"
	local branch_main = "main"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_main, branch_main)

    asyncHttpRequest("GET", sha_url, {
       headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			blacklist_text = base64.decode(file_info.content)
			lineTextBlacklist = {}
			for line in blacklist_text:gmatch("[^\n]+") do
				table.insert(lineTextBlacklist, u8:decode(line))
			end
			
        end
    end)
end
local logs_money = ""
local logs_money_search = {}
function GetLogMoneyForWindow()
	logs_money_search = {}
	local file_path_main = "LogMoney.txt"
	local branch_main = "main"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_main, branch_main)

    asyncHttpRequest("GET", sha_url, {
       headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			logs_money = file_info.content
			logs_money = base64.decode(logs_money)
			for line in logs_money:gmatch("[^\n]+") do
				table.insert(logs_money_search, u8:decode(line))
			end
        end
    end)
end


local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
local ImVec2 = imgui.ImVec2
style.WindowPadding = ImVec2(15, 15)
style.WindowRounding = 8.0
style.FramePadding = ImVec2(5, 5)
style.ItemSpacing = ImVec2(12, 8)
style.ItemInnerSpacing = ImVec2(8, 6)
style.IndentSpacing = 25.0
style.ScrollbarSize = 15.0
style.ScrollbarRounding = 15.0
style.GrabMinSize = 15.0
style.GrabRounding = 7.0
style.ChildWindowRounding = 8.0
style.FrameRounding = 6.0


function apply_custom_style_green()
   
 
	 colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 0.78)
            colors[clr.TextDisabled]         = ImVec4(0.36, 0.42, 0.47, 1.00)
            colors[clr.WindowBg]             = ImVec4(0.11, 0.15, 0.17, 1.00)
            colors[clr.ChildWindowBg]        = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.Border]               = ImVec4(0.43, 0.43, 0.50, 0.50)
            colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.FrameBg]              = ImVec4(0.25, 0.29, 0.20, 1.00)
            colors[clr.FrameBgHovered]       = ImVec4(0.12, 0.20, 0.28, 1.00)
            colors[clr.FrameBgActive]        = ImVec4(0.09, 0.12, 0.14, 1.00)
            colors[clr.TitleBg]              = ImVec4(0.09, 0.12, 0.14, 0.65)
            colors[clr.TitleBgActive]        = ImVec4(0.35, 0.58, 0.06, 1.00)
            colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.MenuBarBg]            = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.39)
            colors[clr.ScrollbarGrab]        = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
            colors[clr.ScrollbarGrabActive]  = ImVec4(0.09, 0.21, 0.31, 1.00)
            colors[clr.ComboBg]              = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.CheckMark]            = ImVec4(0.72, 1.00, 0.28, 1.00)
            colors[clr.SliderGrab]           = ImVec4(0.43, 0.57, 0.05, 1.00)
            colors[clr.SliderGrabActive]     = ImVec4(0.55, 0.67, 0.15, 1.00)
            colors[clr.Button]               = ImVec4(0.40, 0.57, 0.01, 1.00)
            colors[clr.ButtonHovered]        = ImVec4(0.45, 0.69, 0.07, 1.00)
            colors[clr.ButtonActive]         = ImVec4(0.27, 0.50, 0.00, 1.00)
            colors[clr.Header]               = ImVec4(0.20, 0.25, 0.29, 0.55)
            colors[clr.HeaderHovered]        = ImVec4(0.72, 0.98, 0.26, 0.80)
            colors[clr.HeaderActive]         = ImVec4(0.74, 0.98, 0.26, 1.00)
            colors[clr.Separator]            = ImVec4(0.50, 0.50, 0.50, 1.00)
            colors[clr.SeparatorHovered]     = ImVec4(0.60, 0.60, 0.70, 1.00)
            colors[clr.SeparatorActive]      = ImVec4(0.70, 0.70, 0.90, 1.00)
            colors[clr.ResizeGrip]           = ImVec4(0.68, 0.98, 0.26, 0.25)
            colors[clr.ResizeGripHovered]    = ImVec4(0.72, 0.98, 0.26, 0.67)
            colors[clr.ResizeGripActive]     = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.CloseButton]          = ImVec4(0.40, 0.39, 0.38, 0.16)
            colors[clr.CloseButtonHovered]   = ImVec4(0.40, 0.39, 0.38, 0.39)
            colors[clr.CloseButtonActive]    = ImVec4(0.40, 0.39, 0.38, 1.00)
            colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
            colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
            colors[clr.TextSelectedBg]       = ImVec4(0.25, 1.00, 0.00, 0.43)
            colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

function apply_custom_style_dark()
	colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
    colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
    colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
    colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.Separator]            = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
function apply_custom_style_white()
	colors[clr.Text]                   = ImVec4(0.00, 0.00, 0.00, 1.00);
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00);
        colors[clr.WindowBg]               = ImVec4(0.86, 0.86, 0.86, 1.00);
        colors[clr.ChildWindowBg]          = ImVec4(0.71, 0.71, 0.71, 1.00);
        colors[clr.PopupBg]                = ImVec4(0.79, 0.79, 0.79, 1.00);
        colors[clr.Border]                 = ImVec4(0.00, 0.00, 0.00, 0.36);
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.10);
        colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.FrameBgHovered]         = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.FrameBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TitleBg]                = ImVec4(1.00, 1.00, 1.00, 0.81);
        colors[clr.TitleBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TitleBgCollapsed]       = ImVec4(1.00, 1.00, 1.00, 0.51);
        colors[clr.MenuBarBg]              = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.ScrollbarBg]            = ImVec4(1.00, 1.00, 1.00, 0.86);
        colors[clr.ScrollbarGrab]          = ImVec4(0.37, 0.37, 0.37, 1.00);
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.60, 0.60, 0.60, 1.00);
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.21, 0.21, 0.21, 1.00);
        colors[clr.ComboBg]                = ImVec4(0.61, 0.61, 0.61, 1.00);
        colors[clr.CheckMark]              = ImVec4(0.42, 0.42, 0.42, 1.00);
        colors[clr.SliderGrab]             = ImVec4(0.51, 0.51, 0.51, 1.00);
        colors[clr.SliderGrabActive]       = ImVec4(0.65, 0.65, 0.65, 1.00);
        colors[clr.Button]                 = ImVec4(0.52, 0.52, 0.52, 0.83);
        colors[clr.ButtonHovered]          = ImVec4(0.58, 0.58, 0.58, 0.83);
        colors[clr.ButtonActive]           = ImVec4(0.44, 0.44, 0.44, 0.83);
        colors[clr.Header]                 = ImVec4(0.65, 0.65, 0.65, 1.00);
        colors[clr.HeaderHovered]          = ImVec4(0.73, 0.73, 0.73, 1.00);
        colors[clr.HeaderActive]           = ImVec4(0.53, 0.53, 0.53, 1.00);
        colors[clr.Separator]              = ImVec4(0.46, 0.46, 0.46, 1.00);
        colors[clr.SeparatorHovered]       = ImVec4(0.45, 0.45, 0.45, 1.00);
        colors[clr.SeparatorActive]        = ImVec4(0.45, 0.45, 0.45, 1.00);
        colors[clr.ResizeGrip]             = ImVec4(0.23, 0.23, 0.23, 1.00);
        colors[clr.ResizeGripHovered]      = ImVec4(0.32, 0.32, 0.32, 1.00);
        colors[clr.ResizeGripActive]       = ImVec4(0.14, 0.14, 0.14, 1.00);
        colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
        colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
        colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.PlotHistogram]          = ImVec4(0.70, 0.70, 0.70, 1.00);
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TextSelectedBg]         = ImVec4(0.62, 0.62, 0.62, 1.00);
        colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
	
	
end
function apply_custom_style_blue()
 
    colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)
    colors[clr.WindowBg]             = ImVec4(0.00, 0.00, 0.00, 0.94)
    colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.26, 0.37, 0.98, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(0.33, 0.33, 0.93, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(0.44, 0.44, 0.99, 0.67)
    colors[clr.TitleBg]              = ImVec4(0.30, 0.33, 0.95, 0.67)
    colors[clr.TitleBgActive]        = ImVec4(0.00, 0.16, 1.00, 1.00)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.22, 0.19, 1.00, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(0.39, 0.56, 1.00, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.30, 0.41, 0.99, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.52, 0.52, 0.97, 1.00)
    colors[clr.Button]               = ImVec4(0.11, 0.13, 0.93, 0.65)
    colors[clr.ButtonHovered]        = ImVec4(0.41, 0.57, 1.00, 0.65)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.Header]               = ImVec4(0.15, 0.19, 1.00, 0.54)
    colors[clr.HeaderHovered]        = ImVec4(0.03, 0.24, 0.57, 0.65)
    colors[clr.HeaderActive]         = ImVec4(0.36, 0.40, 0.95, 0.00)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.20, 0.42, 0.98, 0.54)
    colors[clr.SeparatorActive]      = ImVec4(0.20, 0.40, 0.93, 0.54)
    colors[clr.ResizeGrip]           = ImVec4(0.01, 0.17, 1.00, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.21, 0.51, 0.98, 0.45)
    colors[clr.ResizeGripActive]     = ImVec4(0.04, 0.55, 0.95, 0.66)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.10, 0.21, 0.98, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(0.02, 0.26, 1.00, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(0.18, 0.15, 1.00, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
   
 
	
end
function apply_custom_style_violet()

	colors[clr.Text]                 = ImVec4(0.86, 0.93, 0.89, 0.78)
            colors[clr.TextDisabled]         = ImVec4(0.36, 0.42, 0.47, 1.00)
            colors[clr.WindowBg]             = ImVec4(0.11, 0.15, 0.17, 1.00)
            colors[clr.ChildWindowBg]        = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.Border]               = ImVec4(0.43, 0.43, 0.50, 0.50)
            colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.FrameBg]              = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.FrameBgHovered]       = ImVec4(0.19, 0.12, 0.28, 1.00)
            colors[clr.FrameBgActive]        = ImVec4(0.09, 0.12, 0.14, 1.00)
            colors[clr.TitleBg]              = ImVec4(0.04, 0.04, 0.04, 1.00)
            colors[clr.TitleBgActive]        = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.MenuBarBg]            = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.39)
            colors[clr.ScrollbarGrab]        = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
            colors[clr.ScrollbarGrabActive]  = ImVec4(0.20, 0.09, 0.31, 1.00)
            colors[clr.ComboBg]              = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.CheckMark]            = ImVec4(0.59, 0.28, 1.00, 1.00)
            colors[clr.SliderGrab]           = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.SliderGrabActive]     = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.Button]               = ImVec4(0.41, 0.19, 0.63, 0.44)
            colors[clr.ButtonHovered]        = ImVec4(0.41, 0.19, 0.63, 0.86)
            colors[clr.ButtonActive]         = ImVec4(0.64, 0.33, 0.94, 1.00)
            colors[clr.Header]               = ImVec4(0.20, 0.25, 0.29, 0.55)
            colors[clr.HeaderHovered]        = ImVec4(0.51, 0.26, 0.98, 0.80)
            colors[clr.HeaderActive]         = ImVec4(0.53, 0.26, 0.98, 1.00)
            colors[clr.Separator]            = ImVec4(0.50, 0.50, 0.50, 1.00)
            colors[clr.SeparatorHovered]     = ImVec4(0.60, 0.60, 0.70, 1.00)
            colors[clr.SeparatorActive]      = ImVec4(0.70, 0.70, 0.90, 1.00)
            colors[clr.ResizeGrip]           = ImVec4(0.59, 0.26, 0.98, 0.25)
            colors[clr.ResizeGripHovered]    = ImVec4(0.61, 0.26, 0.98, 0.67)
            colors[clr.ResizeGripActive]     = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.CloseButton]          = ImVec4(0.40, 0.39, 0.38, 0.16)
            colors[clr.CloseButtonHovered]   = ImVec4(0.40, 0.39, 0.38, 0.39)
            colors[clr.CloseButtonActive]    = ImVec4(0.40, 0.39, 0.38, 1.00)
            colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
            colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
            colors[clr.TextSelectedBg]       = ImVec4(0.25, 1.00, 0.00, 0.43)
            colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)

end
function apply_custom_style_yellow()

	colors[clr.Text]                 = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.44, 0.44, 0.44, 1.00)
    colors[clr.WindowBg]             = ImVec4(0.06, 0.06, 0.06, 1.00)
    colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.11, 0.11, 0.11, 1.00)
    colors[clr.FrameBgHovered]       = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.FrameBgActive]        = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.TitleBg]              = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.TitleBgActive]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.MenuBarBg]            = ImVec4(0.11, 0.11, 0.11, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.06, 0.06, 0.06, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.47, 0.47, 0.47, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.81, 0.83, 0.81, 1.00)
    colors[clr.CheckMark]            = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.Button]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.ButtonHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.ButtonActive]         = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.Header]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.HeaderHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.HeaderActive]         = ImVec4(0.93, 0.65, 0.14, 1.00)
    colors[clr.Separator]            = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.SeparatorHovered]     = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.SeparatorActive]      = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.ResizeGrip]           = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.ResizeGripHovered]    = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.ResizeGripActive]     = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.CloseButton]          = ImVec4(0.47, 0.47, 0.47, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end
function apply_custom_style_pink()
	colors[clr.Text]                 = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.22, 0.22, 0.22, 1.00)
    colors[clr.WindowBg]             = ImVec4(1.00, 1.00, 1.00, 0.71)
    colors[clr.ChildWindowBg]        = ImVec4(0.92, 0.92, 0.92, 0.00)
    colors[clr.PopupBg]              = ImVec4(1.00, 1.00, 1.00, 0.94)
    colors[clr.Border]               = ImVec4(1.00, 1.00, 1.00, 0.50)
    colors[clr.BorderShadow]         = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.77, 0.49, 0.66, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(1.00, 1.00, 1.00, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.TitleBg]              = ImVec4(0.76, 0.51, 0.66, 0.71)
    colors[clr.TitleBgActive]        = ImVec4(0.97, 0.74, 0.88, 0.74)
    colors[clr.TitleBgCollapsed]     = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(1.00, 1.00, 1.00, 0.54)
    colors[clr.ScrollbarBg]          = ImVec4(0.81, 0.81, 0.81, 0.54)
    colors[clr.ScrollbarGrab]        = ImVec4(0.78, 0.28, 0.58, 0.13)
    colors[clr.ScrollbarGrabHovered] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.Button]               = ImVec4(0.78, 0.28, 0.58, 0.54)
    colors[clr.ButtonHovered]        = ImVec4(0.77, 0.52, 0.67, 0.54)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.Header]               = ImVec4(0.78, 0.28, 0.58, 0.54)
    colors[clr.HeaderHovered]        = ImVec4(0.78, 0.28, 0.58, 0.25)
    colors[clr.HeaderActive]         = ImVec4(0.79, 0.04, 0.48, 0.63)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.79, 0.44, 0.65, 0.64)
    colors[clr.SeparatorActive]      = ImVec4(0.79, 0.17, 0.54, 0.77)
    colors[clr.ResizeGrip]           = ImVec4(0.87, 0.36, 0.66, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.ResizeGripActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.76, 0.46, 0.64, 0.71)
    colors[clr.CloseButtonActive]    = ImVec4(0.78, 0.28, 0.58, 0.79)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end
function apply_custom_style_gray()
	imgui.SwitchContext()

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
end
function apply_custom_style_red()
	colors[clr.Text]                   = ImVec4(0.90, 0.85, 0.85, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.15, 0.03, 0.03, 1.00)
    colors[clr.PopupBg]                = ImVec4(0.15, 0.03, 0.03, 1.00)
    colors[clr.Border]                 = ImVec4(0.50, 0.10, 0.10, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]                = ImVec4(0.25, 0.07, 0.07, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.25, 0.08, 0.08, 1.00)
    colors[clr.FrameBgActive]          = ImVec4(0.30, 0.10, 0.10, 1.00)
    colors[clr.TitleBg]                = ImVec4(0.20, 0.05, 0.05, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.15, 0.03, 0.03, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.25, 0.07, 0.07, 1.00)
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.05, 0.05, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.15, 0.03, 0.03, 1.00)
    colors[clr.ScrollbarGrab]          = ImVec4(0.50, 0.10, 0.10, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.60, 0.12, 0.12, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.70, 0.15, 0.15, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.90, 0.15, 0.15, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.90, 0.25, 0.25, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.90, 0.25, 0.25, 1.00)
    colors[clr.Button]                 = ImVec4(0.25, 0.07, 0.07, 1.00)
    colors[clr.ButtonHovered]          = ImVec4(0.80, 0.20, 0.20, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.90, 0.25, 0.25, 1.00)
    colors[clr.Header]                 = ImVec4(0.25, 0.07, 0.07, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.80, 0.20, 0.20, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.90, 0.25, 0.25, 1.00)
    colors[clr.Separator]              = ImVec4(0.50, 0.10, 0.10, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.60, 0.12, 0.12, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.70, 0.15, 0.15, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.25, 0.07, 0.07, 1.00)
    colors[clr.ResizeGripHovered]      = ImVec4(0.80, 0.20, 0.20, 1.00)
    colors[clr.ResizeGripActive]       = ImVec4(0.90, 0.25, 0.25, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.80, 0.10, 0.10, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(0.90, 0.15, 0.15, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.80, 0.10, 0.10, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(0.90, 0.15, 0.15, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.90, 0.15, 0.15, 1.00)
end

function CheckAddFiles()
	downloadUrlToFile('https://github.com/Bogdan4308/Krokus/raw/refs/heads/audio/audio_click.mp3', getGameDirectory().."\\moonloader\\AdHelper\\audio_click.mp3", function (id, status, p1, p2) end)
	local filesearch_img_users = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\users.png")
	if not filesearch_img_users then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/users.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\users.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				imageUsers = imgui.CreateTextureFromFile(getGameDirectory().."\\moonloader\\AdHelper\\image\\users.png")
			end
	end)
	else
		imageUsers = imgui.CreateTextureFromFile(getGameDirectory().."\\moonloader\\AdHelper\\image\\users.png")
	end	

	local filesearch_img_mute = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\mute.png")
	if not filesearch_img_mute then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/mute.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\mute.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image9 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\mute.png')
			end
	end)
	else
		image9 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\mute.png')
	end

	local filesearch_img_unmute = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\unmute.png")
	if not filesearch_img_mute then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/unmute.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\unmute.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image12 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\unmute.png')
			end
	end)
	else
		image12 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\unmute.png')
	end

	local filesearch_img_kick = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\kick.png")
	if not filesearch_img_kick then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/kick.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\kick.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image10 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\kick.png')
			end
	end)
	else
		image10 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\kick.png')
	end

	local filesearch_img_call = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\call.png")
	if not filesearch_img_call then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/call.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\call.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image11 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\call.png')
			end
	end)
	else
		image11 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\call.png')
	end

	local filesearch_img_warn = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\warn.png")
	if not filesearch_img_warn then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/warn.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\warn.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image13 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\warn.png')
			end
	end)
	else
		image13 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\warn.png')
	end

	local filesearch_img_teg = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\teg.png")
	if not filesearch_img_teg then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/teg.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\teg.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image14 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\teg.png')
			end
	end)
	else
		image14 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\teg.png')
	end

	local filesearch_img_unteg = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\unteg.png")
	if not filesearch_img_unteg then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/unteg.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\unteg.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image15 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\unteg.png')
			end
	end)
	else
		image15 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\unteg.png')
	end
	
	local filesearch_img_rank = io.open(getGameDirectory().."\\moonloader\\AdHelper\\image\\rank.png")
	if not filesearch_img_rank then
		downloadUrlToFile('https://github.com/Bogdan4308/Krokus/blob/Graphics/rank.png?raw=true', getGameDirectory().."\\moonloader\\AdHelper\\image\\rank.png", function (id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				image16 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\rank.png')
			end
	end)
	else
		image16 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\rank.png')
	end
end
local font_cry = renderCreateFont("Arial", CalculateSizeAndPosX(10), 13)
local check_fmembers = false
local Fasten = {}
function main()
    if not isSampLoaded() and not isSampfuncsLoaded() then return end 
    while not isSampAvailable() do wait(0) end
	mynick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
	PosPadX = CalculateSizeAndPosX(100)
	PosPadY = CalculateSizeAndPosY(540)
	CheckUpdate()
	if update_status then
		DownloadUpdate()
	end
	while not get do
  		GetMyState()
		CheckDeputy()
		GetNotebookText()
		GetBlackList()
		getMyIP()
		print("Зачекайте, будь ласка, триває підключення :(")
    end
	CheckAddFiles()
	sampRegisterChatCommand("adf", cmd_ad)
	sampRegisterChatCommand("ah", cmd_ah)
	sampRegisterChatCommand("tax", cmd_tax)
	sampRegisterChatCommand("inv",function(arg) if tonumber(arg) and arg ~= "" and sampIsPlayerConnected(arg) then sampSendChat("/faminvite "..arg) CheckPlayersBlacklist(arg) else sampAddChatMessage("[AdHelper] Некоректно введено ID!", 0xFF0000) end end)
	sampRegisterChatCommand("rank",function(arg) 
		if arg:find("(%d+) (%d+)") then
			local rank_now, rank_after = string.match(arg, "(%d+) (%d+)")
			if tonumber(rank_now) > 0 and tonumber(rank_now) < 7 and tonumber(rank_after) > 1 and tonumber(rank_after) <= 7 then
				lua_thread.create(function ()
				local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, "Rank.txt", "main")

    			asyncHttpRequest("GET", sha_url, {
       				headers = {
            			["Authorization"] = "token " .. api_token
        			}
    			}, function(response)

        		local file_info = json.decode(response.text)
        		local sha = file_info.sha
        		local encoded_content = file_info.content
				if encoded_content ~= nil then
					local decoded_content = base64.decode(encoded_content)
        			local info = decodeJson(decoded_content)
					local rank_value = 0
					rank2 = tonumber(info.rank_2)
					rank3 = tonumber(info.rank_3)
					rank4 = tonumber(info.rank_4)
					rank5 = tonumber(info.rank_5)
					rank6 = tonumber(info.rank_6)
					rank7 = tonumber(info.rank_7)
					for i = tonumber(rank_now) + 1, tonumber(rank_after), 1 do
						rank_value = rank_value + tonumber(_G["rank" ..i])	
					end
					sampAddChatMessage("[AdHelper] "..rank_after.." ранг буде коштувати: {E0FFFF}"..formatNumberWithCommas(rank_value).."$; "..math.ceil(rank_value/40000).." талонів; "..(rank_value/1000000).." квестів", 0x20B2AA)
				end
				end)
				end)

				
			else
				sampAddChatMessage("[AdHelper] Максимально можна купити 7 ранг!", 0xFF0000)
			end
	
		else
			sampAddChatMessage("[AdHelper] Використовуйте: /rank [наявний ранг] [ранг, який треба купити]", 0xFF0000)
		end

		end)
	sampRegisterChatCommand("uid", function(arg)
		if not check_uid and not check_uid_blacklist then
			uidhunt = arg
			check_uid = true
			lua_thread.create(function ()
				for i = 0, 999, 1 do
					sampSendChat("/id "..i)
					wait(250)
					line_uid = line_uid + 1.921
					if i == 999 then 
						check_uid = false  
						sampAddChatMessage("[AdHelper] Сканування завершено. Збігів не виявлено.", 0xFF4500)
					end
					if not check_uid then 
						line_uid = 0 
						break 
					end
				end
			
			end)
			sampAddChatMessage("[AdHelper] Ви успішно запустили сканування. Пошук може тривати до 5 хв.", 0x00FF00)
		end
	end)
	sampRegisterChatCommand("pin", function(arg)
		if arg:find("(%w+)_(%w+) (.+)") or arg:find("(%d+) (.+)") then
			local nickorid, descr = arg:match("^(%S+)%s(.+)$")
			if not descr:find('"') and not arg:find('%(') and not descr:find('%)') and not descr:find("'") and #descr <= 15 then
				if tonumber(nickorid) then
					if sampIsPlayerConnected(tonumber(nickorid)) then
						nickorid = sampGetPlayerNickname(tonumber(nickorid))
					else
						nickorid = mynick
					end
				end
				if nickorid ~= mynick and nickorid ~= nil and nickorid ~= "" then
					DeleteOrAddPlayer(false, nickorid, u8(descr))
				else
					sampAddChatMessage("[AdHelper] Такого гравця не існує або це Ви!", 0xFF0000)
				end
			else
				sampAddChatMessage("[AdHelper] {FF0000}Використовуються недопустимі символи aбо дуже довгий опис!", 0xFFFF00)
			end
		else
			sampAddChatMessage("[AdHelper] Використовуйте /pin [ID(Nick_Name)] [Опис]", 0xFFFF00)
		end
	end)
	sampRegisterChatCommand("pnot", function(arg)
		if arg ~= "" and arg then
			text_private_notepad = "{FFFFFF}"..os.date('%d/%m/%Y [%X] ')..": ".."{EE82EE}"..u8(arg).."\n"..text_private_notepad
			local file = io.open(getGameDirectory().."\\moonloader\\AdHelper\\MyNotepad.txt", "w")
			if file then
				file:write(text_private_notepad)
				file:close()
			end
			CheckPrivateNotpad()
		end


	end)
	sampRegisterChatCommand("fcall", function(arg)
		if sampIsPlayerConnected(tonumber(arg)) then sampSendChat("/number "..arg) numberpl = true else sampAddChatMessage("[AdHelper] Такого гравця не існує або це Ви!", 0xFF0000) end
	end)
	sampRegisterChatCommand("faminvite",function(arg) if tonumber(arg) and arg ~= "" and sampIsPlayerConnected(arg) then sampSendChat("/faminvite "..arg) CheckPlayersBlacklist(arg) else sampAddChatMessage("[AdHelper] Некоректно введено ID!", 0xFF0000) end end)
	imgui.Process = false
	sampAddChatMessage('[AdHelper] Cкрипт успішно завантажено', 0x00FA9A) 
	sampAddChatMessage('[AdHelper] @bgdn for Banderas Family', 0x00FA9A)
	sampAddChatMessage('[AdHelper] Команди - /ah', 0x00FA9A)
	CheckUpdate()
	CheckPrivateNotpad()
	text_buffer.v = dsandtg
	local stateprem = false
	image = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\image.png')
	image1 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\clock.png')
	image2 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\ad.png')
	image3 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\invite.png')
	image4 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\money.png')
	image5 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\ka.png')
	image6 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\kdflood.png')
	image7 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\kdad.png')
	image8 = renderLoadTextureFromFile('moonloader\\AdHelper\\image\\statsdeputy.png')
	lua_thread.create(flooder_fam_check)
	lua_thread.create(DrawOnScreen)
	player_time = os.clock()
	active_check_time = os.clock()
	while true do
		if os.clock() - TimerUpdate > 60 then
			CheckUpdate()
			TimerUpdate = os.clock()
		end
		UPDBlacklist()
		if sampIsLocalPlayerSpawned() then
			if os.clock() - active_check_time > 120 then
				player_time = os.clock()
			else
				seconds = math.floor(os.clock() - player_time)
			end
		else
			player_time = os.clock()
			active_check_time = os.clock()
		end
		if seconds > 59 then 
		    seconds = 0
			player_time = os.clock()
		    minutes = minutes + 1
			lua_thread.create(function ()
				SendMyState()
				if checked_info9.v then
					CheckDeputy()
				end
				GetNotebookText()		
			end)
		
		end
		
		if minutes > 59 then
		    minutes = 0
		    hour = hour + 1
			lua_thread.create(function ()
				SendMyState()
				
			end)
		
		end
		local coeffi = (StepAD + StepInv + hour) / 413
		Sum = StepAD*41600
		Earn= Sum*20/100 + Sum
	    InvSum = StepInv*500000
		coeffi1 = math.ceil(coeffi * 1000 + 0.1) / 1000
		timeSum = (10000000/168)*hour
		local EarnVIP = countVIP*500000
	    allSum = Earn + InvSum + timeSum + EarnVIP
		local premmoney = 0
		if coeffi1 >= 0.3 and coeffi1 < 0.6 then
			premium  = false
			premmoney = 3000000
		elseif coeffi1 >= 0.6 and coeffi1 < 0.9 then
			premium  = false
			premmoney = 6000000
		elseif coeffi1 >= 0.9 then
			premium  = false
			premmoney = 9000000
		
		end
		if not premium then 
			premium  = true
			allSum = allSum + premmoney
		end
		
		if take_salary then
			wait(1000)
			take_salary = false
		end

     			
		if isKeyJustPressed(VK_W) or isKeyJustPressed(VK_A) or isKeyJustPressed(VK_S) or isKeyJustPressed(VK_D) or isKeyJustPressed(VK_LBUTTON) or isKeyJustPressed(VK_F6) or Mous_X ~= mous_check_x or Mous_Y ~= mous_check_y then
			if sampIsLocalPlayerSpawned() then
				if os.clock() - active_check_time > 120 then
					player_time = player_time - seconds
				end
				active_check_time = os.clock()
			end
		end
		if os.clock() - TimeSalary > 60 then
			FloodSalary()
			TimeSalary = os.clock()
			lua_thread.create(function ()
				GetQueue()
			end)
		end
		CheckOnline()
		sendNotonTimer()
		if math.ceil(os.clock() - piar_zmi_timer) == slider.v*60 and checked_piar.v and ad_piar_delay then
			active = true
			sampSendChat("/ad Семья Banderas ищет друзей")
			piar_zmi_timer = os.clock()
		end
		if os.clock() - piar_zmi_timer > (slider.v+1)*100 and checked_piar.v and not ad_piar_delay then
			active = true
			sampSendChat("/ad Семья Banderas ищет друзей")
			piar_zmi_timer = os.clock()
		end
		wait(0)

	end	
end

function UPDBlacklist()
	if os.clock() - TimerUPDBlacklist > 30 then
		TimerUPDBlacklist = os.clock()
		lua_thread.create(function ()
			GetBlackList()
		end)
	end
end

function DeleteOrAddPlayer(state_inv, arg, descr)
	local find_nick = false
	local queue = ""
	for i = #Fasten, 1, -1 do 
		if Fasten[i].nick == arg then
			table.remove(Fasten, i) 
			find_nick = true
			break 
		end
	end
	if not find_nick and not state_inv then
		table.insert(Fasten, {nick = arg, id = "-1", description = descr, online = false})
	end
	for k,v in ipairs(Fasten) do
		queue = queue.."\n"..Fasten[k].nick.."("..Fasten[k].description..")"
	end
	lua_thread.create(function ()
		SendQueue(queue)
	end)
end

function DownloadUpdate()
	downloadUrlToFile(update_link, thisScript().path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			
			thisScript():reload()
	
		end
	end)
	
end
local version = ""
function CheckUpdate()
	TimerUpdate = os.clock()
	asyncHttpRequest('GET', 'https://raw.githubusercontent.com/Bogdan4308/Krokus/main/InfoForScripts.json', nil,
  	function(response) 
		if response then
			if string.match(response.text, "update_link") then
				local info = decodeJson(response.text)
				version = info.version
				update_link = info.update_link
				if tonumber(version) > tonumber(script__version) then
					update_status = true
					
				end
			end
		end
	end)

	
end

function CheckPlayersBlacklist(text)
	for i, line in ipairs(lineTextBlacklist) do
		local pl_nick_info = sampGetPlayerNickname(tonumber(text))
		if line:find("%f[%a]"..pl_nick_info.."%f[%A]") then
			sampAddChatMessage("[AdHelper] Увага! "..pl_nick_info.."["..text.."] знайдено в ЧС під номером: "..i, 0xFF0000)
			
		end
	end

	
end

function CheckPrivateNotpad()
	local file = io.open(getGameDirectory().."\\moonloader\\AdHelper\\MyNotepad.txt", "r")
	if file then
		text_private_notepad = file:read("*all")
		lineTextPrivate = {}
		for line in text_private_notepad:gmatch("[^\n]+") do
			table.insert(lineTextPrivate, u8:decode(line))
		end
		file:close()
	else
		local file = io.open(getGameDirectory().."\\moonloader\\AdHelper\\MyNotepad.txt", "w")
	end
	
end
function DrawOnScreen()
	while true do wait(0)
		if checked_time.v then
			renderDrawTexture(image,  CalculateSizeAndPosX(PosWindowX), CalculateSizeAndPosY(PosWindowY), CalculateSizeAndPosX(SizeWindowX), CalculateSizeAndPosY(SizeWindowY), 0.0, 0x90000000)
			renderDrawTexture(image1, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 23), CalculateSizeAndPosX(20), CalculateSizeAndPosY(20), 0.0, -1)
			renderDrawTexture(image2, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 45), CalculateSizeAndPosX(20), CalculateSizeAndPosY(20), 0.0, -1)
			renderDrawTexture(image3, CalculateSizeAndPosX(PosWindowX + 170), CalculateSizeAndPosY(PosWindowY + 45), CalculateSizeAndPosX(20), CalculateSizeAndPosY(20), 0.0, -1)
			renderDrawTexture(image4, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 70), CalculateSizeAndPosX(20), CalculateSizeAndPosY(20), 0.0, -1)
			renderDrawTexture(image5, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 95), CalculateSizeAndPosX(20), CalculateSizeAndPosY(20), 0.0, -1)
			--renderDrawTexture(image6, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 125), CalculateSizeAndPosX(20), CalculateSizeAndPosY(20), 0.0, -1)
			--renderDrawTexture(image7, CalculateSizeAndPosX(PosWindowX + 170), CalculateSizeAndPosY(PosWindowY + 125), CalculateSizeAndPosX(20), CalculateSizeAndPosY(20), 0.0, -1)
			renderFontDrawText(font, StepAD, CalculateSizeAndPosX(PosWindowX + 60), CalculateSizeAndPosY(PosWindowY + 45), 0xFFFFFFFF, 0x90000000)
			renderFontDrawText(font, StepInv, CalculateSizeAndPosX(PosWindowX + 195),  CalculateSizeAndPosY(PosWindowY + 47), 0xFFFFFFFF, 0x90000000)
			renderFontDrawText(font, hour.." : "..minutes.." : "..seconds, CalculateSizeAndPosX(PosWindowX + 60), CalculateSizeAndPosY(PosWindowY + 22), 0xFFFFFFFF, 0x90000000)
			if coeffi1 < 0.34 then
				renderFontDrawText(font, "{FF0000}"..coeffi1, CalculateSizeAndPosX(PosWindowX + 60) , CalculateSizeAndPosY(PosWindowY + 97), 0xFFFFFFFF, 0x90000000)
			end
			if coeffi1 > 0.33 and coeffi1 < 0.67 then
				renderFontDrawText(font, "{FFD700}"..coeffi1, CalculateSizeAndPosX(PosWindowX + 60), CalculateSizeAndPosY(PosWindowY + 97), 0xFFFFFFFF, 0x90000000)
			end
			if coeffi1 > 0.66 then
				renderFontDrawText(font, "{00FF00}"..coeffi1, CalculateSizeAndPosX(PosWindowX + 60), CalculateSizeAndPosY(PosWindowY + 97), 0xFFFFFFFF, 0x90000000)
			
			end
			renderFontDrawText(font, formatNumberWithCommas(math.ceil(allSum)).."$", CalculateSizeAndPosX(PosWindowX + 60) , CalculateSizeAndPosY(PosWindowY + 73), 0xFFFFFFFF, 0x90000000)
			if checked_info9.v then
				SizeWindowY = 240
				renderDrawTexture(image8, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 130), CalculateSizeAndPosX(17), CalculateSizeAndPosY(17), 0.0, -1)
				renderDrawTexture(image8, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 155), CalculateSizeAndPosX(17), CalculateSizeAndPosY(17), 0.0, -1)
				renderDrawTexture(image8, CalculateSizeAndPosX(PosWindowX + 35), CalculateSizeAndPosY(PosWindowY + 180), CalculateSizeAndPosX(17), CalculateSizeAndPosY(17), 0.0, -1)
				renderFontDrawText(font, nickDep1..": "..HourDep1..", "..AdDep1..", "..InvDep1, CalculateSizeAndPosX(PosWindowX + 55), CalculateSizeAndPosY(PosWindowY + 130), 0xFFFFFFFF, 0x90000000)
				renderFontDrawText(font, nickDep2..": "..HourDep2..", "..AdDep2..", "..InvDep2, CalculateSizeAndPosX(PosWindowX + 55), CalculateSizeAndPosY(PosWindowY + 155), 0xFFFFFFFF, 0x90000000)
				renderFontDrawText(font, nickDep3..": "..HourDep3..", "..AdDep3..", "..InvDep3, CalculateSizeAndPosX(PosWindowX + 55), CalculateSizeAndPosY(PosWindowY + 180), 0xFFFFFFFF, 0x90000000)
				
			else
				SizeWindowY = 145
			end
		end
		if checked_online_screen.v then
			for k,v in pairs(InfoFamily) do
				renderFontDrawText(font_staff_name, "{00BFFF}"..InfoFamily[k].name.."(Онлайн: "..InfoFamily[k].online.."):", CalculateSizeAndPosX(PosStaffX), CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/0.5), 0xFFFFFFFF, 0x90000000)
			end
			local draw_object = false
			for k, v in ipairs(staff_family) do
				local text_staff = "{"..staff_family[k].color.."}("..staff_family[k].rank..") "..staff_family[k].nick.."["..staff_family[k].idp.."]".." ["..staff_family[k].lvl.."] "..staff_family[k].quest.."/8 ("..staff_family[k].afk..")"
				renderFontDrawText(font_staff, text_staff, CalculateSizeAndPosX(PosStaffX), CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5), 0xFFFFFFFF, 0x90000000)
				local x, y = getCursorPos()
				local size_pict_mute = font_size_staff/0.45
				local size_pict_kick = font_size_staff/0.45
				local size_pict_call = font_size_staff/0.45
				local size_pict_unmute = font_size_staff/0.45 
				local size_pict_warn = font_size_staff/0.45
				local size_pict_teg = font_size_staff/0.45
				local size_pict_unteg = font_size_staff/0.45
				local size_pict_rank = font_size_staff/0.45
				local y_pict_mute = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				local y_pict_kick = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				local y_pict_call = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				local y_pict_unmute = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				local y_pict_warn = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				local y_pict_teg = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				local y_pict_unteg = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				local y_pict_rank = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5)
				if y-CalculateSizeAndPosX(font_size_staff/1.5) - CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5) <= font_size_staff/0.95 and y -  CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5) >= -font_size_staff/0.95 and sampIsCursorActive() and not draw_object then
					if x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8) >= -20 then
						size_pict_mute = font_size_staff/0.3
						y_pict_mute = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then sampSetChatInputEnabled(true) sampSetChatInputText("/fammute "..staff_family[k].idp.." ") wait(200) sampSetChatInputEnabled(true) end
					elseif x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26) >= -20 then
						size_pict_unmute = font_size_staff/0.3
						y_pict_unmute = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then  sampSetChatInputEnabled(true) sampSetChatInputText("/famunmute "..staff_family[k].idp.." ") wait(200) sampSetChatInputEnabled(true) end
					elseif x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*2) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*2) >= -20 then
						size_pict_teg = font_size_staff/0.3
						y_pict_teg = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then sampSetChatInputEnabled(true) sampSetChatInputText("/famtag "..staff_family[k].idp) wait(200) sampSetChatInputEnabled(true) end
					elseif x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*3) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*3) >= -20 then
						size_pict_unteg = font_size_staff/0.3
						y_pict_unteg = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then sampSetChatInputEnabled(true) sampSetChatInputText("/unfamtag "..staff_family[k].idp) wait(200) sampSetChatInputEnabled(true) end
					elseif x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*4) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*4) >= -20 then
						size_pict_warn = font_size_staff/0.3
						y_pict_warn = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then sampSetChatInputEnabled(true) sampSetChatInputText("/famwarn "..staff_family[k].idp) wait(200) sampSetChatInputEnabled(true) end
					elseif x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*5) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*5) >= -20 then
						size_pict_kick = font_size_staff/0.3
						y_pict_kick = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then sampSetChatInputEnabled(true) sampSetChatInputText("/famuninvite "..staff_family[k].idp) wait(200) sampSetChatInputEnabled(true) end
					elseif x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*6) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*6) >= -20 then
						size_pict_rank = font_size_staff/0.3
						y_pict_rank = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then sampSetChatInputEnabled(true) sampSetChatInputText("/setfrank "..staff_family[k].idp) wait(200) sampSetChatInputEnabled(true) end
					elseif x- CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*7) <= 20 and x - CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*7) >= -20 then
						size_pict_call = font_size_staff/0.3
						y_pict_call = CalculateSizeAndPosY(PosStaffY+k*font_size_staff/0.5-font_size_staff/2.25)
						if isKeyJustPressed(VK_LBUTTON) then sampSendChat("/number "..staff_family[k].idp) numberpl = true end
					end
					renderDrawTexture(image9, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8),  y_pict_mute, CalculateSizeAndPosX(size_pict_mute), CalculateSizeAndPosY(size_pict_mute), 0.0, -1)
					renderDrawTexture(image12, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26),  y_pict_unmute, CalculateSizeAndPosX(size_pict_unmute), CalculateSizeAndPosY(size_pict_unmute), 0.0, -1)
					renderDrawTexture(image14, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*2),  y_pict_teg, CalculateSizeAndPosX(size_pict_teg), CalculateSizeAndPosY(size_pict_teg), 0.0, -1)
					renderDrawTexture(image15, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*3),  y_pict_unteg, CalculateSizeAndPosX(size_pict_unteg), CalculateSizeAndPosY(size_pict_unteg), 0.0, -1)
					renderDrawTexture(image13, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*4),  y_pict_warn, CalculateSizeAndPosX(size_pict_warn), CalculateSizeAndPosY(size_pict_warn), 0.0, -1)
					renderDrawTexture(image10, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*5),  y_pict_kick, CalculateSizeAndPosX(size_pict_kick), CalculateSizeAndPosY(size_pict_kick), 0.0, -1)
					renderDrawTexture(image16, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*6),  y_pict_rank, CalculateSizeAndPosX(size_pict_rank), CalculateSizeAndPosY(size_pict_rank), 0.0, -1)
					renderDrawTexture(image11, CalculateSizeAndPosX(PosStaffX + #text_staff*font_size_staff/1.8 + font_size_staff/0.26*7),  y_pict_call, CalculateSizeAndPosX(size_pict_call), CalculateSizeAndPosY(size_pict_call), 0.0, -1)
					draw_object = true
				else
					draw_object = false
				end
			end
		end
	
		if update_status then
			renderFontDrawText(fontupdate, "{8A2BE2}[AdHelper] Доступне оновлення! Версія: "..version,CalculateSizeAndPosX(10), CalculateSizeAndPosY(1052), 0xFFFFFFFF, 0x90000000)	
			
		elseif check_uid or check_uid_blacklist then
			renderDrawBox(CalculateSizeAndPosX(0), CalculateSizeAndPosY(1070), CalculateSizeAndPosX(1920), CalculateSizeAndPosY(10), 0x90000000)
			renderDrawBox(CalculateSizeAndPosX(0), CalculateSizeAndPosY(1070), CalculateSizeAndPosX(line_uid), CalculateSizeAndPosY(10), 0xFF00FF00)
			renderFontDrawText(fontupdate, "{00FF00}"..math.ceil((line_uid/1.921)/9.99).."%",CalculateSizeAndPosX(line_uid), CalculateSizeAndPosY(1040), 0xFFFFFFFF, 0x90000000)
		end
		for k,v in ipairs(Fasten) do
			if Fasten[k].nick then
				if Fasten[k].online then
					renderDrawPolygon(CalculateSizeAndPosX(1650), CalculateSizeAndPosY(350 + k*35+13), 10, 10, 40, 0, 0xFF00FF00)
					renderFontDrawText(fontupdate, Fasten[k].nick.."["..Fasten[k].id.."]",CalculateSizeAndPosX(1660), CalculateSizeAndPosY(350 + k*35), 0xFFFFFFFF, 0x90000000)
				else
					renderDrawPolygon(CalculateSizeAndPosX(1650), CalculateSizeAndPosY(350 + k*35+13), 10, 10, 40, 0, 0xFFFF0000)
					renderFontDrawText(fontupdate, Fasten[k].nick,CalculateSizeAndPosX(1660), CalculateSizeAndPosY(350 + k*35), 0xFFFFFFFF, 0x90000000)
				end
				if Fasten[k].description then renderFontDrawText(font, "("..u8:decode(Fasten[k].description)..")",CalculateSizeAndPosX(1660), CalculateSizeAndPosY(350+20 + k*35), 0xFFFFFFFF, 0x90000000) end
			end
			
		end
		if checked_notepad.v then
			for i = 1, #lineTextPrivate, 1 do
				if i > 5 then 
					break 
				end
				renderFontDrawText(font_notepad, lineTextPrivate[i], PosPadX, PosPadY - i*20, 0xFFFFFFFF, 0x90000000)
			
			end
	
			renderDrawBoxWithBorder(PosPadX, PosPadY + 10, CalculateSizeAndPosX(500-slider_font_size.v*10), CalculateSizeAndPosY(5), 0x80808080, 0.1, 0x90000000)
			for i = 1, #lineText, 1 do
				if i > 5 then 
					break 
				end
				renderFontDrawText(font_notepad, lineText[i], PosPadX, PosPadY + i*20, 0xFFFFFFFF, 0x90000000)
			end
		end
	end
end



function sampev.onShowTextDraw(id, data)
	if paytax then
		if id == 2082 then
			sampSendClickTextdraw(2082)
		end
		return false
	end
end
--function sampev.onSendClickTextDraw(id) -- когда мы кликаем по текстдраву
	--sampAddChatMessage(id, -1) -- выписываем его id в чат
--end

local effilTelegramSendMessage = effil.thread(function(text, chatID, token)
	local requests = require('requests')
	requests.post(('https://api.telegram.org/bot%s/sendMessage'):format(token), {
		params = {
			text = text;
			chat_id = chatID;
		}
	})
end)

function url_encode(text)
	local text = string.gsub(text, "([^%w-_ %.~=])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
	return string.gsub(text, " ", "+")
end

function SendTelegram(text)
    effilTelegramSendMessage(url_encode(u8(text)), "-1002375109660", "7758049815:AAHGqItgExrRebmnM_CUkwo2rAaG3XwzIE4")
end


function ColorsChatAd(val)
	val = tonumber(val)
	local red = 0xFF0000
	local orange = 0xFFA500
	local green = 0x00FF00
	if val <= 50 then
		return red
	elseif val > 50  and val <= 100 then
		return orange
	elseif val > 100 then
		return green
	end
end
function ColorsChatInv(val)
	val = tonumber(val)
	local red = 0xFF0000
	local orange = 0xFFA500
	local green = 0x00FF00
	if val <= 5 then
		return red
	elseif val > 5  and val <= 10 then
		return orange
	elseif val > 10 then
		return green
	end
end

local check_my_uid = false
local nickcheckvip = ""
local vip_check = false
local findvip = false
local lineUID = {}
local current_uid, new_nick_uid = "$nil$", ""
function sampev.onServerMessage(color, text)
	if text:find("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." інвайт (%d+)") and color == -1178486529  then
		local empty1, rang, empty3, empty4,empty5,id = text:match("%[Семья%](.+) (%d+) (.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." інвайт (%d+)")
		if id and tonumber(rang) >= 8 then
			lua_thread.create(function ()
				wait(500)
				sampSendChat("/faminvite "..id)
				
			end)
			
		else 
			local rang, empty3, empty4,empty5,id = text:match("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." інвайт (%d+)")
			if string.match(rang, "X") then
				lua_thread.create(function ()
					wait(500)
					sampSendChat("/faminvite "..id)
					
				end)
				
			end
			
		end
	end
	if text:find("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." кік (%d+) (.+)") and color == -1178486529  then
		local empty1, rang, empty3, empty4,empty5,empty6, id,reason = text:match("%[Семья%](.+) (%d+) (.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." кік (%d+) (.+)")
		if id and tonumber(rang) >= 9 then
			lua_thread.create(function ()
				wait(500)
				sampSendChat("/famuninvite "..id.." "..reason)
			end)
		end
	end
	if text:find("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." ранг (%d+) (%d+)") and color == -1178486529  then
		local empty1, rang, empty3, empty4,empty5,empty6, id, setrang = text:match("%[Семья%](.+) (%d+) (.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." ранг (%d+) (%d+)")
		if id and tonumber(rang) >= 9 then
			lua_thread.create(function ()
				wait(500)
				sampSendChat("/setfrank "..id.." "..setrang)
			end)
		end
	end
	if text:find("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." мут (%d+) (%d+) (.+)") and color == -1178486529  then
		local empty1, rang, empty3, empty4,empty5,empty6, id, muttime, reason = text:match("%[Семья%](.+) (%d+) (.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." мут (%d+) (%d+) (.+)")
		if id and tonumber(rang) >= 9 then
			lua_thread.create(function ()
				wait(500)
				sampSendChat("/fammute "..id.." "..muttime.." "..reason)
			end)
		end
	end
	if text:find("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." розмут (%d+)") and color == -1178486529  then
		local empty1, rang, empty3, empty4,empty5,empty6, id = text:match("%[Семья%](.+) (%d+) (.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." розмут (%d+)")
		if id and tonumber(rang) >= 9 then
			lua_thread.create(function ()
				wait(500)
				sampSendChat("/famunmute "..id)
			end)
		end
	end
	if text:find("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." тег (%d+) (.+)") and color == -1178486529  then
		local empty1, rang, empty3, empty4,empty5,empty6, id, teg = text:match("%[Семья%](.+) (%d+) (.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." тег (%d+) (.+)")
		if id and tonumber(rang) >= 9 then
			lua_thread.create(function ()
				wait(500)
				sampSendChat("/famtag "..id.." "..teg)
			end)
		end
	end
	if text:find("%[Семья%](.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." !тег (%d+)") and color == -1178486529  then
		local empty1, rang, empty3, empty4,empty5,empty6, id = text:match("%[Семья%](.+) (%d+) (.+)(%w+_%w+)%[(%d+)%](.+) "..mynick.." !тег (%d+)")
		if id and tonumber(rang) >= 9 then
			lua_thread.create(function ()
				wait(500)
				sampSendChat("/unfamtag "..id)
			end)
		end
	end
	if text:find("%[VIP%]:") and vip_check then
			local nickisvip = string.match(text, "%[VIP%]:(.+)")
			if nickisvip then
				if string.match(nickisvip, nickcheckvip) then
					findvip = true
				end
			end
			return false
		end
		if text:find("Всего: ") and vip_check then
			return false
		end
		
	nick1, id1, input1 = string.match(text, '([a-zA-Z_]+)%[(%d+)%]:{FFFFFF} Пополнил склад семьи на (.+)')
	if nick1 and color == -1178486529 then
	    local timehs = os.time()
		local fammoney = string.gsub(input1, "%p","")
		if tonumber(fammoney) >= 10000 then
			lua_thread.create(function ()
				GetLogMoney(u8(os.date('%d/%m/%Y [%X] ', timehs)..nick1.." поклав "..formatNumberWithCommas(fammoney).."$"))
			end)
		end
	
	end
	
	nick2, id2, input2 = string.match(text, '([a-zA-Z_]+)%[(%d+)%]:{FFFFFF} Взял (.+) со склада семьи!')
	if nick2 and color == -1178486529  then
		local timehs = os.time()
		local fammoney = string.gsub(input2, "%p","")
		if tonumber(fammoney) >= 10000 then
			lua_thread.create(function ()
				GetLogMoney(u8(os.date('%d/%m/%Y [%X] ', timehs)..nick2.." взяв "..formatNumberWithCommas(fammoney).."$"))
			end)
		end
	
	end
	
	local empty, nick3, id3, input3 = string.match(text, "%[Семья%] (.+) (%w+_%w+)%[(%d+)%]:{B9C1B8} %+")
	if nick3 and id3 and checked_giv.v and color == -1178486529 then
		if not string.match(GivPlayers, nick3) then
	   		GivPlayers = GivPlayers..nick3.."\n"
		end
	
	end
    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) 
    if text:find("Объявление: (%D+)е(%D+)я (%D+)".. nick) and color == 1941201407 then
	   StepAD=StepAD + 1
	   lua_thread.create(function()
	   wait(100)
       sampAddChatMessage('[AdHelper] Кількість оголошень: '.. StepAD, ColorsChatAd(StepAD))
	   end)
	   local timeh = os.time()
       local file = io.open(getGameDirectory()..'\\moonloader\\AdHelper\\Логи\\Log.txt', 'a')
	   if file then
            file:write(os.date('[%H:%M:%S] ', timeh)..'Оголошення: '.. StepAD, ' Інвайти: '.. StepInv, '\n')
            file:close()
	    end
		lua_thread.create(function ()
			SendMyState()
			
		end)
		if checked_piar.v then
			ad_piar_delay = true
        	piar_zmi_timer = os.clock()
		end
	 
	end 
    
    if text:find("вступить в вашу семью!") then
	    lua_thread.create(function()
			wait(100)
	    	sampSendChat('/b X або /offer')
		end)
    end
	
	if text:find("%[Семья (.+)%] "..mynick.."(.+) пригласил в семью нового члена: (%w+_%w+)%[(%d+)%]!") and color == -1178486529 then
		local empty1, empty2, empty3, invid = string.match(text, "%[Семья (.+)%] "..mynick.."(.+) пригласил в семью нового члена: (%w+_%w+)%[(%d+)%]!")
		if invid then
			StepInv= StepInv + 1
			lua_thread.create(function()
				wait(100)
				sampAddChatMessage('[AdHelper] Кількість інвайтів: '.. StepInv, ColorsChatInv(StepInv))
				sampSendChat("/fam "..u8:decode(dsandtg))
				wait(500)
				sampSendChat("Вітаємо у сім'ї")
				wait(1000)
				if invid then
					CheckVipPlayers(invid)
				end
				SendMyState()
			end)
			DeleteOrAddPlayer(true, sampGetPlayerNickname(invid), "delete")
		end
    end
	if text:find("Вы не состоите в одной из семей") then
		check_fmembers = false
		checked_online_screen.v = false
		staff_family = {}
	end

	if text:find(mynick..'(%[(%d+)%]):{FFFFFF} Взял $(.+) со склада семьи!') and color == -1178486529 then
		local nil1, nil2, money_salary = string.match(text, mynick..'(%[(%d+)%]):{FFFFFF} Взял $(.+) со склада семьи!')
		if money_salary then
			money_salary = string.gsub(money_salary, "%p","")
			if tonumber(money_salary) == math.ceil(allSum) then
				StepAD = 0
	       	 	StepInv = 0
				minutes = 0
				hour = 0
				premmoney = 0
				premium = true
				countVIP = 0
				lua_thread.create(function ()
					SendMyState()	
				end)
				sampAddChatMessage("[AdHelper] Вітаємо. Ви успішно взяли ЗП.", 0x00FF00)
				
			end
		end
		
	end

	if text:find("UID: ") and check_uid then
		local id_uid, nickuid, lvluid, uid, launcher_uid = text:match('%[(%d+)%] (.+) | Уровень: (%d+) | UID: (%d+) | packetloss: .+% %((.+)%)') 
		if uid and nickuid then
			if uid == uidhunt then
				sampAddChatMessage("[AdHelper] Знайдено збіг: {00FF00}["..id_uid.."] "..nickuid.." | Рівень: "..lvluid.." | UID: "..uid.." | "..launcher_uid, 0xFF4500)
				check_uid = false
			end
		end
		return false
	end

	if text:find("%[Ошибка%] %{......%}Игрок") and check_uid then
		return false
	end

	if text:find("UID: ") and check_uid_blacklist then
		local id_uid, nickuid, lvluid, uid, launcher_uid = text:match('%[(%d+)%] (.+) | Уровень: (%d+) | UID: (%d+) | packetloss: .+% %((.+)%)') 
		if uid and nickuid then
			for i = 1, #lineUID do
				if uid == lineUID[i] then
					current_uid = lineUID[i]
					new_nick_uid = nickuid
					--sampAddChatMessage(lineUID[i]..nickuid, -1)
				end
			end
		end
		return false
	end
	 
	if text:find("%[Ошибка%] %{......%}Игрок") and check_uid_blacklist then
		return false
	end

	if text:find("UID: ") and check_my_uid then
		local id_uid, nickuid, lvluid, uid, launcher_uid = text:match('%[(%d+)%] (.+) | Уровень: (%d+) | UID: (%d+) | packetloss: .+% %((.+)%)') 
		if uid and nickuid then
			lua_thread.create(function ()
				local file_path_notebook = "Accessibility.txt"
				local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_notebook, "main")

    			asyncHttpRequest("GET", sha_url, {
       				headers = {
            			["Authorization"] = "token " .. api_token 
        			}
    			}, function(response)

        			local file_info = json.decode(response.text)
        			local sha = file_info.sha
        			local encoded_content = file_info.content
					if encoded_content ~= nil then
						local decoded_content = base64.decode(encoded_content)
						for line in decoded_content:gmatch("[^\n]+") do
							if line == uid then
								accessibility = true
							end
						end
        	
			
        			end
    			end)
				
			end)
		end
		check_my_uid = false
		return false
	end
	
	if text:find('(%w+_%w+)%[(%d+)%]:    %{......%}(%d+)') and numberpl then
		local empty1, empty2,numberphone = text:match('(%w+_%w+)%[(%d+)%]:    %{......%}(%d+)')
		if numberphone then
			fifth_window_state.v = false
			sampSendChat("/call "..numberphone)
			numberpl = false
		end
		return false
	else
		numberpl = false
	end
	
	
     	 
end

local TimerDelayForNot1 = 0
local TimerDelayForNot2 = 0
local TimerDelayForNot3 = 0
local TimerDelayForNot4 = 0
local TimerDelayForNot5 = 0  
function sendNotonTimer()
	if notontimer1 then
		if os.date("%M:%S") == text_buffer16.v then
			if(os.clock() - TimerDelayForNot1 > 1) then
				sampSendChat(u8:decode(text_buffer14.v))
				TimerDelayForNot1 = os.clock()
				if text_buffer14.v:find("/vr") then not_vr = true end
			end
		end

		
	end
	if notontimer2 then
		if os.date("%M:%S") == text_buffer17.v then
			if(os.clock() - TimerDelayForNot2 > 1) then
				sampSendChat(u8:decode(text_buffer15.v))
				TimerDelayForNot2 = os.clock()
				if text_buffer15.v:find("/vr") then not_vr = true end
			end
		end
		
	end
	if notontimer3 then
		if os.date("%M:%S") == text_buffer_not_time1.v then
			if(os.clock() - TimerDelayForNot3 > 1) then
				sampSendChat(u8:decode(text_buffer2.v))
				TimerDelayForNot3 = os.clock()
				if text_buffer2.v:find("/vr") then not_vr = true end
			end
			
		end

	end
	if notontimer4 then
		if os.date("%M:%S") == text_buffer_not_time2.v then
			if(os.clock() - TimerDelayForNot4 > 1) then
				sampSendChat(u8:decode(text_buffer3.v))
				TimerDelayForNot4 = os.clock()
				if text_buffer3.v:find("/vr") then not_vr = true end
			end
			
		end

	end
	if notontimer5 then
		if os.date("%M:%S") == text_buffer_not_time3.v then
			if(os.clock() - TimerDelayForNot5 > 1) then
				sampSendChat(u8:decode(text_buffer4.v))
				TimerDelayForNot5 = os.clock()
				if text_buffer4.v:find("/vr") then not_vr = true end
			end
			
		end

	end

	
end


function cmd_ad(arg)
    sampSendChat('/ad Семья Banderas ищет друзей')
	    
	
end


function CheckOnline()
	for k, v in ipairs(Fasten) do
		Fasten[k].online = false
	end
	for a = 0, 1000 do
		if sampIsPlayerConnected(a) then
			local nickname = sampGetPlayerNickname(a)
			for k,v in ipairs(Fasten) do
				if nickname == v.nick then
					Fasten[k].id = a
					Fasten[k].online = true
				end
			end
		end
	end
end

function FloodSalary()
	local getdata = false
	lua_thread.create(function()
		while not getdata do
			asyncHttpRequest("GET", "http://worldtimeapi.org/api/timezone/Europe/Kyiv", nil, 
			function(response)
				if err then
					return
				end
        		local info = decodeJson(response.text)
				getdata = true
				if info then
					if tonumber(info.day_of_week) == 0 and allSum >= 5000000 then
						sampAddChatMessage("[AdHelper] Будь ласка, візьміть ЗП :$: :)", 0xFF0000)
					end
				end
				end)
		end
	end)
end

function GetQueue()
	local file_path_notebook = "Queue.txt"
	local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_notebook, "main")

    asyncHttpRequest("GET", sha_url, {
       	headers = {
            ["Authorization"] = "token " .. api_token 
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			local decoded_content = base64.decode(encoded_content)
			Fasten = {}
			for line in decoded_content:gmatch("[^\n]+") do
				Fasten[#Fasten+1] = { 
					nick = string.match(line, "(.+)%("),
					description = string.match(line, "%((.+)%)"),
					online = false
				}
			end
					
        end
    end)

end

function SendQueue(text)
    local file_path_queue = "Queue.txt"
    local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_queue, "main")
	local encoded_content = base64.encode(text)
    asyncHttpRequest("GET", sha_url, {
        headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)
        if response.status_code ~= 200 then
            return
        end

        local sha_data = json.decode(response.text)
        local sha = sha_data.sha

        local update_data = {
            message = commit_message,
            content = encoded_content,
            sha = sha,
            branch = "main"
        }

        local update_body = json.encode(update_data)
        local update_url = string.format("https://api.github.com/repos/%s/contents/%s",repo, file_path_queue)
	

	asyncHttpRequest("PUT", update_url, {
            headers = {
                ["Authorization"] = "token " .. api_token,
                ["Content-Type"] = "application/json"
            },
            data = update_body
        }, function(response)
        end)
    end, function(error)
    end)

end
function EmulateKey(key, isDown)
    if not isDown then
        ffi.C.keybd_event(key, 0, 2, 0)
    else
        ffi.C.keybd_event(key, 0, 0, 0)
    end
end

function cmd_ah(arg) 
    secondary_window_state.v = not secondary_window_state.v
	imgui.Process = true
    GetMyUID()
	lua_thread.create(function()
		GetAdminsTGFORWidnow()
	end)
	PlayAudioClick()
end

function GetAdminsTG()
	local adm_tg = ""
	asyncHttpRequest("GET", "https://api.telegram.org/bot7758049815:AAHGqItgExrRebmnM_CUkwo2rAaG3XwzIE4/getChatAdministrators?chat_id=-1002375109660", {
		}, function(response)
			local response_adm = json.decode(response.text)
			for _, admin in ipairs(response_adm.result) do
				if admin.user.username then
					adm_tg = adm_tg.." @"..admin.user.username
				end
			end
			
		end)
end
local AdminsTG = {}
function GetAdminsTGFORWidnow()
	AdminsTG = {}
	asyncHttpRequest("GET", "https://api.telegram.org/bot7758049815:AAHGqItgExrRebmnM_CUkwo2rAaG3XwzIE4/getChatAdministrators?chat_id=-1002375109660", {
		}, function(response)
			local response_adm = json.decode(response.text)
			for _, admin in ipairs(response_adm.result) do
				if admin.user.username then
					table.insert(AdminsTG, "@"..admin.user.username)
				end
			end
			
		end)
end

function CheckVipPlayers(arg)
	if arg ~= "" and tonumber(arg) and sampIsPlayerConnected(arg) then
		vip_check = true
		nickcheckvip = sampGetPlayerNickname(arg)
		sampSendChat('/vipplayers')	
		wait(2000)
		vip_check = false
		wait(100)
		if findvip then
			sampAddChatMessage("[AdHelper] "..nickcheckvip.." має віп. Ви отримали додатково $500000 до ЗП.", 0x00FF00)
			countVIP = countVIP + 1
			SendMyState()
		end
		wait(500)
		findvip = false
	end	
end


function CheckBoxTax()
	imgui.Checkbox(u8"Автооплата податку", checked_tax)
		--if checked_tax.v and not check_tax then
		    --check_tax = true
			--sampAddChatMessage("[AdHelper] Ви включили автооплату податків на сімейну квартиру. Функція спрацьовує відразу після спавну.", 0x00FA9A)
			--lua_thread.create(function()
				--SendMyState()
			--end)
		--end
	
end

function StyleIMGUI()
	if styleimg == 1 then
		apply_custom_style_green()
	elseif styleimg == 2 then
		apply_custom_style_white()	
	elseif styleimg == 3 then
		apply_custom_style_blue()
	elseif styleimg == 4 then
		apply_custom_style_violet()
	elseif styleimg == 5 then
		apply_custom_style_red()
	elseif styleimg == 6 then
		apply_custom_style_pink()
	elseif styleimg == 7 then
		apply_custom_style_yellow()
	elseif styleimg == 8 then
		apply_custom_style_gray()
	elseif styleimg == 9 then
		apply_custom_style_dark()
	end
	
end
local Users = {}
local number_users_before = 0
local number_users_after = 0
function CheckGitHub()
	withoutlimits = true
	file_path = ""
	local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path, branch)

    asyncHttpRequest("GET", sha_url, {
    headers = {
        ["Authorization"] = "token " .. api_token
    }
    }, function(response)
		local items, pos, err = json.decode(response.text)
        if err then
            return
        end

        for _, item in ipairs(items) do
            if item.type == "file" and item.path ~= "README.md"then
				number_users_before = number_users_before + 1
                Users[#Users + 1] = {
					flpatch = item.path
				}
            elseif item.type == "dir" then
                get_files(item.path) 
            end
        end
        
    end)


	withoutlimits = false
end

function getMyIP()
	asyncHttpRequest('GET', 'http://ip-api.com/json/?fields=61439', nil,
  	function(response) 
		if response then
			local ipjson = decodeJson(response.text)
			if ipjson then
				local ipinfo = ipjson.query
				local ip_country = ipjson.country
				local ip_obl = ipjson.regionName
				local ip_city = ipjson.city
				myip = ipinfo..' ('..ip_country..', '..ip_obl..', '..ip_city..')'
			end
		end
	end)
end

local DepActive = {}
function CheckGitHubActive()
	for k, v in ipairs(Users) do
		local file_path_info = Users[k].flpatch
		local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_info, branch)

    	asyncHttpRequest("GET", sha_url, {
    	headers = {
        	["Authorization"] = "token " .. api_token
    	}
    	}, function(response)
		local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			local decoded_content = base64.decode(encoded_content)
        	local info = decodeJson(decoded_content)
			if Users[k] then
				local nickdep = Users[k].flpatch
				if nickdep then
					number_users_after = number_users_after + 1
					nickdep = string.gsub(nickdep,".txt","")
					DepActive[#DepActive+1] = {
						nick = nickdep,
						ad = info.Ad,
						inv = info.Inv,
						hour = info.Hour,
						vip = info.CountVipPlayers,
						earn = info.Earn,
						ip = info.MyIP,
						tg = info.MyTG
					}
				end
			end
		end

		end)
		if not third_window_state.v then break end
	end
	
end

function GetTGDep(path)
	local tg_dep_nick = ""
	local file_path_dep = path..".txt"
	local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path_dep, branch)
	asyncHttpRequest("GET", sha_url, {
    	headers = {
        	["Authorization"] = "token " .. api_token
    	}
    }, function(response)
		local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			local decoded_content = base64.decode(encoded_content)
        	local info = decodeJson(decoded_content)
			if info.MyTG then
				tg_dep_nick = info.MyTG
				SendTelegram(tg_dep_nick.." терміново зайди в гру!\nВід: "..mynick)
			else
				sampAddChatMessage("[AdHelper] На жаль, сталася помилка :pensive:", 0xFF0000)
			end
			end
    	end)

end
local fontsize = nil
local fontsize_notepad = nil
local fontsize_drive = nil
local fontsize_info_members = nil
local fontsize_faq = nil
local fontsize_TG = nil
function imgui.BeforeDrawFrame()
    if fontsize == nil then
        fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', sw/100, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) 
    end
	if fontsize_notepad == nil then
		fontsize_notepad = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', CalculateSizeAndPosX(13), nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	end
	if fontsize_drive == nil then
		fontsize_drive = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\impact.ttf', CalculateSizeAndPosX(25), nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	end
	if fontsize_info_members == nil then
		fontsize_info_members = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\impact.ttf', CalculateSizeAndPosX(13), nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	end
	if fontsize_faq == nil then
		fontsize_faq = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\impact.ttf', CalculateSizeAndPosX(15), nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	end
	if fontsize_TG == nil then
		fontsize_TG = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', CalculateSizeAndPosX(35), nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	end
end
local countplwithscript = 0
function imgui.OnDrawFrame()
	StyleIMGUI()
	if not main_window_state.v and not secondary_window_state.v and not third_window_state.v and not fourth_window_state.v and not seventh_window_state.v and not fifth_window_state.v and not sixth_window_state.v then
	    imgui.Process = false
		freezeCharPosition(PLAYER_PED, false)
	else
		freezeCharPosition(PLAYER_PED, true)
	end
	
	local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed))) 
	
	ImguiMAINWindow()

	if not fifth_window_state.v and not third_window_state.v then
		Users = {}
		DepActive = {}
	end
	if fifth_window_state.v then
		imgui.Proccess = fifth_window_state.v 
		imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver)
	    imgui.Begin(u8"[AdHelper] | Керування | Banderas Family", fifth_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imguiDrawHeaders()
		for k,v in pairs(InfoFamily) do
			local slider_val = slider_font_size_staff.v
			imgui.PushFont(fontsize_drive) 
			imgui.CenterText(InfoFamily[k].name.. ":  "..InfoFamily[k].online.." ("..countplwithscript..")")
			imgui.PopFont()
			imgui.SameLine()
			imgui.Checkbox(u8"Онлайн на екрані", checked_online_screen)
			if checked_online_screen.v then
				if ffi.C.GetAsyncKeyState(VK_LBUTTON) ~= 0 then
					local CursX, CursY = getCursorPos()
					if CursX - PosStaffX <= 200 then
						if CursY - PosStaffY <= 150 then
							PosStaffX = CursX - CalculateSizeAndPosX(20)
							PosStaffY = CursY - CalculateSizeAndPosY(20)
						end
					end
				end
			end
			imgui.SameLine()
			imgui.PushItemWidth(CalculateSizeAndPosX(100))
			imgui.SliderInt(u8"Шрифт",slider_font_size_staff, 1, 20)
			if slider_val ~= slider_font_size_staff.v then
				font_size_staff = slider_font_size_staff.v
				font_staff = renderCreateFont("Arial", CalculateSizeAndPosX(font_size_staff), 13)
				font_staff_name = renderCreateFont("Arial", CalculateSizeAndPosX(font_size_staff+1), 13)
			end
		end
		imgui.PushFont(fontsize_info_members)
		imgui.Separator()
		imgui.Text(u8"   Ранг")
		imgui.SameLine(CalculateSizeAndPosX(80))
		imgui.Text(u8"Нік")
		imgui.SameLine(CalculateSizeAndPosX(130))
		imgui.Text(u8"Ід")
		imgui.SameLine(CalculateSizeAndPosX(180))
		imgui.Text(u8"Лвл")
		imgui.SameLine(CalculateSizeAndPosX(230))
		imgui.Text(u8"Квести")
		imgui.SameLine(CalculateSizeAndPosX(280))
		imgui.Text(u8"АФК")
		imgui.PopFont()
		imgui.Separator()
		local countplayerswithscrpt = 0
			for k, v in ipairs(staff_family) do
				imgui.PushFont(fontsize) 
				imgui.TextColoredRGB("{"..staff_family[k].color.."}("..staff_family[k].rank..") "..staff_family[k].nick.."["..staff_family[k].idp.."]".." ["..staff_family[k].lvl.."]"..staff_family[k].quest.."/8 ("..staff_family[k].afk..")") 
				for ku, vu in ipairs(Users) do
					if string.match(Users[ku].flpatch , staff_family[k].nick) then
						countplayerswithscrpt = countplayerswithscrpt+ 1
						imgui.SameLine()
						imgui.Image(imageUsers, imgui.ImVec2(CalculateSizeAndPosX(20), CalculateSizeAndPosY(20)))
						if imgui.IsItemClicked() then
							lua_thread.create(function()
								GetTGDep(staff_family[k].nick)
							end)
						end
					end
				end
				countplwithscript = countplayerswithscrpt
				imgui.PopFont()
				imgui.SameLine()
				if imgui.Button(u8"Набрати##"..staff_family[k].idp) then
					sampSendChat("/number "..staff_family[k].idp)
					numberpl = true
					
				end
				imgui.Separator()
			end

		imgui.End()
	end

	imguiDrawTasks()
	if third_window_state.v then
		imgui.Proccess = third_window_state.v 
		imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver)
	    imgui.Begin(u8"[AdHelper] | Активність | Banderas Family", third_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imguiDrawActive()
			
		imgui.End()
	end

	
	ImguiDrawBlackList()

	if main_window_state.v then
		imgui.Proccess = main_window_state.v
	    imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/5.5, sh/10), imgui.Cond.FirstUseEver)
	    imgui.Begin(u8"[AdHelper] | Налаштування | Banderas Family", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imgui.TextWrapped(u8"Натисніть ПРАВОЮ кнопкою миши в будь-яку частину екрану, щоб змінити позицію вікна.")
		if imgui.Button(u8"Зберегти") then
			sampAddChatMessage("[AdHelper] Ви успішно зберегли нову позицію для вікна.", 0x7FFFD4)
			main_window_state.v = false
			secondary_window_state.v = true
			lua_thread.create(function ()
				SendMyState()
			end)
		end
		if isKeyJustPressed(VK_RBUTTON) then
			local x, y = getCursorPos()
			PosWindowX = x - CalculateSizeAndPosX(20)
			PosWindowY = y - CalculateSizeAndPosY(20)
			sampAddChatMessage("[AdHelper] Ви успішно встановили нову позицію для вікна.", 0x7FFFD4)
				
		end
		imgui.End()
	end
	
	imguiDrawLogs()
	
	
	if isKeyJustPressed(VK_ESCAPE) then
	    secondary_window_state.v = false
		imgui.Proccess = false
			
    end
end
local spawn_check = false
local text_faq = ""
local TimerSaveText = 0
local piar_state = false
function ImguiMAINWindow()
	if secondary_window_state.v then
	    imgui.Process = secondary_window_state.v
	    imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2, sh/2.36), imgui.Cond.FirstUseEver)
	    imgui.Begin(u8"[AdHelper] | Привіт, "..mynick.."| Banderas Family", secondary_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		
		imguiDrawHeaders()
		if myTG == "" or myTG == " " then
			choiceTG_window_state.v = true
			if choiceTG_window_state.v then
				imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
				imgui.SetNextWindowSize(imgui.ImVec2(sw/2, sh/2.36), imgui.Cond.FirstUseEver)
				imgui.Begin(u8"[AdHelper] | TG | Banderas Family", choiceTG_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse+ imgui.WindowFlags.NoMove)
				imgui.PushFont(fontsize_TG)
				imgui.CenterText(u8"Виберіть свій ТГ")
				imgui.PopFont()
				imgui.NewLine()
				imgui.PushFont(fontsize_drive)
				for i, v in ipairs(AdminsTG) do
					if imgui.Button(v.."##"..i, imgui.ImVec2(CalculateSizeAndPosX(223),CalculateSizeAndPosY(100))) then --223 100
						myTG = v
						choiceTG_window_state.v = false
					end
					if i % 4 ~= 0 then
						imgui.SameLine()
					end
				end
				imgui.PopFont()
				imgui.End()
			end
		end
		imgui.Text(u8"Текст після інвайту:")
		imgui.PushItemWidth(CalculateSizeAndPosX(310))
		imgui.InputTextWithHint('##text_after_inv',u8"Введіть текст, який буде надіслано в сімейний чат.", text_buffer)	
		if text_buffer.v:find('"') then
			text_buffer.v = string.gsub(text_buffer.v,'"','')
		end
		if text_buffer.v:find("'") then
			text_buffer.v = string.gsub(text_buffer.v,"'","")
		end
		imgui.SameLine()
		if text_buffer.v ~= dsandtg and os.clock() - TimerSaveText > 5 then
			dsandtg = text_buffer.v
			TimerSaveText = os.clock()
			lua_thread.create(function()
				SendMyState()
			end)
	   
		end
		imgui.PushItemWidth(CalculateSizeAndPosX(60))
		imgui.SameLine()
		imgui.SetCursorPosX(CalculateSizeAndPosX(700))
		if imgui.Button(u8"Взяти ЗП") then
			if allSum > 10000 then
				lua_thread.create(function ()
					secondary_window_state.v = false
					sampSendChat("/fammenu")
					wait(200)
					ffi.C.SetCursorPos(sw/1.65, sh/2)
					setVirtualKeyDown(1, true)
					wait(10)
					setVirtualKeyDown(1, false)
					take_salary = true

				end)
			end
        
		
		end
		imgui.SameLine()
		imgui.Text(u8"Тема: ")
		imgui.SameLine()
		imgui.PushItemWidth(CalculateSizeAndPosX(100))
		imgui.Combo(u8' ',ComboStyle,style_list, #style_list)
		styleimg = ComboStyle.v + 1
		imgui.Separator()
		
	
		imgui.Checkbox(u8"Автопіар", checked_piar)
		if checked_piar.v then
		    imgui.Text(u8"Затримка:")
		    imgui.PushItemWidth(CalculateSizeAndPosX(120))
		    imgui.SliderInt(u8"хв##2", slider, 1, 30)
			if not piar_state then
				piar_state = true
				ad_piar_delay = false
				active = true
				piar_zmi_timer = os.clock()
				sampSendChat("/ad Семья Banderas ищет друзей")
				sampAddChatMessage('[AdHelper] Режим автопіару {00FF00}увімкнено!', 0x00FA9A)
			end
		else
			if piar_state then
			    sampAddChatMessage('[AdHelper] Режим автопіару {ff0000}вимкнено!', 0x00FA9A)
				piar_state = false
			end
		end
		
		imgui.Separator()
		  
	
		
		imgui.Checkbox(u8"Сповіщення", checked_not)	
		if checked_not.v then
		    checked_giv.v = false
		    imgui.PushItemWidth(CalculateSizeAndPosX(530))
		    imgui.InputText(u8"Хв і сек в форматі: 00:00##1", text_buffer2)
			if text_buffer2.v:find('"') then
				text_buffer2.v = string.gsub(text_buffer2.v,'"','')
			end
			if text_buffer2.v:find("'") then
				text_buffer2.v = string.gsub(text_buffer2.v,"'","")
			end
			imgui.SameLine()
			imgui.PushItemWidth(CalculateSizeAndPosX(60))
			imgui.InputText(u8"##1", text_buffer_not_time1)
			imgui.SameLine()
			if not notontimer3 then
				if imgui.Button(u8"Старт##1") then
					local minutesnot, secondsnot = string.match(text_buffer_not_time1.v, "(%d+):(%d+)")
					if string.match(text_buffer_not_time1.v, "^(%d+):(%d+)$") and tonumber(minutesnot) < 60 and tonumber(minutesnot) >= 0 and tonumber(secondsnot) < 60 and tonumber(secondsnot) >= 0  then
						if text_buffer2.v ~= "" then
							notontimer3 = true
							sampAddChatMessage("[AdHelper] Сповіщення успішно ввімкнено.", 0x00FF00)
							lua_thread.create(function ()
								SendMyState()								
							end)
						else
							sampAddChatMessage("[AdHelper] Поле для тексту не може бути пустим!", 0xFF0000)
						end
				
					else
						sampAddChatMessage("[AdHelper] Некоректно введено час!", 0xFF0000)

					end
				end
			
			else
				if imgui.Button(u8"Стоп##1") then
					notontimer3 = false
				end
			end
			imgui.PushItemWidth(CalculateSizeAndPosX(530))
			imgui.InputText(u8"Хв і сек в форматі: 00:00##2", text_buffer3)
			if text_buffer3.v:find('"') then
				text_buffer3.v = string.gsub(text_buffer3.v,'"','')
			end
			if text_buffer3.v:find("'") then
				text_buffer3.v = string.gsub(text_buffer3.v,"'","")
			end
			imgui.SameLine()
			imgui.PushItemWidth(CalculateSizeAndPosX(60))
			imgui.InputText(u8"##2", text_buffer_not_time2)
			imgui.SameLine()
			if not notontimer4 then
				if imgui.Button(u8"Старт##2") then
					local minutesnot, secondsnot = string.match(text_buffer_not_time2.v, "(%d+):(%d+)")
					if string.match(text_buffer_not_time2.v, "^(%d+):(%d+)$") and tonumber(minutesnot) < 60 and tonumber(minutesnot) >= 0 and tonumber(secondsnot) < 60 and tonumber(secondsnot) >= 0  then
						if text_buffer3.v ~= "" then
							notontimer4 = true
							sampAddChatMessage("[AdHelper] Сповіщення успішно ввімкнено.", 0x00FF00)
							lua_thread.create(function ()
								SendMyState()								
							end)
						else
							sampAddChatMessage("[AdHelper] Поле для тексту не може бути пустим!", 0xFF0000)
						end
				
					else
						sampAddChatMessage("[AdHelper] Некоректно введено час!", 0xFF0000)

					end
			
				end
			else
				if imgui.Button(u8"Стоп##2") then
					notontimer4 = false
				end
			end
			imgui.PushItemWidth(CalculateSizeAndPosX(530))
			imgui.InputText(u8"Хв і сек в форматі: 00:00##3", text_buffer4)
			if text_buffer4.v:find('"') then
				text_buffer4.v = string.gsub(text_buffer4.v,'"','')
			end
			if text_buffer4.v:find("'") then
				text_buffer4.v = string.gsub(text_buffer4.v,"'","")
			end
			imgui.SameLine()
			imgui.PushItemWidth(CalculateSizeAndPosX(60))
			imgui.InputText(u8"##3", text_buffer_not_time3)
			imgui.SameLine()
			if not notontimer5 then
				if imgui.Button(u8"Старт##3") then
					local minutesnot, secondsnot = string.match(text_buffer_not_time3.v, "(%d+):(%d+)")
					if string.match(text_buffer_not_time3.v, "^(%d+):(%d+)$") and tonumber(minutesnot) < 60 and tonumber(minutesnot) >= 0 and tonumber(secondsnot) < 60 and tonumber(secondsnot) >= 0  then
						if text_buffer4.v ~= "" then
							notontimer5 = true
							sampAddChatMessage("[AdHelper] Сповіщення успішно ввімкнено.", 0x00FF00)
							lua_thread.create(function ()
								SendMyState()								
							end)
						else
							sampAddChatMessage("[AdHelper] Поле для тексту не може бути пустим!", 0xFF0000)
						end
				
					else
						sampAddChatMessage("[AdHelper] Некоректно введено час!", 0xFF0000)

					end
			
				end
			else
				if imgui.Button(u8"Стоп##3") then
					notontimer5 = false
				end
			end
			imgui.PushItemWidth(CalculateSizeAndPosX(530))
			imgui.InputText(u8"Хв і сек в форматі: 00:00##4", text_buffer14)
			if text_buffer14.v:find('"') then
				text_buffer14.v = string.gsub(text_buffer14.v,'"','')
			end
			if text_buffer14.v:find("'") then
				text_buffer14.v = string.gsub(text_buffer14.v,"'","")
			end
			imgui.SameLine()
			imgui.PushItemWidth(CalculateSizeAndPosX(60))
			imgui.InputText(u8"##5", text_buffer16)
			imgui.SameLine()
			if not notontimer1 then
				if imgui.Button(u8"Старт##4") then
					local minutesnot, secondsnot = string.match(text_buffer16.v, "(%d+):(%d+)")
					if string.match(text_buffer16.v, "^(%d+):(%d+)$") and tonumber(minutesnot) < 60 and tonumber(minutesnot) >= 0 and tonumber(secondsnot) < 60 and tonumber(secondsnot) >= 0  then
						if text_buffer14.v ~= "" then
							sampAddChatMessage("[AdHelper] Сповіщення успішно ввімкнено.", 0x00FF00)
							notontimer1 = true
							lua_thread.create(function ()
								SendMyState()								
							end)
						else
							sampAddChatMessage("[AdHelper] Поле для тексту не може бути пустим!", 0xFF0000)
						end
					
					else
						sampAddChatMessage("[AdHelper] Некоректно введено час!", 0xFF0000)

					end
				
				end
			else
				if imgui.Button(u8"Стоп##4") then
					notontimer1 = false
				end
			end
			imgui.PushItemWidth(CalculateSizeAndPosX(530))
			imgui.InputText(u8"Хв і сек в форматі: 00:00##5", text_buffer15)
			if text_buffer15.v:find('"') then
				text_buffer15.v = string.gsub(text_buffer15.v,'"','')
			end
			if text_buffer15.v:find("'") then
				text_buffer15.v = string.gsub(text_buffer15.v,"'","")
			end
			imgui.SameLine()
			imgui.PushItemWidth(CalculateSizeAndPosX(60))
			imgui.InputText(u8"##6", text_buffer17)
			imgui.SameLine()
			if not notontimer2 then
				if imgui.Button(u8"Стaрт##5") then
					local minutesnot, secondsnot = string.match(text_buffer17.v, "(%d+):(%d+)")
					if string.match(text_buffer17.v, "^(%d+):(%d+)$") and tonumber(minutesnot) < 60 and tonumber(minutesnot) >= 0 and tonumber(secondsnot) < 60 and tonumber(secondsnot) >= 0  then
						if text_buffer15.v ~= "" then
							sampAddChatMessage("[AdHelper] Сповіщення успішно ввімкнено.", 0x00FF00)
							notontimer2 = true
							lua_thread.create(function ()
								SendMyState()
							end)
						else
							sampAddChatMessage("[AdHelper] Поле для тексту не може бути пустим!", 0xFF0000)
						end
					
					else
						sampAddChatMessage("[AdHelper] Некоректно введено час!", 0xFF0000)
					end
				end
			else
				if imgui.Button(u8"Стoп##5") then
					notontimer2 = false
				end
			end
			
		end
		


		
		imgui.Separator()
		
		imgui.Checkbox(u8"Розіграш", checked_giv)
		if checked_giv.v then
		    checked_not.v = false
			 
		    imgui.InputText(u8'Назва призу', text_buffer6)
			imgui.InputText(u8"ID учасника", text_buffer7)
            
            if imgui.BeginChild("ChildWindow", imgui.ImVec2(CalculateSizeAndPosX(300),CalculateSizeAndPosY(120)), true) then
			    imgui.Text(GivPlayers)
			    imgui.EndChild()
		    end			
			
			local numberValue = tonumber(text_buffer7.v)
		
			if imgui.Button(u8"Добавити") then
			    if text_buffer7.v == "" then
				    sampAddChatMessage("[AdHelper] Поля не можуть бути пустими", 0xFF0000)
				else
					if sampIsPlayerConnected(text_buffer7.v) then
				        local nick5 = sampGetPlayerNickname(text_buffer7.v)
						if string.match(GivPlayers, nick5) then
						    sampAddChatMessage("[AdHelper] Цей гравець вже є", 0xFF0000)
						else
							GivPlayers = GivPlayers..nick5.."\n"
						end
					else
						sampAddChatMessage("[AdHelper] Цього гравця не існує, або це Ви.", 0xFF0000)
					end
				
				end
				    
			
			end
			imgui.SameLine()
			if imgui.Button(u8"Очистити") then
			    GivPlayers = ""
			
			end
			imgui.SameLine()
			if imgui.Button(u8"Розіграти") then
				if text_buffer6.v == "" or GivPlayers == "" then
			        sampAddChatMessage("[AdHelper] Будь ласка, введіть назву призу або добавте хоча б двох учасників!", 0xFF0000)
		        else
					local player_list = {}
				    for player in string.gmatch(GivPlayers, "[^\r\n]+") do
						table.insert(player_list, player)
					end
					local random_index = math.random(#player_list)
					local random_player = player_list[random_index]
						lua_thread.create(function()
						    wait(1000)
							sampSendChat("/fam <3 Увага! Результат розіграшу на ' "..u8:decode(text_buffer6.v).." ' через 15 сек ")
							wait(5000)
							sampSendChat("/fam <3 Увага! Результат розіграшу на ' "..u8:decode(text_buffer6.v).." ' через 10 сек ")
							wait(5000)
							sampSendChat("/fam <3 Увага! Результат розіграшу на ' "..u8:decode(text_buffer6.v).." ' через 5 сек ")
							wait(5500)
					        sampSendChat("/fam <3 У розіграші на ' "..u8:decode(text_buffer6.v).." ' переміг "..random_player)
					    end)
				    
				end   
			   
			    
			
			end

		
		end
		
		
		imgui.Separator()

		imgui.Checkbox(u8"Моя статистика", checked_stats)
		if checked_stats.v then
			ImguiDrawMyStats()
		end
		imgui.Separator()
		
		
	
		imgui.Checkbox(u8"Статистика на екрані", checked_time)
		if checked_time.v then
			imgui.SameLine()
			if imgui.Button(u8"Налаштування") then
				secondary_window_state.v = false
				main_window_state.v = true
				

				
			end
		end
		timestateinfo = checked_time.v
		if checked_time.v then
			imgui.Checkbox(u8"Статистика замів", checked_info9)
			if checked_info9.v then
				imgui.SameLine()
				imgui.PushItemWidth(sw/12.8)
				imgui.InputTextWithHint(u8"##add_dep",u8"Введіть нік зама", text_buffer18)
				imgui.SameLine()
				imgui.SetCursorPosX(sw/6)
				if imgui.Button(u8"Добaвити") and text_buffer18.v ~= "" then
					lua_thread.create(function ()
						CheckAddDeputy(u8:decode(text_buffer18.v))
					end)
				end
				imgui.SameLine()
				if imgui.Button(u8"Видалити") then
					DeleteDep()
				end
			end

			
		end
		imgui.Separator()
		CheckBoxTax()
		if checked_time.v and not timestateinfo then
		    lua_thread.create(function ()
				SendMyState()
			end)
		end

		imgui.Separator()
		if imgui.Button(u8'Заспавнити транспорт') then
			lua_thread.create(function()
			wait(100)
			sampSendChat('/fam :u2757: Спавн фам карів через 10 секунд! :automobile:')
			wait((10)*1000)
			sampSendChat('/famspawn')
			spawn_check = true
			end)
		end 


		imgui.Separator()
		
		
		imgui.Text("by @BGDN | Version "..script__version..u8" | Слава Україні!")
		
		imgui.SameLine(CalculateSizeAndPosX(900))
		if imgui.Button(u8"FAQ") then
			lua_thread.create(function()
			asyncHttpRequest('GET', 'https://raw.githubusercontent.com/Bogdan4308/Krokus/refs/heads/main/FAQ.txt', nil,
				function(response) 
				if response then
					text_faq = response.text
				end
									
			end)
			end)
			imgui.OpenPopup(u8'FAQ')
		end
		if imgui.BeginPopupModal(u8'FAQ', _, imgui.WindowFlags.NoResize) then
			imgui.Text(u8"--------------------------------------------FAQ--------------------------------------------")
			imgui.PushFont(fontsize_faq)
			imgui.TextColoredRGB(u8:decode(text_faq))
			imgui.PopFont()
			imgui.Text(u8"-------------------------------------------------------------------------------------------")
			if imgui.Button(u8"Закрити") then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		
		
		     
		imgui.End()
	
	end
end

function PlayAudioClick()
	local audioStream = loadAudioStream(getGameDirectory().."\\moonloader\\AdHelper\\audio_click.mp3")
	setAudioStreamState(audioStream, as_action.PLAY)
end

function imguiDrawHeaders()
	local size_button_X = 145
	local size_button_Y = 30
	local state_btn_logs = true
	local state_btn_drive = true
	local state_btn_notpad= true
	local state_btn_active = true
	local state_btn_blacklist = true
	local state_btn_main = true
	if seventh_window_state.v then state_btn_logs = false else state_btn_logs = true end
	if fifth_window_state.v then state_btn_drive = false else state_btn_drive = true end
	if sixth_window_state.v then state_btn_notpad = false else state_btn_notpad= true end
	if third_window_state.v then state_btn_active = false else state_btn_active = true end
	if fourth_window_state.v then state_btn_blacklist = false else state_btn_blacklist = true end
	if secondary_window_state.v then state_btn_main = false else state_btn_main = true end

	if imgui.ButtonClickable(state_btn_main, u8"Головна", imgui.ImVec2(CalculateSizeAndPosX(size_button_X), CalculateSizeAndPosY(size_button_Y))) then
		seventh_window_state.v = false
		secondary_window_state.v = false
		fifth_window_state.v = false
		sixth_window_state.v = false
		fourth_window_state.v = false
		third_window_state.v = false
		secondary_window_state.v = true
		imgui.Process = secondary_window_state.v
		PlayAudioClick()
	end
	imgui.SameLine()
	if imgui.ButtonClickable(state_btn_logs, u8"Логи", imgui.ImVec2(CalculateSizeAndPosX(size_button_X), CalculateSizeAndPosY(size_button_Y))) then
		seventh_window_state.v = true
		secondary_window_state.v = false
		fifth_window_state.v = false
		sixth_window_state.v = false
		fourth_window_state.v = false
		third_window_state.v = false
		imgui.Process = seventh_window_state.v
		lua_thread.create(function ()
			GetLogMoneyForWindow()
		end)
		PlayAudioClick()
	end
	
	imgui.SameLine()
	if imgui.ButtonClickable(state_btn_drive, u8"Керування", imgui.ImVec2(CalculateSizeAndPosX(size_button_X), CalculateSizeAndPosY(size_button_Y))) then
		Users = {}
		DepActive = {}
		InfoFamily = {}
		seventh_window_state.v = false
		secondary_window_state.v = false
		fifth_window_state.v = true
		sixth_window_state.v = false
		fourth_window_state.v = false
		third_window_state.v = false
		imgui.Process = fifth_window_state.v
		check_fmembers = true
		sampSendChat("/fmembers")
		lua_thread.create(function ()
			CheckGitHub()
		end)
		PlayAudioClick()
	end

	imgui.SameLine()
	if imgui.ButtonClickable(state_btn_notpad, u8"Блокнот", imgui.ImVec2(CalculateSizeAndPosX(size_button_X), CalculateSizeAndPosY(size_button_Y))) then
		seventh_window_state.v = false
		secondary_window_state.v = false
		fifth_window_state.v = false
		fourth_window_state.v = false
		sixth_window_state.v = true
		third_window_state.v = false
		imgui.Process = sixth_window_state.v 
		lua_thread.create(function()
			GetNotebookText()
		end)
		PlayAudioClick()
	end

	imgui.SameLine()
	if imgui.ButtonClickable(state_btn_active, u8"Активність", imgui.ImVec2(CalculateSizeAndPosX(size_button_X), CalculateSizeAndPosY(size_button_Y))) then
		Users = {}
		DepActive = {}
		InfoFamily = {}
		seventh_window_state.v = false
		secondary_window_state.v = false
		fifth_window_state.v = false
		fourth_window_state.v = false
		sixth_window_state.v = false
		third_window_state.v = true
		imgui.Process = third_window_state.v 
		lua_thread.create(function ()
			CheckGitHub()
			CheckGitHubActive()
		end)
		number_users_before = 0
		number_users_after = 0
		PlayAudioClick()
	end
	imgui.SameLine()
	if imgui.ButtonClickable(state_btn_blacklist, u8"Чорний список", imgui.ImVec2(CalculateSizeAndPosX(size_button_X), CalculateSizeAndPosY(size_button_Y))) then
		fourth_window_state.v = true
		seventh_window_state.v = false
		secondary_window_state.v = false
		fifth_window_state.v = false
		sixth_window_state.v = false
		third_window_state.v = false
		PlayAudioClick()
	end
	imgui.Separator()
end

local incorrect = false
function ImguiDrawBlackList()
	if fourth_window_state.v then
		imgui.Proccess = fourth_window_state.v
		imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"[AdHelper] | Чорний список | Banderas Family", fourth_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imguiDrawHeaders()
		imgui.PushItemWidth(CalculateSizeAndPosX(130))
		imgui.InputTextWithHint(u8"##6",u8"Пошук",text_buffer9)
		if imgui.BeginChild('ЧС', imgui.ImVec2((sw/2) - CalculateSizeAndPosX(25), (sh/2) - CalculateSizeAndPosY(200)), true) then
			for i, line in ipairs(lineTextBlacklist) do
				local old_nick, old_uid = line:match("(.+) UID: (.+) Причина")
				table.insert(lineUID, old_uid)
				if current_uid == old_uid and not line:find("%f[%a]"..new_nick_uid.."%f[%A]") then
					line = line.." => "..new_nick_uid 
					lineTextBlacklist[i] = line
					lua_thread.create(function ()
						AddBlacklist()
					end)
				end	
				text_buffer9.v = string.gsub(text_buffer9.v, "%p","")
				if string.match(line, u8:decode(text_buffer9.v)) then
					if u8:decode(text_buffer9.v) ~= "" then
						line = string.gsub(line, u8:decode(text_buffer9.v), "{7CFC00}"..u8:decode(text_buffer9.v).."{FFFFFF}")	
					end
					imgui.TextColoredRGB("{FFFFFF}["..i.."] "..line)
					imgui.SameLine()
					if imgui.Button(u8"-##" .. i) then 
						if accessibility then
							table.remove(lineTextBlacklist, i)
							lua_thread.create(function ()
								AddBlacklist()
							end) 
						else
							sampAddChatMessage("[AdHelper] У вас недостатньо прав для здійснення цієї операції!", 0xFF0000)
						end
					end
				end
			end
			
            imgui.EndChild() 
        end
		imgui.PushItemWidth(CalculateSizeAndPosX(130))
		imgui.InputTextWithHint(u8"UID:##5 ",u8"Введіть нік", text_buffer_add_bl)  --text_buffer8
		imgui.SameLine()
		imgui.SetCursorPosX(CalculateSizeAndPosX(190))
		imgui.PushItemWidth(CalculateSizeAndPosX(130))
		imgui.InputTextWithHint(u8"Причина:##6",u8"Введіть UID", text_buffer8)
		imgui.SameLine()
		imgui.SetCursorPosX(CalculateSizeAndPosX(400))
		imgui.PushItemWidth(CalculateSizeAndPosX(130))
		imgui.InputTextWithHint(u8"##7",u8"Введіть причину", text_buffer5)
		imgui.SameLine()
		imgui.SetCursorPosX(CalculateSizeAndPosX(550))
		if imgui.Button(u8"Добавити##3") then
			if u8:decode(text_buffer_add_bl.v) ~= "" and u8:decode(text_buffer_add_bl.v):find("(%w+)_(%w+)") and tonumber(u8:decode(text_buffer8.v)) and u8:decode(text_buffer5.v) ~= "" then
				table.insert(lineTextBlacklist,u8:decode(text_buffer_add_bl.v).." UID: "..u8:decode(text_buffer8.v).." Причина: "..u8:decode(text_buffer5.v)) --u8:decode
				lua_thread.create(function ()
					AddBlacklist()
				end)
			elseif not incorrect then
				incorrect = true
				lua_thread.create(function ()
					wait(5000)
					incorrect = false
				end)
			end
			
		end
		if incorrect then
			imgui.SameLine()
			imgui.TextColoredRGB("{FF0000} Поля заповнено неправильно!")
		end
		if imgui.Button(u8"Оновити") and not check_uid_blacklist then
			check_uid_blacklist = true
			lua_thread.create(function ()
				for i = 0, 999 do
					sampSendChat("/id "..i)
					line_uid = line_uid + 1.921
					if i == 999 then check_uid_blacklist = false end
					if not check_uid_blacklist then
						line_uid = 0 
						break 
					end
					wait(300)
				end
			end)
		end
		imgui.SameLine()
		if imgui.Button(u8"Відправити##2")  then
			new_text_blacklist = ""
			for i, line in ipairs(lineTextBlacklist) do
				new_text_blacklist = new_text_blacklist.."\n"..line
			end
			lua_thread.create(function ()
				SendTelegram("Blacklist: \n"..u8:decode(blacklist_text))
				--print(new_text_blacklist)
				--GetBlackListInfo(u8(new_text_blacklist))
			end) 
		end
		imgui.End()
	end

end

function ImguiDrawMyStats()
	imgui.CenterText(u8"СТАТИСТИКА")
	imgui.Separator()
		
	imgui.Text(u8"Витрачено на оголошення: "..Sum.."$")
	imgui.Text(u8"Час в грі: "..hour..":"..minutes..":"..seconds)
	if coeffi1 < 0.34 then
		imgui.TextColoredRGB("Коеф. активу:{FF0000} "..coeffi1)
	end
	if coeffi1 > 0.33 and coeffi1 < 0.67 then
	    imgui.TextColoredRGB("Коеф. активу:{FFD700} "..coeffi1)
	end
	if coeffi1 > 0.66 then
		imgui.TextColoredRGB("Коеф. активу:{00FF00} "..coeffi1)
		
	end
		
	imgui.Separator()
	imgui.CenterText(u8"ЗАРОБЛЕНО")
	imgui.Separator()
		
	imgui.Text(u8"Зароблено з оголошень: "..formatNumberWithCommas(Earn).."$")
	imgui.SameLine()
	imgui.Text(u8"Зароблено з інвайтів: "..formatNumberWithCommas(InvSum).."$")
	imgui.Text(u8"Зароблено за години: "..formatNumberWithCommas(math.ceil(timeSum)).."$")
	imgui.SameLine()
	imgui.Text(u8"Зароблено всього: "..formatNumberWithCommas(math.ceil(allSum)).."$")
	
end
local search_logs = imgui.ImBuffer(256)
function imguiDrawLogs() 
	if seventh_window_state.v then
	    secondary_window_state.v = false
		imgui.Proccess = seventh_window_state.v
	    imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver)
	    imgui.Begin(u8"[AdHelper] | Логи | Banderas Family", seventh_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imguiDrawHeaders()
		imgui.PushItemWidth(CalculateSizeAndPosX(100))
		imgui.InputTextWithHint("##search", u8"Пошук", search_logs)
		if imgui.BeginChild('Name', imgui.ImVec2((sw/2) - CalculateSizeAndPosX(25), (sh/2) - CalculateSizeAndPosY(157)), true) then
			for i, line in ipairs(logs_money_search) do
				if string.match(line, u8:decode(search_logs.v)) then
					local search_text = string.match(line, u8:decode(search_logs.v))
					if search_text ~= "" then
						line = string.gsub(line,search_text,"{00FF00}"..search_text.."{FFFFFF}")
					end
					imgui.TextColoredRGB("{FFFFFF}"..line)
				end
			end
            imgui.EndChild() 
        end
		if imgui.Button(u8"Вигрузити лог") then
			local date_now = os.date('%d-%m-%Y')..".txt"
			local file = io.open(getGameDirectory().."\\moonloader\\AdHelper\\Логи\\"..date_now, "w")
			if file then
				file:write(logs_money)
				file:close()
			end
			sampAddChatMessage("[AdHelper] Логи успішно завантажено на ваш комп'ютер. Шлях: {FFFFFF}'moonloader//AdHelper//Логи//"..date_now.."'", 0x00FA9A)
			
		end
			
		imgui.End()
	
	end
end
local MaxCoeff = {}
local MaxValue = {}

function imguiDrawActive()
	imguiDrawHeaders()
	local earn_all = 0
	if imgui.BeginChild('Name', imgui.ImVec2(CalculateSizeAndPosX(600), CalculateSizeAndPosY(200)), true) then
		for k, v in ipairs(DepActive) do
			--imgui.Text(DepActive[k].nick..": "..DepActive[k].ad..", "..DepActive[k].inv..", "..DepActive[k].hour)
			local coeffidep = (tonumber(DepActive[k].ad) + tonumber(DepActive[k].inv) + tonumber(DepActive[k].hour)) / 413
			coeffidep = math.ceil(coeffidep * 1000 + 0.1) / 1000
			imgui.PushFont(fontsize_notepad)
			imgui.Text(DepActive[k].nick.." ")
			imgui.PopFont()
			local color_coeffidep = ""
			if coeffidep < 0.34 then
				color_coeffidep =  "{FF0000}"
			end
			if coeffidep > 0.33 and coeffidep < 0.67 then
				color_coeffidep =  "{FFD700}"
			end
			if coeffidep > 0.66 then
				color_coeffidep =  "{00FF00}"
			end
			if imgui.IsItemHovered() then
				imgui.BeginTooltip()
				if accessibility then imgui.TextColoredRGB("Час: "..DepActive[k].hour.." годин\nРеклама: "..DepActive[k].ad.."\nІнвайти: "..DepActive[k].inv.."\nІнвайти з VIP: "..DepActive[k].vip.."\nК.а: "..color_coeffidep..coeffidep.."\nЗароблено: "..DepActive[k].earn.."$\nTG: "..DepActive[k].tg.."\nIP: "..DepActive[k].ip) else imgui.TextColoredRGB("Час: "..DepActive[k].hour.." годин\nРеклама: "..DepActive[k].ad.."\nІнвайти: "..DepActive[k].inv.."\nІнвайти з VIP: "..DepActive[k].vip.."\nК.а: "..color_coeffidep..coeffidep.."\nЗароблено: "..DepActive[k].earn.."$\nTG: "..DepActive[k].tg) end
				imgui.EndTooltip()
			end
			if imgui.IsItemClicked() then
				lua_thread.create(function()
					CheckAddDeputy(DepActive[k].nick)
				end)
			end
			imgui.SameLine()
			imgui.SetCursorPosX(CalculateSizeAndPosX(150))
			imgui.ProgressBar(coeffidep/1.5,imgui.ImVec2(CalculateSizeAndPosX(200),CalculateSizeAndPosY(24)),u8'К/a: '..coeffidep)
			if imgui.IsItemHovered() then
				imgui.BeginTooltip()
				if accessibility then imgui.TextColoredRGB("Час: "..DepActive[k].hour.." годин\nРеклама: "..DepActive[k].ad.."\nІнвайти: "..DepActive[k].inv.."\nІнвайти з VIP: "..DepActive[k].vip.."\nК.а: "..color_coeffidep..coeffidep.."\nЗароблено: "..DepActive[k].earn.."$\nTG: "..DepActive[k].tg.."\nIP: "..DepActive[k].ip) else imgui.TextColoredRGB("Час: "..DepActive[k].hour.." годин\nРеклама: "..DepActive[k].ad.."\nІнвайти: "..DepActive[k].inv.."\nІнвайти з VIP: "..DepActive[k].vip.."\nК.а: "..color_coeffidep..coeffidep.."\nЗароблено: "..DepActive[k].earn.."$\nTG: "..DepActive[k].tg) end
				imgui.EndTooltip()
			end
			MaxCoeff[#MaxCoeff+1] = {
				nick = DepActive[k].nick,
				coeff = coeffidep
			}
			table.insert(MaxValue, coeffidep)
			if DepActive[k].earn then
				local earn_without_point = string.gsub(DepActive[k].earn,"%.","")
				earn_all = earn_all + tonumber(earn_without_point)
			end
		end
		imgui.EndChild()
	end
	
	if number_users_before == number_users_after then
		local max_value = math.max(table.unpack(MaxValue))
		local nick_top_one = ""
		local maxcoeffdep = 0
		for k, v in ipairs(MaxCoeff) do
			if tonumber(MaxCoeff[k].coeff) == max_value then
				nick_top_one = MaxCoeff[k].nick
				maxcoeffdep = tonumber(MaxCoeff[k].coeff)
			end

		end
		imgui.Text(u8"Найактивніший замісник: "..nick_top_one..u8" (К/а: "..maxcoeffdep..")") 
	end

	imgui.Text(u8"Всього зароблено замісниками: "..formatNumberWithCommas(earn_all).."$")
	MaxCoeff = {}
	MaxValue = {}
end

function DeleteDep()
	if text_buffer18.v == nickDep1 then
		nickDep1 = ""
		AdDep1 = ""
		InvDep1 = ""
		HourDep1 = ""
	elseif text_buffer18.v == nickDep2 then
		nickDep2 = ""
		AdDep2 = ""
		InvDep2 = ""
		HourDep2 = ""
		
	elseif text_buffer18.v == nickDep3 then
		nickDep3 = ""
		AdDep3 = ""
		InvDep3 = ""
		HourDep3 = ""				
	else
		sampAddChatMessage("[AdHelper] Помилка...", 0xFF0000)
	end
	lua_thread.create(function()
		SendMyState()
	end)
	
end
local TimerTasks = 0
local color_info_notebook = {"{00FF00}", "{FFFFFF}", "{00BFFF}", "{8A2BE2}", "{FF0000}", "{FF1493}", "{FFFF00}"} 
local color_text_notebook = ""
local public_notepad = false
local private_notepad = true
local load_spinner = false
function imguiDrawTasks()
	if sixth_window_state.v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/ 2 , sh / 2 ), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"[AdHelper] | Блокнот | Banderas Family", sixth_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imguiDrawHeaders()
		if imgui.BeginChild('Name', imgui.ImVec2(CalculateSizeAndPosX(600), CalculateSizeAndPosY(200)), true) then
			if not public_notepad then
				for line in notebook_text:gmatch("[^\n]+") do
					imgui.PushFont(fontsize_notepad) 
					imgui.TextColoredRGB(u8:decode(line))
					imgui.PopFont()
					if imgui.IsItemClicked() then
						local nick_answer = line:match("(%w+_%w+):")
						text_buffer_notebook.v = "{FFA500}[to "..nick_answer.."]: "..color_text_notebook
					end
				end
				
			else
				local file = io.open(getGameDirectory().."\\moonloader\\AdHelper\\MyNotepad.txt", "r")
				if file then
					text_private_notepad = file:read("*all")
					lineTextPrivate = {}
					for line in text_private_notepad:gmatch("[^\n]+") do
						table.insert(lineTextPrivate, u8:decode(line))
					end
					file:close()
				else
					local file = io.open(getGameDirectory().."\\moonloader\\AdHelper\\MyNotepad.txt", "w")
				end
				for line in text_private_notepad:gmatch("[^\n]+") do
					imgui.PushFont(fontsize_notepad) 
					imgui.TextColoredRGB(u8:decode(line))
					imgui.PopFont() 
				end
				
			end
			imgui.EndChild()
		end
		imgui.SameLine()
		if imgui.ButtonClickable(public_notepad, u8"Публічний") then
			private_notepad = true
			public_notepad = false
		end
		imgui.SameLine()
		if imgui.ButtonClickable(private_notepad, u8"Приватний") then
			private_notepad = false
			public_notepad = true
			
		end
		imgui.PushItemWidth(CalculateSizeAndPosX(100))
		imgui.Combo(u8' ',ComboColors,color_list, #color_list)
		color_text_notebook = color_info_notebook[ComboColors.v + 1]
		imgui.SameLine()
		imgui.PushItemWidth(CalculateSizeAndPosX(480))
		imgui.InputText(u8"##Tasks", text_buffer_notebook)
		if text_buffer_notebook.v == "" then
			state_button_send = false
		elseif send_message then
			state_button_send = true
		end
		if text_buffer_notebook.v:find('"') then
			text_buffer_notebook.v = string.gsub(text_buffer_notebook.v,'"','')
		end
		if text_buffer_notebook.v:find("'") then
			text_buffer_notebook.v = string.gsub(text_buffer_notebook.v,"'","")
		end
		imgui.SameLine()
		if imgui.ButtonClickable(state_button_send, u8"Відправити") then
			send_message = false
			load_spinner = true
			if not public_notepad then
				state_button_send = false
				TimerTasks = os.clock()
				lua_thread.create(function ()
					SendMyTextNotebook(color_text_notebook)
				end)
				sampAddChatMessage("[AdHelper] Зачекайте декілька секунд...", 0xFFDAB9)
			else
				text_private_notepad = "{FFFFFF}"..os.date('%d/%m/%Y [%X] ')..": "..color_text_notebook..text_buffer_notebook.v.."\n"..text_private_notepad
				local file = io.open(getGameDirectory().."\\moonloader\\AdHelper\\MyNotepad.txt", "w")
				if file then
					file:write(text_private_notepad)
					file:close()
				end

			end
			
		end
		if load_spinner and not public_notepad then imgui.SameLine() imgui.Spinner("##spinner", 10, 3, imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered])) end
		if imgui.Button(u8'Налаштування') then
			imgui.OpenPopup(u8'Налаштування##2')
		end
		if imgui.BeginPopupModal(u8'Налаштування##2', _, imgui.WindowFlags.NoResize) then
			imgui.SetNextWindowSize(imgui.ImVec2(CalculateSizeAndPosX(500), CalculateSizeAndPosY(190))) 
			imgui.Text(u8'Щоб змінити позицію тексту, перетягніть його ЛКМ в потрібну зону екрана')
			imgui.PushItemWidth(CalculateSizeAndPosX(10))
			if ffi.C.GetAsyncKeyState(VK_LBUTTON) ~= 0 then
				local CursX, CursY = getCursorPos()
				if CursX - PosPadX <= 200 then
					if CursY - PosPadY <= 150 then
						PosPadX = CursX - CalculateSizeAndPosX(20)
						PosPadY = CursY - CalculateSizeAndPosY(20)
					end
				end
			end
			imgui.Checkbox(u8"Текст на екрані", checked_notepad)
			if checked_notepad.v then 
				imgui.PushItemWidth(CalculateSizeAndPosX(120))
				imgui.SliderInt(u8"Розмір шрифта", slider_font_size, 1, 20)
				font_notepad = renderCreateFont("Calibri", slider_font_size.v, slider_font_family.v)
				imgui.SameLine()
				imgui.SliderInt(u8"Шрифт", slider_font_family, 0, 25)
			end
			imgui.Separator()
			imgui.SetCursorPosX(CalculateSizeAndPosX(165))
			if imgui.Button(u8'Зберегти##5') then 
				lua_thread.create(function()
					SendMyState()
				end)
				imgui.CloseCurrentPopup()
			end

			imgui.SameLine()
			if imgui.Button(u8'Закрити') then 
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.End()
	end
	if os.clock() - TimerTasks > 5 then
		if not send_message then
			send_message = true
		end
		if not state_button_send then
			state_button_send = true
		end
		if load_spinner then
			load_spinner = false
		end
		lua_thread.create(function()
			GetNotebookText()
		end)
		TimerTasks = os.clock()
	end
	
end

function imgui.ButtonClickable(clickable, ...)
    if clickable then
        return imgui.Button(...)

    else
        local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
        imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
            imgui.Button(...)
        imgui.PopStyleColor()
        imgui.PopStyleColor()
        imgui.PopStyleColor()
        imgui.PopStyleColor()
    end
end

function CheckAddDeputy(nick)
	if  nickDep1 ~= nick and nickDep2 ~= nick and nickDep3 ~= nick then
		if os.clock() - TimerReq > 10 then
			AddDeputy(nick)
			TimerReq = os.clock()
		else
			sampAddChatMessage("[AdHelper] Зачекайте 10 секунд.", 0xFF0000)
		end
	else
		sampAddChatMessage("[AdHelper] Цей гравець вже добавлений.", 0xFF0000)
	end
	
end

function AddBlacklist()
	new_text_blacklist = ""
	for i, line in ipairs(lineTextBlacklist) do
		new_text_blacklist = new_text_blacklist.."\n"..line
	end
	GetBlackListInfo(u8(new_text_blacklist))
end


function AddDeputy(nick)
	if nickDep1 ~= "" and nickDep2 ~= "" and nickDep3 ~= "" then nickDep1 = "" end
	file_path = nick..".txt"
	local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path, branch)

    asyncHttpRequest("GET", sha_url, {
       headers = {
            ["Authorization"] = "token " .. api_token
        }
    }, function(response)

        local file_info = json.decode(response.text)
        local sha = file_info.sha
        local encoded_content = file_info.content
		if encoded_content ~= nil then
			local decoded_content = base64.decode(encoded_content)
        	local info = decodeJson(decoded_content)
			if nickDep1 == "" then
				AdDep1 = tonumber(info.Ad)
				InvDep1 = tonumber(info.Inv)
				HourDep1 = tonumber(info.Hour)
				nickDep1 = nick
			elseif nickDep2 == "" then
				AdDep2 = tonumber(info.Ad)
				InvDep2 = tonumber(info.Inv)
				HourDep2 = tonumber(info.Hour)
				nickDep2 = nick
				
			elseif nickDep3 == "" then
				AdDep3 = tonumber(info.Ad)
				InvDep3 = tonumber(info.Inv)
				HourDep3 = tonumber(info.Hour)
				nickDep3 = nick
			end
			SendMyState()
		else
			sampAddChatMessage("[AdHelper] "..nick.." не замісник або не використовує скріпт.", 0xFF0000)
        end
    end)
 
end

function CheckDeputy()
	if nickDep1 ~= "" then
		file_path = nickDep1..".txt"
		local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path, branch)

    	asyncHttpRequest("GET", sha_url, {
       	headers = {
            ["Authorization"] = "token " .. api_token
        }
    	}, function(response)

        	local file_info = json.decode(response.text)
        	local sha = file_info.sha
        	local encoded_content = file_info.content
			if encoded_content ~= nil then
				local decoded_content = base64.decode(encoded_content)
        		local info = decodeJson(decoded_content)
				AdDep1 = tonumber(info.Ad)
				InvDep1 = tonumber(info.Inv)
				HourDep1 = tonumber(info.Hour)
			end
    	end)
	end
	if nickDep2 ~= "" then
		file_path = nickDep2..".txt"
		local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path, branch)

    	asyncHttpRequest("GET", sha_url, {
       	headers = {
            ["Authorization"] = "token " .. api_token
        }
    	}, function(response)

        	local file_info = json.decode(response.text)
        	local sha = file_info.sha
        	local encoded_content = file_info.content
			if encoded_content ~= nil then
				local decoded_content = base64.decode(encoded_content)
        		local info = decodeJson(decoded_content)
				AdDep2 = tonumber(info.Ad)
				InvDep2 = tonumber(info.Inv)
				HourDep2 = tonumber(info.Hour)
			end
    	end)
	end
	if nickDep3 ~= "" then
		file_path = nickDep3..".txt"
		local sha_url = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s", repo, file_path, branch)

    	asyncHttpRequest("GET", sha_url, {
       	headers = {
            ["Authorization"] = "token " .. api_token
        }
    	}, function(response)

        	local file_info = json.decode(response.text)
        	local sha = file_info.sha
        	local encoded_content = file_info.content
			if encoded_content ~= nil then
				local decoded_content = base64.decode(encoded_content)
        		local info = decodeJson(decoded_content)
				AdDep3 = tonumber(info.Ad)
				InvDep3 = tonumber(info.Inv)
				HourDep3 = tonumber(info.Hour)
			end
    	end)
	end
	
end

function GetMyUID()
	local result, my_id = sampGetPlayerIdByCharHandle(playerPed)
	check_my_uid = true
	sampSendChat("/id "..my_id)
end

function sampev.onSendSpawn()
	checked_tax.v = false
	if checked_tax.v then
		lua_thread.create(function ()
		paytax = true
		wait(500)
		sampSendChat("/fammenu")
		wait(200)
		ffi.C.SetCursorPos(sw/1.65, sh/2) 
		setVirtualKeyDown(1, true) 
		wait(10) 
		setVirtualKeyDown(1, false)
		end)
	end
end
function cmd_tax()
	--sampSendChat("/fammenu")
	--paytax = true
end



function imgui.InputTextWithHint(label, hint, buf, flags, callback, user_data)
    local l_pos = {imgui.GetCursorPos(), 0}
    local handle = imgui.InputText(label, buf, flags, callback, user_data)
    l_pos[2] = imgui.GetCursorPos()
    local t = (type(hint) == 'string' and buf.v:len() < 1) and hint or '\0'
    local t_size, l_size = imgui.CalcTextSize(t).x, imgui.CalcTextSize('A').x
    imgui.SetCursorPos(imgui.ImVec2(l_pos[1].x + 8, l_pos[1].y + 2))
    imgui.TextDisabled((imgui.CalcItemWidth() and t_size > imgui.CalcItemWidth()) and t:sub(1, math.floor(imgui.CalcItemWidth() / l_size)) or t)
    imgui.SetCursorPos(l_pos[2])
    return handle
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end


function formatNumberWithCommas(allSum)
    local formattedNumber = tostring(allSum)
    local reverseFormatted = string.reverse(formattedNumber)
    local result = ""

    for i = 1, #reverseFormatted do
        result = result .. reverseFormatted:sub(i, i)
        if i % 3 == 0 and i ~= #reverseFormatted then
            result = result .. "."
        end
    end

    return string.reverse(result)
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4
    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end
    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImVec4(r/255, g/255, b/255, a/255)
    end
    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end
    render_text(text)
end

function flooder_fam_check()
	while true do wait(0)
		if not sampIsDialogActive() and sampIsLocalPlayerSpawned() and not active then
			if checked_online_screen.v  or fifth_window_state.v then
				check_fmembers = true
				sampSendChat("/fmembers")
			end
		end
		wait(1000*10)
	end
end
function sampev.onShowDialog(id, st, tytle, button, canc, text)
	if id == 25624 and not_vr then
		sampSendDialogResponse(25624, 1, nil, nil)
		not_vr = false
		return false
	end
	if take_salary then
		if not sampIsDialogActive() then
			if id == 2763  then
				sampSendDialogResponse(2763, 1, 5, nil)
			end
			if id == 2765 then
				sampSendDialogResponse(2765, 1, nil, math.ceil(allSum))
				take_salary = false
			end
			return false
		end
	end
	local tax = 0
	if not sampIsDialogActive() and paytax then 
		if id == 2763 then
			local taxonfam = string.match(text, "Оплатить налог на квартиру %[%$(.+) /")
			if taxonfam then
				if string.match(taxonfam, "%p") then
					taxonfam = string.gsub(taxonfam, "%p","")
				end
				tax = tonumber(taxonfam)
				if tonumber(tax) >= 50000 then
					sampSendDialogResponse(2763, 1, 10, nil)
				else
					sampAddChatMessage("[AdHelper] Податок на сімейну квартиру: "..tax.."$", 0x008000)
					paytax = false
				end
			end
		end
		return false
	end
	if id == 15247 and paytax then
		sampSendDialogResponse(15247, 1, nil, tax)
		paytax = false
		return false
	end
	if id == 25477 and checked_piar.v and active then 
		local min_time = 0
		local zmi_time = {}
		local zmi_amount = {}
		piar_zmi_timer = os.clock()
		for line in text:gmatch("[^\n]+") do
			if line:find("Последняя редакция") then
				line = ""
			elseif line:find("шт.") then
				number_adv, line = string.match(line, "(%d+) шт.(.+)")
				table.insert(zmi_amount, tonumber(number_adv))
			elseif line:find("отсутствуют") then
				table.insert(zmi_amount, 0)
				line = string.match(line, "отсутствуют(.+)")
			end
			if line then
				line = string.gsub(line," ", "")
				if line:find("час") then
					local ad_hour, ad_minutes, ad_seconds = string.match(line, "(%d+)час(%d+)мин(%d+)секназад")
					table.insert(zmi_time, tonumber(ad_hour)*3600 + tonumber(ad_minutes)*60+tonumber(ad_seconds))
				elseif not line:find("час") and line:find("мин") then
					local ad_minutes, ad_seconds = string.match(line, "(%d+)мин(%d+)секназад")
					table.insert(zmi_time, tonumber(ad_minutes)*60+tonumber(ad_seconds))
				elseif not line:find("час") and not line:find("мин") and line:find("секназад") then
					local ad_seconds = string.match(line, "(%d+)секназад")
					table.insert(zmi_time, tonumber(ad_seconds))
				end
			end
		end
		min_time = zmi_time[1]
		local index = 1
		local radiostatoin = ""
		for i, v in ipairs(zmi_time) do
			if v < min_time then
				min_time = v
				index = i
			end
		end
		if index == 1 then radiostatoin = "LS" elseif index == 2 then radiostatoin = "LV" elseif index == 3 then radiostatoin = "SF" end
		sampAddChatMessage("[AdHelper]{00FA9A} Ваше оголошення відправлено в Радіостанцію {F0E68C}"..radiostatoin.."{00FA9A} під номером {F0E68C}"..zmi_amount[index]+1, 0xF0E68C)
		sampSendDialogResponse(25477, 1, index-1, nil)
		return false
	end
	if id == 15346 and checked_piar.v and active then sampSendDialogResponse(15346, 1, nil, nil) return false end
	if id == 15347 and checked_piar.v and active then sampSendDialogResponse(15347, 1, nil, nil) ad_piar_delay = false piar_zmi_timer = os.clock() active = false return false end
	if id == 15379 and checked_piar.v and active then sampSendDialogResponse(15379, 1, nil, nil) sampSendChat("/ad Семья Banderas ищет друзей") return false end
	if check_fmembers then
		if not sampIsDialogActive() and sampIsLocalPlayerSpawned() and not active then 
			if tytle:find('{BFBBBA}Члены семьи онлайн') and id == 25528 then
				sampSendDialogResponse(id, 1, 0, nil)
			end
			if tytle:find('{BFBBBA}{FFFFFF}(.+)%(В сети: (%d+)%) | {ae433d}Семья') and id == 1488 then
				local next_page = 0
				local count = 0
				local go_next_dialog = false
				InfoFamily = {}
				local fam_name, fam_online = tytle:match('{FFFFFF}(.+)%(В сети: (%d+)%).+')
				InfoFamily[#InfoFamily+1] = {
					name = fam_name,
					online = fam_online
				}
				for line in text:gmatch("[^\n]+") do
					count = count + 1
					if line:find('%((.+)%) (.+)%((.+)%) %[(.+)%].+%.%s*(.+)') then
						local rank, nick, idp, lvl, quest, afk = line:match('%((.+)%) (.+)%((.+)%) %[(.+)%].+%)(.+)%/.+%.%s*(.+)')
						local color = string.format('%06X', bit.band(sampGetPlayerColor(idp),  0xFFFFFF))
						members[#members + 1] = {
							color = color,
							rank = rank,
							nick = nick,
							idp = idp,
							lvl = lvl,
							afk = afk,
							quest = quest
						}
					end
					if line:match('Следующая страница') then
						go_next_dialog = true
						next_page = count - 2
					end
				end

				if go_next_dialog then
					sampSendDialogResponse(id, 1, next_page, _) 
					go_next_dialog = false
					next_page = 0
				else
					sampSendDialogResponse(id, 0, _, _)
					staff_family = members
					members = {}
					check_fmembers = false
				end
			end
			return false
		else
			check_fmembers = false
		end
	end
	if id == 26037 and spawn_check then sampSendDialogResponse(26037, 1, nil, nil) spawn_check = false return false end
	
	if id == 0 and numberpl then return false end
end











