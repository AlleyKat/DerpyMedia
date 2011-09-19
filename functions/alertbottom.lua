local M = unpack(select(2,...))
local random = math.random
local min = min

local stringholder = CreateFrame("Frame",nil,UIParent)
stringholder:SetSize(10,10)
stringholder:SetPoint("TOPLEFT",UIParent,6,-24)

local symarray = {}
local total = 128
local stop_num = 1
local perv = 1

for i=1, total do
	local a = M.setfont(stringholder,18,nil,nil,"CENTER")
	if i == 1 then
		a:SetPoint("TOPLEFT")
	else
		a:SetPoint("LEFT",symarray[i-1],"RIGHT")
	end
	a:SetAlpha(0)
	
	a.p = a:CreateAnimationGroup("Show")
	
	a.p.hold_a = a.p:CreateAnimation("ALPHA")
	a.p.hold_a:SetChange(0)
	a.p.hold_a:SetOrder(1)
	a.p.hold_a:SetDuration(random(120)/100)
	
	a.p.fadein = a.p:CreateAnimation("ALPHA")
	a.p.fadein:SetChange(1)
	a.p.fadein:SetOrder(2)
	a.p.fadein:SetDuration(.7)
	
	a.p.hold_b = a.p:CreateAnimation("ALPHA")
	a.p.hold_b:SetChange(0)
	a.p.hold_b:SetOrder(3)
	a.p.hold_b:SetDuration(2+random(200)/100)
	
	a.p.fadeout = a.p:CreateAnimation("ALPHA")
	a.p.fadeout:SetChange(-1)
	a.p.fadeout:SetOrder(4)
	a.p.fadeout:SetDuration(.7)	
	symarray[i] = a
end

local show_all = function(stop_num)
	for i=1,stop_num do
		local p = symarray[i].p
		p:Stop()
		p.hold_b:SetDuration(2+random(200)/100)
		p.hold_a:SetDuration(random(120)/100)
		p.fadeout:SetDuration(.7)	
		p:Play()
	end
end

local reset = function(stop_num,perv)
	for i=stop_num,perv do
		if symarray[i].p:IsPlaying() then
			local p = symarray[i].p
			p.fadeout:SetDuration(random(30)/100+.2)
			p.hold_b:SetDuration(0)
		end
	end
end

local check = stringholder:CreateTexture(nil,"Overlay")
check.l = check:CreateAnimationGroup("Check")
check.l.hold_a = check.l:CreateAnimation("ALPHA")
check.l.hold_a:SetChange(0)
check.l.hold_a:SetOrder(1)
check.l.hold_a:SetDuration(8)

check.l:SetScript("OnFinished",function() 
	if M.raidframe then
		if not M.raidframe:IsShown() then return end
		UIFrameFadeIn(M.raidframe,.25,0,1)
	end
end)

local raid_check  = function()
	check.l:Stop()
	if M.raidframe then
		if not M.raidframe:IsShown() then return end
		UIFrameFadeOut(M.raidframe,0,0,0)
	end
	check.l:Play()
end

M.sl_run = function(word,r,g,b)
	local le = word:len()
	local a,i = 1,1
	while a <= le do
		local t
		t,a = M.GetNextChar(word,a)
		if i <= total then
			symarray[i]:SetTextColor(r or 1,g or 1,b or 1)
			symarray[i]:SetAlpha(0)
			symarray[i]:SetText(t)
			i = i + 1
		end
	end
	perv = stop_num
	stop_num = min(i-1,total),1
	stop_num = stop_num == 0 and 1 or stop_num
	reset(stop_num,perv)
	raid_check()
	show_all(stop_num)
end

-- M.addenter(function() 
	
	-- DerpyTS.topleft_mes = M.check_nil(DerpyTS.topleft_mes)
	-- if not HissySavedTS.topleft_mes then
		-- M.sl_run = M.null
	-- end
-- end)