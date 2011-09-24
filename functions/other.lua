local M,L = unpack(select(2,...))

local pairs = pairs
local _G = _G

-- "PLAYER ENTERING WORLD" load
local n_enter = 0
local enterload = {}

local frame = CreateFrame("Frame")
frame:Hide()
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent",function(self)
	self:SetScript("OnEvent",nil)
	self:UnregisterAllEvents()
	M.scale = UIParent:GetScale()
	if n_enter~=0 then
		for i=1,#enterload do enterload[i]() end
	end
	wipe(enterload)
	enterload = nil
	self:Show()
end)

M.addenter = function(f)
	n_enter = n_enter + 1
	enterload[n_enter] = f
end

-- 3 Seconds after player entering world load
local n_after = 0
local afterload = {}
-- 1 second after 3 seconds load
local n_last = 0
local lastload = {}

local get_chan = function()
	local lang_st = {}
	for i=1,GetNumDisplayChannels() do
		local n,_,_,g = GetChannelDisplayInfo(i)
		if g then lang_st[g] = n end
	end
	if lang_st[1] == nil then return end
	return lang_st
end

local reset_load = function(self,t)
	self.n = self.n - t; if self.n > 0 then return end; self.n = 1;
	if not InCombatLockdown() then
		self:SetScript("OnUpdate",nil)
		self:Hide()
		if n_last~=0 then
			for i=1,#lastload do lastload[i]() end
		end
		lastload = nil
		n_enter = n_enter<10 and "0"..n_enter or n_enter
		n_after = n_after<10 and "0"..n_after or n_after
		n_last = n_last<10 and "0"..n_last or n_last
		print("DerpyMedia: Loaded - |cff00ffff"..n_enter.."//"..n_after.."//"..n_last.."|r")
		print(L['hello_world'])
		n_enter,n_after,n_last = nil,nil,nil
		collectgarbage("collect")
	else
		self.n = 1
	end
end

frame.n = 3 
frame:SetScript("OnUpdate",function(self,t)
	self.n = self.n - t; if self.n > 0 then return end; self.n = 1;
	M.lang_st = get_chan();
	if not InCombatLockdown() and M.lang_st then
		self:Hide()
		if n_after~=0 then
			for i=1,#afterload do afterload[i]() end
		end
		afterload = nil
		self:SetScript("OnUpdate",reset_load)
		self:Show()
	else
		self.n = 1
	end
end)

M.addafter = function(f) 
	n_after = n_after + 1
	afterload[n_after] = f
end

M.addlast = function(f) 
	n_last = n_last + 1
	lastload[n_last] = f
end

-- null function
M.null = function() end

-- destroy function
M.kill = function(self,donthide,point)
	if not self then return end
	if self.UnregisterAllEvents then self:UnregisterAllEvents() end
	if self.SetPoint and not(point) then self.SetPoint = M.null end
	if self.Show then self.Show = M.null end
	if not donthide then self:Hide() end
	if self.Hide then self.Hide = M.null end
end

--Check nils
M.check_nil = function(var,x)
	if var == nil then 
		if x == nil then x = true end
		return x
	else
		return var 
	end
end

--Worgen!!!
M.fixworgen = function(self)
	local model = self:GetModel()
	if not model then self:SetCamera(0) return end
	if not model.find then self:SetCamera(0) return end
	if not model:find("worgenmale") then self:SetCamera(0) return end
	self:SetCamera(1)
end

--destroy self textures
M.un_custom_regions = function(self,start,stop)
	for i=start,stop do
		local x = select(i,self:GetRegions())
		if x.SetTexture then
			x:SetTexture(nil)
		end
	end
end

local find = string.find
M.untex = function(self,force)
	if not self then return end
	local a = self:GetNumRegions()
	if not a or a == 0 then return end
	for i=1,a do
			local x = select(i,self:GetRegions())
			if x.SetTexture and not(x:GetName() and find(x:GetName(),"Icon")) then
				x:SetTexture(nil)
				--x.SetTexture = M.null
				--x.Show = M.null
				x:Hide()
				
			elseif x.SetFont and not force then
				x:SetText(nil)
				--x.SetText = M.null
				x:Hide()
			end
			-- if x.SetFont and force then
				-- print(i)
			-- end
	end
end

local _enter = function(self)
	self.bg:backcolor(self.bg.r,self.bg.g,self.bg.b,.8)
end
local _leave = function(self)
	self.bg:backcolor(0,0,0)
end
M.enterleave = function(self,r,g,b)
	if not self.bg then return end
	self:HookScript("OnEnter",_enter)
	self:HookScript("OnLeave",_leave)
	self.bg.r = r or 1
	self.bg.g = g or 1
	self.bg.b = b or 1
end

local tex_scroll = function(self)
	if self.bg then return end
	M.untex(self)
	local x = M.frame(self,self:GetFrameLevel(),self:GetFrameStrata())
	x:points()
	self.bg = x
	M.enterleave(self,1,1,1)
end
	
M.unscroll = function(frame)
	local name = frame:GetName()
	local _G = _G
	if _G[name.."BG"] then _G[name.."BG"]:SetTexture(nil) end
	if _G[name.."Track"] then _G[name.."Track"]:SetTexture(nil) end
	if _G[name.."Top"] then
		_G[name.."Top"]:SetTexture(nil)
		_G[name.."Bottom"]:SetTexture(nil)
		_G[name.."Middle"]:SetTexture(nil)
	end
	if _G[name.."ScrollDownButton"] then
		tex_scroll(_G[name.."ScrollDownButton"])
	end
	if _G[name.."ScrollUpButton"] then
		tex_scroll(_G[name.."ScrollUpButton"])
	end
	if frame:GetThumbTexture() then
			frame:GetThumbTexture():SetTexture(nil)
			if not frame.bg then
				frame.bg = M.frame(frame,frame:GetFrameLevel(),frame:GetFrameStrata())
				frame.bg:points(frame:GetThumbTexture())
				M.enterleave(frame,1,1,1)
			end
	end	
end

local x = CreateFrame"Frame"
x:RegisterEvent"ADDON_LOADED"
x:SetScript("OnEvent",function(self,event,arg)
	if arg ~= "DerpyMedia" then return end
	self = nil; x=nil;
	if not _G.DerpyMediaVars then
		_G.DerpyMediaVars = {
			["font_replace"] = true,
			["scale_lock"] = true,
			["font_offset"] = 4,
		}
	end
end)
