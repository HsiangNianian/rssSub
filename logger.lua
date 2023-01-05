local date = os.date
local format = string.format
local tostring = tostring

local function log(...)
	local vargs = {...}
	local logString = ""

	if #vargs >= 1 then logString = format("%s", tostring(vargs[1]))
		for i = 2, #vargs do
			logString = format("%s      %s", logString, tostring(vargs[i]))
		end
	end

	msg:echo(format("[%s] %s", date("%Y.%m.%d %H:%M:%S"), logString))
end

return log