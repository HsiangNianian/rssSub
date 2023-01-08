local DIR_SEP = package.config:sub(1,1)
package.path = getDiceDir()..
    DIR_SEP..'mod'..
        DIR_SEP..'rssSub'..
            DIR_SEP..'script'..
                DIR_SEP..'?.lua;'..
                    package.path
local Util = require('control.Utils')
local xml2lua = Util.prequire('xml.xml2lua') ---@module xml2lua
Util.prequire('Constant') ---@module CONST
Util.prequire('control._config') ---@module C
Util.prequire('control.logger') ---@module log
local IS_DEBUG_ON = getUserConf(getDiceQQ(), "RssSubDebugger") == "on"
if not IS_DEBUG_ON then
    log.info = tostring
    log.warn = tostring
    log.error = tostring
end
local List = C.feeds.online_src
local ListsKeyNum = #Util.keys(List)
if ListsKeyNum == 0 then
    return log.warn("{strRssSubListNone}")
else
    local ListObject,i = "",ListsKeyNum
    for k,v in pairs(List) do
        ListObject = "\n["..i.."]"..k..":"..v..ListObject
        i = i - 1
    end
    return log.info("{strRssSubListRespo}"..ListObject)
end