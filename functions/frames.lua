local M = unpack(select(2,...))

-- Style Frame
M.style = function (myframe,nobg,off,blend)
	off = off or 3
	
	if nobg ~= true then
		if not myframe.bg then
			local bg = myframe:CreateTexture(nil,"BORDER")
			bg:SetPoint("TOPLEFT",off+1,-off-1)
			bg:SetPoint("BOTTOMRIGHT",-off-1,off+1)
			bg:SetTexture(1,1,1,1)
			bg:SetGradientAlpha("VERTICAL",unpack(M["media"].gradient))
			bg:SetBlendMode(blend or "ADD")
			myframe.bg = bg
		end
	end
	
	local left = myframe:CreateTexture(nil,"ARTWORK")
	left:SetTexture(unpack(M["media"].border))
	left:SetPoint("TOPLEFT",off,-off)
	left:SetPoint("BOTTOMLEFT",off,off)
	left:SetWidth(1)
	myframe.left = left
	
	local right = myframe:CreateTexture(nil,"ARTWORK")
	right:SetTexture(unpack(M["media"].border))
	right:SetPoint("TOPRIGHT",-off,-off)
	right:SetPoint("BOTTOMRIGHT",-off,off)
	right:SetWidth(1)
	myframe.right = right
	
	local bottom = myframe:CreateTexture(nil,"ARTWORK")
	bottom:SetTexture(unpack(M["media"].border))
	bottom:SetPoint("BOTTOMLEFT",off,off)
	bottom:SetPoint("BOTTOMRIGHT",-off,off)
	bottom:SetHeight(1)
	myframe.bottom = bottom
	
	local top = myframe:CreateTexture(nil,"ARTWORK")
	top:SetTexture(unpack(M["media"].border))
	top:SetPoint("TOPLEFT",off,-off)
	top:SetPoint("TOPRIGHT",-off,off)
	top:SetHeight(1)
	myframe.top = top
end

M.frame_points = function(self,parent)
	parent = parent or self:GetParent()
	self:SetPoint("TOPLEFT",parent,-4,4)
	self:SetPoint("BOTTOMRIGHT",parent,4,-4)
end

-- Set Frame Backdrop (st one)
M.setbackdrop = function(self)
	self:SetBackdrop(M["bg"])
	self:SetBackdropBorderColor(unpack(M["media"].shadow))
	self:SetBackdropColor(unpack(M["media"].color))
	self.backcolor = M.backcolor
	self.points = M.frame_points
end

-- Change Template
M.ChangeTemplate = function(self) M.setbackdrop(self); M.style(self); end

-- CreateFrame
local Frame_count = 0
M.frame = function(parent,level,strata,nobg,nols,off,tag)
	local myframe = CreateFrame("Frame",tag or "DerpyFrame_"..Frame_count,parent)
	if not tag then Frame_count = Frame_count + 1 end
	if nols ~= true then
		myframe:SetFrameLevel(level or 2)
		myframe:SetFrameStrata(strata or "BACKGROUND")
	end
	M.setbackdrop(myframe)
	M.style(myframe,nobg,off)
	return myframe
end

-- To change frames color
do
	local n1,n2,n3,n4 = unpack(M["media"].shadow)
	M.backcolor = function(self,r,g,b,alp,stop)
		self.top:SetTexture(r,g,b)
		self.bottom:SetTexture(r,g,b)
		self.right:SetTexture(r,g,b)
		self.left:SetTexture(r,g,b)
		if stop then return end
		if not alp then
			self:SetBackdropBorderColor(n1,n2,n3,n4)
		else
			self:SetBackdropBorderColor(r,g,b,alp)
		end
	end
end
-- Popup frames with headers
local level_count = 0

local any_up = function(self)
	self:GetParent():Hide()
end

local make_close_button = function(self)
	local close = CreateFrame("Button",self:GetName().."CloseButton",self)
	close:EnableMouse(true)
	close:RegisterForClicks("AnyUp")
	close:SetScript("OnClick",any_up)
	close:SetSize(floor(self:GetWidth()/2),22)
	close:SetPoint("TOPRIGHT",self,-4,-4)
	local texture = close:CreateTexture(nil,"HIGHLIGHT")
	texture:SetTexture(M.media.blank)
	texture:SetGradientAlpha("HORIZONTAL",1,0,0,0,1,0,0,.6)
	texture:SetPoint("RIGHT")
	texture:SetSize(floor(self:GetWidth()+.5)-8,22)
end

local make_header = function(self,name)
	local head = M.setfont(self,18)
	head:SetText(string.upper(name))
	head:SetPoint("TOPLEFT",8,-6)
end

M.framepop = function(parent,name,size_x,size_y)
	if _G["DerpyPopUpFrame"..name] then _G["DerpyPopUpFrame"..name]:show() return end
	local self = M.frame(parent,level_count,"HIGH",false,false,nil,"DeryPopUpFrame"..name)
	self:Hide()
	self:SetSize(size_x,size_y)
	make_close_button(self)
	make_header(self,name)
	M.make_plav(self,.3)
	level_count = level_count+2
	self:SetPoint("CENTER",UIParent)
	self:show()
end