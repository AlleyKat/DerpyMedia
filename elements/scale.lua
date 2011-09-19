local M,L = unpack(select(2,...))

M.addenter(function()
	if not _G.DerpyMediaVars.scale_lock then return end
	SetCVar("useUiScale", 0)
	Advanced_UIScaleSlider:EnableMouse(false) 
	Advanced_UseUIScale:EnableMouse(false) 
	local a = M.setfont(Advanced_UIScaleSlider,52)
	a:SetTextColor(1,0,0)
	a:SetText("LOCKED")
	a:SetPoint("CENTER",0,2)
end)
