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
local _C = Util.copy(C,false)
local IS_DEBUG_ON = getUserConf(getDiceQQ(), "RssSubDebugger") == "on"
if not IS_DEBUG_ON then
    log.info = tostring
    log.warn = tostring
    log.error = tostring
end
local check = function(hashtable)
    local app = {}
    for k,v in pairs(hashtable) do
        local status,online_content = http.get(v)
        local native_src = CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..k..".xml"
        local native_content = Util.read(native_src)
        if native_content ~= online_content then
            table.insert(app,k)
            Util.write(native_src,online_content,"w")
        end
    end
    return app
end
local listener = check(_C.feeds.online_src)
if #listener ~= 0 then
    for i=1,#listener do
        local content = listener[i]..
            "{strRssSubListener}"..
                "\n更新内容:\n\t暂时没写出来。"..
                    "\n\n链接:".._C.feeds.online_src[listener[i]]
        for k,v in pairs(_C.target.user_id) do
            sendMsg(log.info(content),0,k)
        end

        for k,v in pairs(_C.target.group_id) do
            sendMsg(log.info(content),k,0)
        end
    end
else
    return
end

