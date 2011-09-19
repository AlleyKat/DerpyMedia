local M,L = unpack(select(2,...))
local tremove = tremove
local pairs = pairs

local O_1 = {}
local O_2 = {}
local O_5 = {}
local O = {}

local O_1_names = {}
local O_2_names = {}
local O_5_names = {}
local O_names = {}

local Update = CreateFrame("Frame","Derpy_Update")
M.get_update_state =  M.null

local add_remove = function(func,_table,_nametable,name)
	if func == "remove" then 
		if not _nametable[name] then return end
		local x = #_table
		if _nametable[name] == x then 
			_table[x] = nil
			_nametable[name] = nil
		else
			-- position control
			-- lets find last name
			local lastname
			for t,o in pairs(_nametable) do
				if o == x then
					lastname = t
					break
				end
			end
			_table[_nametable[name]] = _table[x]
			_nametable[lastname] = _nametable[name]
			tremove(_nametable[name])
			_table[x] = nil			
		end
	else
		if _nametable[name] then return end
		local x = #_table
		_nametable[name] = x+1
		_table[x+1] = func
	end
end

M.set_updater = function(func,name,mode,force)
	if mode == .1 then
		add_remove(func,O_1,O_1_names,name)
	elseif mode == .2 then 
		add_remove(func,O_2,O_2_names,name)
	elseif mode == .5 then 
		add_remove(func,O_5,O_5_names,name)
	elseif mode == 1 then 
		add_remove(func,O,O_names,name)
	end
	--force update
	if func == "remove" or not force then return end func()
end

M.addafter(function()
	local a = O_1
	local b = O_2
	local c = O_5
	local d = O
	
	local n_1 = 0
	local n_2 = 0
	local n_3 = 0
	local n_4 = 0
	
	local do_table = function(self)
		if not self[1] then return end
		for i=1,#self do
			self[i]()
		end
	end
	
	Update:SetScript("OnUpdate",function(self,t)
		n_1 = n_1 + t
		if n_1 < .1 then return end
		n_2 = n_2 + n_1
		n_3 = n_3 + n_1
		n_4 = n_4 + n_1
		do_table(a)
		n_1 = 0
		if n_2 >= .2 then
			do_table(b)
			n_2 = 0
		end
		if n_3 >= .5 then
			do_table(c)
			n_3 = 0
		end
		if n_4 >= 1 then
			do_table(d)
			n_4 = 0
		end	
	end)
	
	M.get_update_state = function(mode)
		if mode == .1 or not mode then return n_1 end
		if mode == .2 then return n_2 end
		if mode == .5 then return n_3 end
		if mode == 1 then return n_4 end
	end
end)
