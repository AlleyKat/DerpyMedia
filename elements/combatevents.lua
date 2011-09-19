local M,L,DB = unpack(select(2,...))

local S = CreateFrame("Frame","DerpyCombatProc")

S:RegisterEvent("PLAYER_REGEN_ENABLED")
S:RegisterEvent("PLAYER_REGEN_DISABLED")
S.cin = {}
S.cout = {}

S:SetScript("OnEvent",function(self,event) self[event](self) end)

S["PLAYER_REGEN_ENABLED"] = function(self)
	for _,func in pairs(self.cout) do func() end
end

S["PLAYER_REGEN_DISABLED"] = function(self)
	for _,func in pairs(self.cin) do func() end
end

M.addcombat = function(func,name,mode)
	S["c"..mode][name]=func~="remove" and func or nil;
end
