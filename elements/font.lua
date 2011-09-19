local M,L = unpack(select(2,...))

local offset_f
local _font = M["media"].fontn

local SetFont = function(obj, font, size, style, r)
	obj:SetFont(_font, size+offset_f, style or "LINE")
	if font then
		obj:SetShadowOffset(.75,-.75)
		obj:SetShadowColor(0,0,0,.7)
	else
		obj:SetShadowColor(0,0,0,0)
	end
	if r then obj:SetAlpha(r) end
end

local FixTitleFont = function()
	for _,b in pairs(PaperDollTitlesPane.buttons) do
		b.text:SetFontObject(GameFontHighlightSmallLeft)
	end
end

M.addenter(function()
	if not _G.DerpyMediaVars.font_replace then return end
	offset_f = _G.DerpyMediaVars.font_offset - 4
	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12 + offset_f
	CHAT_FONT_HEIGHTS = {8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32}

	UNIT_NAME_FONT     = _font
	NAMEPLATE_FONT     = _font
	DAMAGE_TEXT_FONT   = _font
	STANDARD_TEXT_FONT = _font

	-- Base fonts
	SetFont(GameTooltipHeader,                  true, 12)
	SetFont(NumberFont_OutlineThick_Mono_Small, true, 12, "OUTLINE")
	SetFont(NumberFont_Outline_Huge,            true, 28, "THICKOUTLINE", 28)
	SetFont(NumberFont_Outline_Large,           true, 15, "OUTLINE")
	SetFont(NumberFont_Outline_Med,             true, 13, "OUTLINE")
	SetFont(NumberFont_Shadow_Med,              false, 12)
	SetFont(NumberFont_Shadow_Small,            false, 12)
	SetFont(QuestFont,                          false, 14)
	SetFont(QuestFont_Large,                    true, 14)
	SetFont(SystemFont_Large,                   false, 15)
	SetFont(SystemFont_Med1,                    false, 12)
	SetFont(SystemFont_Med3,                    false, 13)
	SetFont(SystemFont_OutlineThick_Huge2,      true, 20, "THICKOUTLINE")
	SetFont(SystemFont_Outline_Small,           true, 12, "OUTLINE")
	SetFont(SystemFont_Shadow_Large,            true, 15)
	SetFont(SystemFont_Shadow_Med1,             true, 12)
	SetFont(SystemFont_Shadow_Med3,             true, 13)
	SetFont(SystemFont_Shadow_Outline_Huge2,  	true, 20, "OUTLINE")
	SetFont(SystemFont_Shadow_Small,            true, 11)
	SetFont(FriendsFont_Small,          		true, 10)
	SetFont(FriendsFont_Normal,         		true, 12)
	SetFont(FriendsFont_Large,           		true, 15)
	SetFont(SystemFont_Small,                   true, 12)
	SetFont(SystemFont_Tiny,                    true, 12)
	SetFont(Tooltip_Med,                        true, 12)
	SetFont(Tooltip_Small,                    	true, 12)
	SetFont(CombatTextFont,                     true, 80, "THINOUTLINE") -- number here just increase the font quality.
	SetFont(SystemFont_Shadow_Huge1,            false, 20, "THINOUTLINE")
	SetFont(ZoneTextString,                     true, 32, "OUTLINE")
	SetFont(SubZoneTextString,                  true, 25, "OUTLINE")
	SetFont(PVPInfoTextString,                  true, 22, "OUTLINE")
	SetFont(PVPArenaTextString,                 true, 22, "OUTLINE")
	SetFont(ChatFontNormal,                 	true, 13)
	SetFont(ChatFontSmall,                	 	true, 13)
	SetFont(SystemFont_Med2,                	false, 13)
	SetFont(SystemFont_Shadow_Med2,				true, 13)
	SetFont(SystemFont_Huge1,                	true, 20)
	SetFont(SystemFont_Shadow_Huge3,			false, 24)
	SetFont(SystemFont_OutlineThick_Huge4,		true, 25, "THINOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF,		true, 32, "THINOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF,		true, 32, "THINOUTLINE")
	SetFont(QuestFont_Shadow_Huge,				true, 17)
	SetFont(QuestFont_Shadow_Small,				true, 13)
	SetFont(MailFont_Large,						true, 14)
	SetFont(SpellFont_Small,					false, 10)
	SetFont(InvoiceFont_Med,					true, 12)
	SetFont(InvoiceFont_Small,					true, 10)
	SetFont(AchievementFont_Small,				true, 10)
	SetFont(ReputationDetailFont,				true, 10)
	SetFont(FriendsFont_UserText,				true, 11)
	SetFont(GameFont_Gigantic,					true, 32)
	SetFont(GameFontHighlightSmallLeft, 		true, 12)
	hooksecurefunc("PaperDollTitlesPane_Update", FixTitleFont)
	FixTitleFont()
	SetFont = nil
	
end)