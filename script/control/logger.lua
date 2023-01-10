local modname = "log"
local M = {}
_G[modname] = M
package.loaded[modname] = M
local date = os.date
local format = string.format
local tostring = tostring
local DIR_SEP = package.config:sub(1,1)
package.path = getDiceDir()..
    DIR_SEP..'mod'..
        DIR_SEP..'rssSub'..
            DIR_SEP..'script'..
                DIR_SEP..'?.lua;'..
                    package.path
local Util = require('control.Utils')
function M.info(...)
	local vargs = {...}
	local logString = ""

	if #vargs >= 1 then logString = format("%s", tostring(vargs[1]))
		for i = 2, #vargs do
			logString = format("%s      %s", logString, tostring(vargs[i]))
		end
	end
	
	local content = format("[INFO %s]\n %s", date("%Y.%m.%d %H:%M:%S"), logString)
    Util.write(CONST.DIR_LIST.MOD_SCRIPT.."log"..DIR_SEP..date("%Y-%m-%d")..".log",content.."\n","a+")
	return content
end
function M.warn(...)
	local vargs = {...}
	local logString = ""

	if #vargs >= 1 then logString = format("%s", tostring(vargs[1]))
		for i = 2, #vargs do
			logString = format("%s      %s", logString, tostring(vargs[i]))
		end
	end

	local content = format("[WARN %s]\n %s", date("%Y.%m.%d %H:%M:%S"), logString)
    Util.write(CONST.DIR_LIST.MOD_SCRIPT.."log"..DIR_SEP..date("%Y-%m-%d")..".log",content.."\n","a+")
	return content
end
function M.error(...)
	local vargs = {...}
	local logString = ""

	if #vargs >= 1 then logString = format("%s", tostring(vargs[1]))
		for i = 2, #vargs do
			logString = format("%s      %s", logString, tostring(vargs[i]))
		end
	end

	local content = format("[ERROR %s]\n %s", date("%Y.%m.%d %H:%M:%S"), logString)
    Util.write(CONST.DIR_LIST.MOD_SCRIPT.."log"..DIR_SEP..date("%Y-%m-%d")..".log",content.."\n","a+")
	return content
end
return M
