local M,L = unpack(select(2,...))

local floor = floor
local mainframe = M.frame(UIParent,10,"HIGH")
mainframe:SetWidth(140)
mainframe:SetPoint("CENTER")
mainframe:Hide()
M.make_plav(mainframe,.5)

M.show_config = function() mainframe:show() end

local top_cir = M.cut_circle(mainframe,10,"HIGH",450)
top_cir:SetSize(140,58)
top_cir:SetPoint("BOTTOM",mainframe,"TOP",0,-2)
top_cir.t:SetPoint("CENTER",top_cir,0,-44)
top_cir.t:SetVertexColor(.8,.8,0)

local bg = CreateFrame("Frame",nil,top_cir)
bg:SetFrameLevel(11)
bg:SetAlpha(.9)

local t_shadow = top_cir:CreateTexture(nil,"OVERLAY")
t_shadow:SetPoint("TOPLEFT",4,-4)
t_shadow:SetPoint("BOTTOMRIGHT",-4,4)
t_shadow:SetTexture(M.media.blank)
t_shadow:SetGradientAlpha("VERTICAL",0,0,0,.05,0,0,0,.85)

local title = M.setfont(bg,31,nil,"OVERLAY")
title:SetPoint("TOP",top_cir,0,-4)
title:SetText("DERPY")

local bottitle = M.setfont(bg,20,nil,"OVERLAY")
bottitle:SetPoint("BOTTOM",top_cir,0,5)
bottitle:SetText("USER INTERFACE")

local bot_cir = M.cut_circle(mainframe,10,"HIGH",450)
bot_cir:SetSize(140,58)
bot_cir:SetPoint("TOP",mainframe,"BOTTOM",0,2)
bot_cir.t:SetPoint("CENTER",bot_cir,0,44)
bot_cir.t:SetVertexColor(.8,.8,0)

local t_shadow = bot_cir:CreateTexture(nil,"OVERLAY")
t_shadow:SetPoint("TOPLEFT",4,-4)
t_shadow:SetPoint("BOTTOMRIGHT",-4,4)
t_shadow:SetTexture(M.media.blank)
t_shadow:SetGradientAlpha("VERTICAL",0,0,0,.85,0,0,0,.05)

local bg = CreateFrame("Frame",nil,bot_cir)
bg:SetFrameLevel(11)
bg:SetAlpha(.9)

local alphaisalpha = M.setfont(bg,32,nil,"OVERLAY")
alphaisalpha:SetPoint("CENTER",bot_cir)
alphaisalpha:SetText("|cffff0000ALPHA|r")

local current_width = 0
mainframe.extend = function(self,ex)
	current_width = current_width + ex
	self:SetHeight(current_width)
end

mainframe:extend(16)

local lastbutton
local num = 1
local _tti = function(self) 
	self:backcolor(0,0,0)
	self.pr = false
	self.name:SetTextColor(1,1,1)
end
local _tty = function(self)
	if mainframe.pressed then
		if mainframe.pressed == self then return end
		mainframe.pressed:_tti()
	end
	self:backcolor(0,1,1,.6) 
	self.pr = true 
	self.name:SetTextColor(0,1,1)
	mainframe.pressed = self
	self.target:init()
end
local en = function(self)
	if self.pr == true then return end 
	self:backcolor(1,1,0,.6) 
	self.name:SetTextColor(1,1,0)
end
local le = function(self) 
	if self.pr == true then return end 
	self:backcolor(0,0,0)
	self.name:SetTextColor(1,1,1)
end

mainframe.gen_button = function(self,target,namet,func)
	local x = CreateFrame("Button","DerpyConfButton_"..num,self)
	M.style(x)
	M.setbackdrop(x)
	x:SetSize(120,28)
	x:RegisterForClicks("AnyDown")
	if lastbutton then
		x:SetPoint("TOP",lastbutton,"BOTTOM")
	else
		x:SetPoint("TOP",self,0,-8)
	end
	lastbutton = x
	if func then
		x:SetScript("OnClick",func)
	else
		x:SetScript("OnClick",_tty)
		x.target = target
		target.tbt = x
		x._tti = _tti
	end
	x:SetScript("OnEnter",en)
	x:SetScript("OnLeave",le)
	local name = M.setfont(x,14)
	name:SetPoint("CENTER",x)
	name:SetText(namet)
	x.name = name
	self:extend(28)
	return x
end

mainframe:gen_button(nil,"RELOAD UI",function() ReloadUI() end)
M.main_config = mainframe

M.addenter(function()
	mainframe:gen_button(nil,"CLOSE",function(self) self:GetParent():Hide() end)
	mainframe.gen_button = nil
	M.make_settings_template = nil
	mainframe.extend = nil
end)

local right_bg = M.frame(mainframe,10,"HIGH")
right_bg:SetPoint("LEFT",mainframe,"RIGHT",-2,0)

local init_width = M.simple_width
local init_height = M.simple_height

right_bg.wpos = 0
right_bg.hpos = 0

local finish_h = function(self)
	self.pa:move(self.next_w)
	self:run_width(self.next_w)
end

local finish_w = function(self)
	self.curent:show()
end

right_bg.run_width = function(self,x)
	local a = floor(self:GetWidth()+.5)
	if a <= x then
		self.wspeed = 300
		self.wmod = 1
	else
		self.wspeed = -300
		self.wmod = -1
	end
	self.wlimit = x
	self.finish_function = finish_w
	self:SetScript("OnUpdate",init_width)
end

right_bg.run_height = function(self,x)
	local a = floor(self:GetHeight()+.5)
	if a <= x then
		self.hspeed = a==0 and 2000 or 300
		self.hmod = 1
	else
		self.hspeed = -300
		self.hmod = -1
	end
	self.hlimit = x
	self.finish_function = finish_h
	self:SetScript("OnUpdate",init_height)
end

mainframe.point_1 = "CENTER"
mainframe.point_2 = "CENTER"
mainframe.pos = 0
mainframe.hor = true
mainframe.parent = UIParent

local move_update = M.simple_move 
mainframe.move = function(self,w)
	self:SetScript("OnUpdate",nil)
	local point = floor((w+2)/2)
	if point >= -self.pos then
		self.mod = -1
		self.limit = -point
		self.speed = -150
	else
		self.mod = 1
		self.limit = -point
		self.speed = 150
	end
	self:SetScript("OnUpdate",move_update)
end

right_bg.pa = mainframe
right_bg.init = function(self,new,w,h)
	self:SetAlpha(1)
	if self.curent then 
		self.curent:Hide()
	end
	self.curent = new
	self:SetScript("OnUpdate",nil)
	self.next_w = w
	self:run_height(h)
end

local init_ = function(self)
	right_bg:init(self,self.w,self.h)
end

M.make_settings_template = function(name,size_w,size_h)
	local x = CreateFrame("Frame","DerpySettingsTemplate"..name,right_bg)
	x:SetPoint("TOPLEFT",4,-4)
	x:SetPoint("BOTTOMRIGHT",-4,4)
	x:SetFrameLevel(11)
	x.w = size_w
	x.h = size_h
	x.init = init_
	M.make_plav(x,.2)
	x:hide()
	mainframe:gen_button(x,name)
	return x
end
