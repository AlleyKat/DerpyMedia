local ns = select(2,...) -- Someone wanna hold main global table not in global var =P

ns[1] = {} -- non names here	-- is M, the first one
ns[2] = {} -- names here		-- is L, the second one

_G.DerpyData = ns -- Using "M,L,V = unpack(DerpyData)" to get this table --

-- -- -- -- -- -- -- -- -- -- --
local M,L = unpack(select(2,...))

-- Some Media: Files + Colors set
local mediapath = "Interface\\AddOns\\DerpyMedia\\media\\"
M["media"] = {
	["path"] = mediapath,
	["font_s"] = mediapath.."sis.ttf",
	["blank"] = mediapath.."blankTex.tga",
	["glow"] = mediapath.."glowTex.tga",
	["cdfont"] = mediapath.."cdfont.ttf",
	["fontn"] = mediapath.."standart.ttf",
	["barv"] = mediapath.."barv.tga",
	["walltex"] = mediapath.."wallTex.tga",
	["ricon"] = mediapath.."ricon.tga",
	["crosstex"] = mediapath.."CrossTex.tga",
	["color"] = {0,0,0,1},
	["shadow"] = {.05,.05,.05,.85},
	["border"] = {0,0,0,1},
	["gradient"] = {.2,.2,.2,.15,.25,.25,.25,.5},
	["button"] = {{1,.1,.1,.9},{0,.8,.8,.9},{.3,.3,.3,.9},{0,1,1,.9}},
	["prizvstudiu"] = mediapath.."polechudes.tga",
}
	
-- Backdrop set	
M["bg"] = {
	bgFile = M["media"].blank, 
	edgeFile = M["media"].glow, 
	tile = false , tileSize = 0, edgeSize = 4,
	insets = {left = 3, right = 3, top = 3, bottom = 3}}
	
M["bg_edge"] = {
	edgeFile = M["media"].glow, 
	edgeSize = 4,
	insets = {left = 3, right = 3, top = 3, bottom = 3}}

-- Constants
M.L = GetLocale()
M.class = select(2,UnitClass("player"))
M.Class = M.class -- make more easy
M.oufspawn = 160
M.call = {} -- config menu table
-- Check main font
M["media"].font = (M.L == "ruRU" and mediapath..[=[altmono.ttf]=]) or mediapath..[=[mono.ttf]=]
