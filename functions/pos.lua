local _table
local M = unpack(select(2,...))
local floor = floor
local DB 

M.addenter(function()
	if not _G.DerpyPosVars then
		_G.DerpyPosVars = {}
	end
	DB = _G.DerpyPosVars
end)

local _write = function(self)
	if not _table then print("Слишком рано!!!") return end
	if self._size_mod then
		self:_StopMovingOrSizing()
	end
	local a = {}
	local name = self:GetName()
	if not name then print(self,"- Имя не найдено, возврат") return end
	_table[name] = a
	local temp
	a[1],temp,a[3],a[4],a[5] = self:GetPoint()
	temp = temp or _G.UIParent
	a[2] = temp:GetName()
	a[4] = floor(a[4]+.5)
	a[5] = floor(a[5]+.5)
	if not a[2] then print(temp,"- Имя не найдено :(") return end
	if self.size_to then
		if not a[6] then return end
		a[6],a[7] = floor(self:GetWidth()+.5),floor(self:GetHeight()+.5)
	end
end

local _read = function(self,a)
	if not self then return end
	self:ClearAllPoints()
	self:SetPoint(a[1],_G[a[2]],a[3],a[4],a[5])
	if self.size_to then 
		self:SetSize(a[6],a[7])
	end
end

M.addlast(function()
	if not DB then DB = {} end
	_table = DB
	for p,t in pairs(_table) do
		_read(_G[p],t)
	end
end)

M.make_savepos = function(self,size,t)
	self._StopMovingOrSizing = self.StopMovingOrSizing
	self.StopMovingOrSizing = _write
	self._size_mod = true
	if t then
		self:EnableMouse(true)
	end
	self.size_to = size
end

local stop = function(self) self:StopMovingOrSizing() end

M.make_movable = function(self,t)
	self:SetMovable(true)
	self:SetScript("OnMouseDown",self.StartMoving)
	self._stooooop = stop
	self:SetScript("OnMouseUp",self._stooooop)
	if t then
		self:EnableMouse(true)
	end
end

M.write_pos = _write

local movers_table = {}
local cc = 1

M.tex_move = function(self,name,func)
	local t = self:CreateTexture(nil,"OVERLAY")
	t:SetAllPoints()
	t:SetTexture(0,.7,1,.7)
	local te = M.setfont(self,24)
	te:SetText(name)
	te:SetPoint("CENTER")
	te:Hide()
	t:Hide()
	
	self.t1 = t;
	self.t2 = te;
	self.t3 = func or M.null
	
	movers_table[cc] = self
	cc = cc + 1
end

M.unlock_pos_now = function()
	for i=1, #movers_table do
		local a = movers_table[i]
		a:EnableMouse(true);
		a:Show();
		a.t1:Show();
		a.t2:Show();
	end
end

M.lock_pos_now = function()
	local wv = M.write_pos
	for i=1, #movers_table do
		local a = movers_table[i]
		a:EnableMouse(false);
		a:t3()
		a.t1:Hide();
		a.t2:Hide();
		wv(a)
	end
end

