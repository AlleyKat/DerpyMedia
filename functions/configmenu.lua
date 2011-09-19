local M,L = unpack(select(2,...))

local enter = function(self) M.backcolor(self,1,.7,.2,.8); self.t:SetTextColor(1,.7,.2) end
local leave = function(self) M.backcolor(self,0,0,0); self.t:SetTextColor(1,1,1) end
local click = function(self) self.func(); self:GetParent():hide_() end

local CreateButton = function(p,func,name)
	local a = CreateFrame("button",nil,p)
	a:SetFrameLevel(34)
	a:SetFrameStrata("HIGH")
	a:RegisterForClicks("AnyDown")
	M.ChangeTemplate(a)
	a:SetSize(100,30)
	
	local t = M.setfont(a,12)
	t:SetPoint("CENTER")
	t:SetText(name)
	a.t = t
	a.func = func
	
	a:SetScript("OnEnter",enter)
	a:SetScript("OnLeave",leave)
	a:SetScript("OnClick",click)
	return a
end	

local frame
M['call'].menu = function()
	if frame then frame:Show() return end
	local names = {
		["ouf_wiskas"] = "oUF Wiskas",
		["ActionBars"] = "Action Bars",
		["buffs"] = "Buffs",
		["chat"] = "Chat",
		["mis"] = "Miscellaneous",
		["tool_"] = "Nameplates",
		["chatbar"] = "Chatbar",
		['xct'] = "|cffff0000x|rCT"}
	frame = M.frame(UIParent,30,"HIGH")
	frame:Hide()
	M.mkfade(frame)
	frame:SetWidth(140)
	frame:SetPoint("CENTER",0,1)
	local i = 0
	CreateButton(frame,ReloadUI,"Reload UI"):SetPoint("TOP",0,-30*i - 24); i = i + 1
	for p,y in pairs (M['call']) do
		if names[p] then
			CreateButton(frame,y,names[p]):SetPoint("TOP",0,-30*i - 24); i = i + 1
		end
	end
	CreateButton(frame,M.resetdeff,"Reset All"):SetPoint("TOP",0,-30*i - 24); i = i + 1
	CreateButton(frame,function() frame:hide_() end,L["close"]):SetPoint("TOP",0,-30*i - 24); i = i + 1
	frame:SetScript("OnShow",function(self)
		self.fd:Hide()
		UIFrameFadeIn(self,.7,0,1)
	end)
	frame:SetHeight(i*30 + 48)
	frame:Show()
end