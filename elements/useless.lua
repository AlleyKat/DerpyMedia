local M,L = unpack(select(2,...))

local WorldFrame = WorldFrame
local UIParent = UIParent
local start_timer = 2
local InCombatLockdown = InCombatLockdown
local _SCALE
local toplimit = -40
local botlimit = 18*4

local tspeed = -3.2*toplimit
local bspeed =  3.2*botlimit

local top = M.frame(UIParent,0,"BACKGROUND")
top:SetPoint("TOPRIGHT",5,8)
top:SetPoint("TOPLEFT",-5,8)
top:SetPoint("BOTTOM",WorldFrame,"TOP",0,-3)

local bot = M.frame(UIParent,0,"BACKGROUND")
bot:SetPoint("BOTTOMRIGHT",5,-8)
bot:SetPoint("BOTTOMLEFT",-5,-8)
bot:SetPoint("TOP",WorldFrame,"BOTTOM",0,3)

local cur_t = 0
local cur_b = 0
local _mod = 1
local __A = true
local move = function(self,t)
	if InCombatLockdown() then return end
	if cur_t then
		cur_t = cur_t - t*tspeed*_mod
		WorldFrame:SetPoint("TOPLEFT",0,cur_t*_mod>toplimit*_mod and cur_t*_SCALE or toplimit*_SCALE)
		if cur_t*_mod<=toplimit*_mod then cur_t = nil end
	end
	if cur_b then
		cur_b = cur_b + t*bspeed*_mod
		WorldFrame:SetPoint("BOTTOMRIGHT",0,cur_b*_mod<botlimit*_mod and cur_b*_SCALE or botlimit*_SCALE)
		if cur_b*_mod>=botlimit*_mod then cur_b = nil end
	end
	if not cur_b and not cur_t then 
		if __A then
			cur_t =	toplimit
			cur_b = botlimit
			toplimit = -10
			botlimit = 18
			_mod = -1
			__A = nil
		else			
			self:SetScript("OnUpdate",nil); self:Hide()
		end
	end
end

local mover = CreateFrame("Frame")
mover:Hide()
mover:SetScript("OnUpdate",function(self,t)
	start_timer = start_timer - t
	if start_timer > 0 then return end
	self:SetScript("OnUpdate",move)
end)

WorldFrame:ClearAllPoints()
M.addlast(function()
	_SCALE = M.scale
	mover:Show()
end)