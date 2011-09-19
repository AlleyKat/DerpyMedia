local M,L = unpack(select(2,...))

-- M.loaddef = function()
		
	-- WiskasStuff = {
		-- ["combatfeedback"] = true,
		-- ["experience"] = true,
		-- ["smooth"] = true,
		-- ["spellrange"] = true,
		-- ["swing"] = true,
		-- ["onlyplayer"] = true,
		-- ["showtreat"] = true,
		-- ["enableparty"] = true,
		-- ["partyraid"] = true,
		-- ["fix_1"] = false,
		-- ["fix_2"] = false,
		-- ["fix_3"] = false,
		-- ["rangealpha"] = 75,
		-- ["updatemod"] = 8,
		-- ["lowmana"] = 33,
		-- ["lowhealth"] = 25,
		-- ["numdebuffs"] = 12,
	-- }

	-- HissySavedTS = {
		-- ["v15"] = true,
		
		-- ["raid"] = 1,
		
		-- ["trigers"] = {
			-- ["junk"] = false,
			-- ["autoinv"] = false,
			-- ["autoacceptinv"] = false,
			-- ["autodeclineinv"] = false,
			-- ["declineduels"] = false,
			-- ["repair"] = false},
				
		-- ["chatcur"] = {
			-- [1] = 48,
			-- [2] = 48},
			
		-- ["hide_chat_junk"] = true,
		-- ["chat"] = true,
		-- ["chatplayer"] = true,
		-- ["show_flash"] = true,
		-- ["hyperlinks"] = true,
		
		-- ["chat_speed"] = 60,
		-- ["ch_w"] = 300,
		-- ["ch_max"] = 120,
		-- ["ch_min"] = 48,
		
		-- ["tooltip"] = true,
		-- ["minimap"] = true,
		-- ["loot"] = true,
		-- ["lockfont"] = true,
		-- ["lootroll"] = true,
		-- ["minor"] = true,	
		-- ["nameplates"] = true,		
		-- ["weaponench"] = true,	
		-- ["shadow"] = true,	
		-- ["combat"] = true,	
		-- ["top"] = true,	
		-- ["bottom"] = true,
		-- ["lockscale"] = true,	
		-- ["error"] = true,
		-- ["skin"] = true,
		-- ["replacefont"] = true,
		
		-- ["rollbuffs"] = 12,
		-- ["rolldebuffs"] = 12,
		-- ["buffssize"] = 32,
		-- ["debuffsize"] = 32,
		-- ["bufffont"] = 14,
		-- ["debufffont"] = 14,
		-- ["buffs"] = true,	
		-- ["debuffs"] = false,
		
		
		-- ["rightmenu"] = {
			-- ["shown"] = false,
			-- ["current"] = 1}

	-- }
	
	-- HissySavedST = {}
	
	-- SetCVar("removeChatDelay", 1)
	-- SetCVar("autoDismountFlying", 1)
	-- SetCVar("autoQuestWatch", 1)
	-- SetCVar("autoQuestProgress", 1)
	-- SetCVar("buffDurations", 1)
	-- SetCVar("lootUnderMouse", 1)
	-- SetCVar("bloatthreat", 0)
	-- SetCVar("bloattest", 0)
	-- SetCVar("bloatnameplates", 0)
	-- SetCVar("nameplateShowFriends", 0)
	-- SetCVar("nameplateShowFriendlyPets", 0)
	-- SetCVar("nameplateShowFriendlyGuardians", 0)
	-- SetCVar("nameplateShowFriendlyTotems", 0)
	-- SetCVar("nameplateShowEnemies", 1)
	-- SetCVar("nameplateShowEnemyPets", 1)
	-- SetCVar("nameplateShowEnemyGuardians", 1)
	-- SetCVar("nameplateShowEnemyTotems", 1)
	-- SetCVar("ShowClassColorInNameplate", 1)

-- end

-- M.resetdeff = function()
	-- local a = CreateFrame"Frame"
	-- a:SetAllPoints()
	-- local tex = a:CreateTexture(nil,"OVERLAY")
	-- tex:SetAllPoints()
	-- tex:SetTexture(0,0,0,.8)
	-- a:SetFrameStrata("DIALOG")
	-- a:SetFrameLevel(6)
	-- StaticPopupDialogs["HISSYRESETALLVARS"] = {
	-- text = L['initdeff'],
	-- button1 = ACCEPT,
	-- button2 = CANCEL,
	-- OnAccept = function() M.loaddef(); ReloadUI(); end,
	-- OnCancel = function() a:Hide() end,
	-- timeout = 0,
	-- whileDead = 1,}
	-- StaticPopup_Show("HISSYRESETALLVARS")
-- end

-- M.addafter(function()
	-- if not HissySavedTS.v15 then M.resetdeff() end
-- end)