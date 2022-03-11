-- SUPPORT --
local fileSystemCache = {} 

if not isfile then 
  function isfile(path) 
    if fileSystemCache[path] then 
      return true 
    end 
    return false 
  end 
end

if not writefile then 
  function writefile(path, content) 
    fileSystemCache[path] = content 
  end 
end

if not readfile then 
  function readfile(path) 
    return fileSystemCache[path] 
  end 
end

if not delfile then 
  function delfile(path)
    fileSystemCache[path] = nil 
  end 
end

if not isfolder then 
  function isfolder()end 
end

if not makefolder then 
  function makefolder()end 
end
-- CODE --


local function WriteFile(path, content)
	path = "ArticleHub/"..path
	if (isfile(path)) then
		delfile(path)
		writefile(path, content)
	else
		writefile(path, content)
	end
end

local function ReadFile(path)
	path = "ArticleHub/"..path
	if (isfile(path)) then
		readfile(path)
	end
end

local function IsFile(path)
	path = "ArticleHub/"..path
	return isfile(path)
end

local function DelFile(path)
	path = "ArticleHub/"..path
	if (isfile(path)) then
		delfile(path)
	end
end

local alreadyInit = false
local funcs = {}

local function init()
	if (not alreadyInit) then
		local Player = game:GetService("Players")["LocalPlayer"]

		if ((isfolder and not isfolder("ArticleHub"))) then
			makefolder("ArticleHub")
		end

		if ((isfolder and not isfolder("ArticleHub/GlobalSettings"))) then
			makefolder("ArticleHub/GlobalSettings")
		end

		if (isfolder and not isfolder("ArticleHub/Users")) then
			makefolder("ArticleHub/Users")
		end

		if (isfolder and not isfolder("ArticleHub/Users/"..tostring(Player.UserId))) then
			makefolder("ArticleHub/Users/"..tostring(Player.UserId))
		end

		funcs.writefile = WriteFile
		funcs.readfile = ReadFile
		funcs.isfile = IsFile
		funcs.delfile = DelFile


		return funcs
	end
	return funcs
end

local ratio = {}

return setmetatable({},{
	__call = function(tab, ...)
		return init()
	end,
	__index = function(tab, key)
		if key == ("init" or "load") then
			return init
		end
		return ratio[key]
	end,
	__newindex = function(tab, key, value) -- writefile
		ratio[key] = value
	end,
})
