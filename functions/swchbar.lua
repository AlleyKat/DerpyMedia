-- M.makevarbar -- FUNCTION ( PARENT, WIDTH, MINIMUM, MAXIMUM, TABLE, VARNAME(IN TABLE), NAME) -- returns bar
local M = unpack(select(2,...))
local colors = M.media.button

local setbg = function(frame,r,g,b,a)
	frame:SetBackdrop(M.bg)
	frame:SetBackdropColor(r,g,b,a)
	frame:SetBackdropBorderColor(r,g,b,a)
end

local setbar_value = function(self)
	local mods = self.act*((self.value[self.var])/self.max)
	if mods > 7 and mods <= self.act then
		self:SetWidth(mods)
	elseif mods > self.act then
		self:SetWidth(self.act)
	else
		self:SetWidth(6)
	end
	self.text:SetText(self.value[self.var])
end

local anim = function(self,off)
	self.in_s = self:CreateAnimationGroup("IN")
	self.in_s.a = self.in_s:CreateAnimation("Translation")
	self.in_s.a:SetOffset(-off,0)
	self.in_s.a:SetDuration(0)
	self.in_s.a:SetOrder(1)
	self.in_s.c = self.in_s:CreateAnimation("ALPHA")
	self.in_s.c:SetChange(-1)
	self.in_s.c:SetOrder(1)
	self.in_s.c:SetDuration(0)
	self.in_s.b = self.in_s:CreateAnimation("Translation")
	self.in_s.b:SetOffset(off,0)
	self.in_s.b:SetDuration(.4)
	self.in_s.b:SetOrder(2)
	self.in_s.b:SetSmoothing("OUT")
	self.in_s.d = self.in_s:CreateAnimation("ALPHA")
	self.in_s.d:SetChange(1)
	self.in_s.d:SetOrder(2)
	self.in_s.d:SetDuration(.4)
	self.in_s_ = self:CreateAnimationGroup("OUT")
	self.in_s_.a = self.in_s_:CreateAnimation("Translation")
	self.in_s_.a:SetOffset(off,0)
	self.in_s_.a:SetDuration(.4)
	self.in_s_.a:SetOrder(1)
	self.in_s_.c = self.in_s_:CreateAnimation("ALPHA")
	self.in_s_.c:SetChange(-1)
	self.in_s_.c:SetOrder(1)
	self.in_s_.c:SetDuration(.4)
	self.in_s_:SetScript("OnFinished",function() self:Hide() end)
end

local reset_var = function(self,c)
	self.value[self.var] = self.value[self.var] + c
	if self.value[self.var] > self.max then
		self.value[self.var] = self.max
	elseif self.value[self.var] < self.min then
		self.value[self.var] = self.min
	end
	setbar_value(self)
end

local bt_enter = function(self) self.text:SetTextColor(1,0.5,0.5) self:GetParent():GetParent().focused = true end
local bt_leave = function(self) self.text:SetTextColor(1,1,1) end
local bt_up = function(self) self.tsg:Hide() end
local bt_on_updater = function(sel,t)
		sel.N = sel.N - t
	if sel.N > 0 then return end
	local self = sel.self_
		sel.N = sel.mult
		sel.mod = sel.mod - 1
	if sel.mod < 0 then
		sel.mult = .08
	end
	reset_var(self,sel._c)
end
local bt_down = function(button)
	reset_var(button.tsg.self_,button.tsg._c)
	button.tsg.N = .7
	button.tsg.mod = 2
	button.tsg.mult = .2
	button.tsg:Show()
end

local mk_button = function(self,ts,c,point,x,y,rpoint,cor)
	local parent = self:GetParent()
	local button = CreateFrame("Frame",nil,parent)
	button:EnableMouse(true)
	button.tsg = CreateFrame('Frame',nil,button)
	button.tsg.self_ = self
	button.tsg:Hide()
	button.tsg._c = c
	button:SetSize(16,16)
	button:SetPoint(point,parent,rpoint,x,y)
	local text = button:CreateFontString(nil,"OVERLAY")
	text:SetFont(M["media"].font_s,28)
	text:SetText(ts)
	text:SetPoint("CENTER",cor+.3,-.3)
	button.text = text
	button:SetScript("OnEnter",bt_enter)
	button:SetScript("OnLeave",bt_leave)
	button:SetScript("OnMouseUp",bt_up)
	button.tsg:SetScript("OnUpdate",bt_on_updater)
	button:SetScript("OnMouseDown",bt_down)
	anim(text,30*c)
	text:Hide()
	return text
end

M.makevarbar = function(parent,sizex,min,max,table_,var,name)
	local bar_holder = CreateFrame("Frame",nil,parent)
	local level = parent:GetFrameLevel()+3
	sizex = sizex + 60
	bar_holder:SetFrameLevel(level)
	bar_holder:SetSize(sizex,34)
	
	local bar_backdrop = CreateFrame("Frame",nil,bar_holder)
		bar_backdrop:SetPoint("BOTTOMLEFT",46,8)
		bar_backdrop:SetPoint("BOTTOMRIGHT",-46,8)
		bar_backdrop:SetHeight(11)
	setbg(bar_backdrop,unpack(colors[3]))
	local main = CreateFrame("Frame",nil,bar_backdrop)
		main:SetPoint("BOTTOMLEFT")
		main:SetPoint("TOPLEFT")
		main:SetFrameLevel(level+3)
	setbg(main,unpack(colors[4]))
	bar_holder.mainbar = main
	
	the_text = M.setfont(main,14,nil,nil,"CENTER")
	the_text:SetPoint("BOTTOM",bar_backdrop,"TOP",.3,-1)
	main.text = the_text
	
	main.max = max
	main.min = min
	main.act = sizex - 92
	main.value = table_
	main.var = var
	setbar_value(main)
	the_text:SetText(name)
	
	bar_holder.name_ = name
	bar_holder.focused = false
	bar_holder.l = mk_button(main,"<",-1,"RIGHT",-1,0,"LEFT",2)
	bar_holder.r = mk_button(main,">",1,"LEFT",1,0,"RIGHT",-1)
	bar_holder:EnableMouse(true)
	bar_holder:SetScript("OnEnter",function(self)
		if self.focused == true then self.focused = false return end
		self.mainbar.text:SetText(self.mainbar.value[self.mainbar.var])
		self.l.in_s_:Stop()
		self.r.in_s_:Stop()
		self.r:Show()
		self.l:Show()
		self.l.in_s:Play()
		self.r.in_s:Play()
	end)
	bar_holder:SetScript("OnLeave",function(self)
		if GetMouseFocus():GetParent() then 
			if GetMouseFocus():GetParent():GetParent() then 
				if GetMouseFocus():GetParent():GetParent() == self then return end
			end
		end
		self.mainbar.text:SetText(self.name_)
		self.l.in_s:Stop()
		self.r.in_s:Stop()
		self.l.in_s_:Play()
		self.r.in_s_:Play()
	end)
	return bar_holder
end