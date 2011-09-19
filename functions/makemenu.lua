local M,L = unpack(select(2,...))

local colors_ = M["media"].button
local setbutton = function(target,ison,parent)
	local button = CreateFrame ("Frame",nil,parent)
	button:SetFrameLevel(32)
	button:SetFrameStrata("HIGH")
	button:SetBackdrop(M.bg)
	if target == true and ison == true then
		button:SetBackdropColor(unpack(colors_[2]))
		button:SetBackdropBorderColor(unpack(colors_[2]))
	elseif not target and not ison then
		button:SetBackdropColor(unpack(colors_[1]))
		button:SetBackdropBorderColor(unpack(colors_[1]))
	else
		button:SetBackdropColor(unpack(colors_[3]))
		button:SetBackdropBorderColor(unpack(colors_[3]))
	end
	button:SetWidth(35)
	button:SetHeight(11)
	return button
end

local swch = function (self,ison,alternative)
	local target
	if ison == true then
		self:SetBackdropColor(unpack(colors_[2]))
		self:SetBackdropBorderColor(unpack(colors_[2]))
		target = true
	else
		self:SetBackdropColor(unpack(colors_[1]))
		self:SetBackdropBorderColor(unpack(colors_[1]))
		target = false
	end
	alternative:SetBackdropColor(unpack(colors_[3]))
	alternative:SetBackdropBorderColor(unpack(colors_[3]))
	return target
end

local _t1 = function(self) self.r[self.s] = swch(self,true,self.b) end
local _t2 = function(self) self.r[self.s] = swch(self,false,self.a) end

local makebuttons = function(parent,r,s)
	local a = setbutton(r[s],true,parent)
	local b = setbutton(r[s],false,parent)
	a.r = r; b.r = r; a.s = s;
	a.b = b; b.a = a; b.s = s;
	a:SetScript("OnMouseDown",_t1)
	b:SetScript("OnMouseDown",_t2)
	b:SetPoint("RIGHT",a,"LEFT",-4,0)
	return a
end

local setmenutext = function(t,frame)
	local text = M.setfont(frame)
	text:SetText(t)
	return text
end

local leave = function(s) s.t:SetTextColor(1,1,1) end
local enter = function(s) s.t:SetTextColor(1,.3,.3) end

local close_ui_button = function(parent)
	local a = CreateFrame("Button",nil,parent)
	a:SetSize(64,17)
	a:SetPoint("BOTTOMLEFT",parent,10,7)
	
	local t = M.setfont(a,15)
	t:SetText(string.upper(L['reload']))
	t:SetPoint("LEFT")
	a.t = t
	
	a:SetScript("OnEnter",enter)
	a:SetScript("OnLeave",leave)
	a:SetScript("OnClick",ReloadUI)
end

local click = function(self) self:GetParent():hide_() M.call.menu() end

local mkclose = function(parent)
	local a = CreateFrame("Button",nil,parent)
	a:SetSize(64,17)
	a:SetPoint("BOTTOMRIGHT",parent,-10,7)
	
	local t = M.setfont(a,15,nil,nil,"RIGHT")
	t:SetText(string.upper(L['back']))
	t:SetAllPoints()
	a.t = t
	
	a:SetScript("OnEnter",enter)
	a:SetScript("OnLeave",leave)
	a:SetScript("OnClick",click)
end

local fade_show = function(self) 
	self.fd:Hide()
	UIFrameFadeIn(self,.7,0,1)
end

local update_alpha = function(self)
	if self.parent:GetAlpha() == 0 then 
		self.parent:Hide()
		self:Hide()
	end
end

local hide_ = function(self) UIFrameFadeOut(self,.7,1,0) self.fd:Show() end

M.mkfade = function(p)
	p.fd = CreateFrame("Frame",nil,p)
	p.fd:Hide()
	p.fd.parent = p -- lol!
	p.fd:SetScript("OnUpdate",update_alpha)
	p:SetScript("OnShow",fade_show)
	p.hide_ = hide_
end

M.tweaks_mvn = function(frame,swtable,nametable,aboffset)
	local b1,b2 = {}
	local i = 1
	local lasttext
	for y,name in pairs(swtable) do
		if nametable[y] then
			b1[i] = makebuttons (frame,swtable,y)
			local a = setmenutext(nametable[y],frame)
			if i == 1 then
				b1[i]:SetPoint("TOPRIGHT",frame,-18,-aboffset)
				a:SetPoint("TOPLEFT",frame,18,-aboffset + 2)
			else
				b1[i]:SetPoint("TOPRIGHT",b1[i-1],"BOTTOMRIGHT",0,-3)
				a:SetPoint("TOPLEFT",lasttext,"BOTTOMLEFT",0,-0.9)
			end
			lasttext = a
			i = i + 1
		end
	end
	return i
end

M.make_settings = function(nametable,swtable,offset,width,sname,showreload)
	local aboffset = (offset or 0) + 30
	local frame = M.frame(UIParent,30,"HIGH")
	frame:Hide()
	frame:SetWidth(width or 70)
	frame:SetPoint("CENTER")
	local i = M.tweaks_mvn(frame,swtable,nametable,aboffset)
	frame:SetHeight((i-1)*14+aboffset+28)
	mkclose(frame)
	M.mkfade(frame)
	if showreload then close_ui_button(frame) end
	local stname = M.setfont(frame,15,nil,nil,"CENTER")
	stname:SetPoint("TOPLEFT",8,-6)
	stname:SetPoint("TOPRIGHT",-8,-6)
	stname:SetText(sname)
	return frame
end