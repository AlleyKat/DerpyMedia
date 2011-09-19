local M = unpack(select(2,...))

-- Get Next Char
M.GetNextChar = function(word,num)
	local c = word:byte(num)
	local shift
	if not c then return "",num end
		if (c > 0 and c <= 127) then
			shift = 1
		elseif (c >= 192 and c <= 223) then
			shift = 2
		elseif (c >= 224 and c <= 239) then
			shift = 3
		elseif (c >= 240 and c <= 247) then
			shift = 4
		end
	return word:sub(num,num+shift-1),(num+shift)
end

-- Create String <STANDART TYPE>
M.setfont = function(parent,size,isoffset,layer,fy,fz,ht)
	local a = parent:CreateFontString(nil,layer or "OVERLAY")
	a:SetFont(M["media"].font,size or 13,ht)
	if not isoffset then
		a:SetShadowOffset(1,-1)
	end
	a:SetJustifyH(fy or "LEFT")
	a:SetJustifyV(fz or "MIDDLE")
	a:SetHeight(size or 13)
	return a
end


-- Config trig for text type
local help_ = {}
help_.LeftButton = {
	["LINE"] = "OUTLINE",
	["OUTLINE"] = "THICKOUTLINE",
	["THICKOUTLINE"] = "LINE",}
	
help_.RightButton = {
	["LINE"] = "THICKOUTLINE",
	["OUTLINE"] = "LINE",
	["THICKOUTLINE"] = "OUTLINE",}
	
local on_down = function(self,button)
	self._tab[self.obj] = help_[button][self._tab[self.obj]]
	self.t:SetText(self._tab[self.obj])
end

local on_enter = function(s) s.t:SetTextColor(1,.7,.2) end
local on_leave = function(s) s.t:SetTextColor(1,1,1) end

M.make_fonttype = function(self,_tab,obj,st)
	local f = CreateFrame("Frame",nil,self)
	f:SetFrameLevel(34)
	f:EnableMouse(true)
	
	local left = M.setfont(f)
	left:SetPoint("LEFT",2.7,1)
	left:SetText(st)
	
	f:SetSize(floor(self:GetWidth())-30,16)
	
	local t = M.setfont(f,15)
	t:SetPoint("RIGHT",-4,1.5)
	t:SetText(_tab[obj])
	
	f.t = t
	f._tab = _tab
	f.obj = obj
	
	f:SetScript("OnEnter",on_enter)
	f:SetScript("OnLeave",on_leave)
	f:SetScript("OnMouseDown",on_down)
	
	return f
end
	
local FormatTime = function(time)
    local hr, m, text
    if time <= 0 then text = ""
    elseif(time < 3600 and time > 60) then
		hr = floor(time / 3600)
		m = floor(mod(time, 3600) / 60 + 1)
		text = format("|cffffffff%dm|r", m)
    elseif time > 10 and time < 60 then
		m = floor(time / 60)
		text = (m == 0 and format("|cffff0000%d|r",time))
	elseif time < 10 then
		m = floor(time / 60)
		text = (m == 0 and format("|cffff0000%.1f|r",time))
    else
		hr = floor(time / 3600 + 1)
		text = format("|cffffffff%dh|r", hr)
    end
    return text
end

local GetTime = GetTime
M.CreateAuraTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = FormatTime(self.timeLeft)
				self.remaining:SetText(time)
			else
				self.remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

M.FormatTime = FormatTime

M.setcdfont = function(parent,size,type)
	local a = parent:CreateFontString(nil,"OVERLAY")
	a:SetFont(M["media"].cdfont,size,type)
	a:SetShadowOffset(1.2,-1.2)
	a:SetHeight(size)
	return a
end