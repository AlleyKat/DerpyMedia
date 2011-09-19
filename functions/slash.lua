local M = unpack(select(2,...))

-- Reset Saved Vars
SlashCmdList.HTSDEFF = function() M.resetdeff() end
SLASH_HTSDEFF1 = "/pyreset"

-- Get Hovered frame name
SlashCmdList.GETFRAMENAME = function() print(GetMouseFocus():GetName()) end
SLASH_GETFRAMENAME1 = "/frame"

-- Reload UI
SlashCmdList.REL = ReloadUI
SLASH_REL1 = "/rl"
SLASH_REL2 = "/кд"

-- Center alert
SlashCmdList.ALLEYRUN = M.allertrun
SLASH_ALLEYRUN1 = "/arn"

-- Menu call
SlashCmdList.HMENU = M.call.menu
SLASH_HMENU1 = "/py" 