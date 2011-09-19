-- CENTER NOTIFICATION FRAME
local M = unpack(select(2,...))

local updaterun = CreateFrame("Frame")
local speed = .027789124
local count,le,step,word,stringE,a,backstep

local flowingframe = CreateFrame("Frame",nil,UIParent)
	flowingframe:SetFrameStrata("HIGH")
	flowingframe:SetPoint("CENTER",UIParent,0,136)
	flowingframe:SetHeight(64)
	
local flowingtext = M.setfont(flowingframe,26)	
local rightchar = M.setfont(flowingframe,60)

local nextstep = function()
	a,step = M.GetNextChar(word,step)
	flowingtext:SetText(stringE)
	stringE = stringE..a
	a = string.upper(a)
	rightchar:SetText(a)
end

local resettext = function(self,mode,opt)
	self:ClearAllPoints()
	self:SetJustifyH(mode)
	if opt then
		self:SetPoint(mode,flowingtext,opt)
	else
		self:SetPoint(mode)
	end
end

local backrun = CreateFrame("Frame")
backrun:Hide()

local updatestring = function(self,t)
	count = count - t
		if count < 0 then
			count = speed
			if step > le then 
				self:Hide()
				flowingtext:SetText(stringE)
				rightchar:SetText()
				resettext(flowingtext,"RIGHT")
				resettext(rightchar,"RIGHT","LEFT")
				self:Hide()
				count = 1.456789
				backrun:Show()
			else 
				nextstep()
			end
		end
end

updaterun:SetScript("OnUpdate",updatestring)
updaterun:Hide()

local backstepf = function()
	local a = backstep
	local firstchar
		local texttemp = ""
		local flagon = true
		while a <= le do
			local u
			u,a = M.GetNextChar(word,a)
			if flagon == true then
				backstep = a
				flagon = false
				firstchar = u
			else
				texttemp = texttemp..u
			end
		end
	flowingtext:SetText(texttemp)
	firstchar = string.upper(firstchar)
	rightchar:SetText(firstchar)
end

local rollback = function(self,t)
	count = count - t
		if count < 0 then
			count = speed
			if backstep > le then
				self:Hide()
				flowingtext:SetText()
				rightchar:SetText()
			else
				backstepf()
			end
		end
end

backrun:SetScript("OnUpdate",rollback)

M.allertrun = function(f,r,g,b)
	flowingframe:Hide()
	updaterun:Hide()
	backrun:Hide()
	flowingtext:SetTextColor(r or 1,g or 1,b or 1)
	rightchar:SetTextColor((r or 1)*.7,(g or 1)*.7,(b or 1)*.7)
	word,le,step,backstep,count,stringE,a = f,f:len(),1,1,speed,"",""
	flowingtext:SetText(f)
	flowingframe:SetWidth(flowingtext:GetWidth())
	flowingtext:SetText("")
	resettext(flowingtext,"LEFT")
	resettext(rightchar,"LEFT","RIGHT")	
	rightchar:SetText("")
	updaterun:Show()
	flowingframe:Show()
end