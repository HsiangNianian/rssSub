local DIR_SEP = package.config:sub(1,1)
package.path = getDiceDir()..
    DIR_SEP..'mod'..
        DIR_SEP..'rssSub'..
            DIR_SEP..'script'..
                DIR_SEP..'?.lua;'..
                    package.path
local Util = require('control.Utils')
Util.prequire('Constant') ---@module CONST
Util.prequire('control._config') ---@module C
Util.prequire('control.logger') ---@module log
Util.prequire('module.rss') ---@module rss
Util.prequire('module.atom') ---@module atom
local _C = Util.copy(C,false)
local IS_DEBUG_ON = getUserConf(getDiceQQ(), "RssSubDebugger") == "on"
if not IS_DEBUG_ON then
    log.info = tostring
    log.warn = tostring
    log.error = tostring
end
local check = function(hashtable)
    if #Util.keys(hashtable) == 0 then return nil end
    for k,v in pairs(hashtable) do
        listener_path = CONST.DIR_LIST.MOD_SCRIPT.."plugins"..DIR_SEP.."listener"..DIR_SEP..k..".lua"
        if Util.isFileExist(listener_path) then
            return loadLua(listener_path)
        else
            local app = {}
            local status,online_content = http.get(v)
            local native_src = CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..k..".xml"
            local native_content = Util.read(native_src)
            if native_content ~= online_content then
                table.insert(app,k)
                Util.write(native_src,online_content,"w")
            end
            return app
        end
    end
end
local listener = check(_C.feeds.online_src) or {}
if type(listener) == "table" and #listener ~= 0 then
    for i=1,#listener do
        local content = listener[i]..
            " {strRssSubListener}"..
                "\n--------------------"..
                "\n".._C.feeds.online_src[listener[i]]
        local path = CONST.DIR_LIST.MOD_SCRIPT.."plugins"..DIR_SEP..listener[i]..".lua"
        for k,v in pairs(_C.target.user_id) do
            
            sendMsg(log.info((Util.isFileExist(path) and Util.ploadLua(path)) or content),0,k)
        end

        for k,v in pairs(_C.target.group_id) do
            sendMsg(log.info((Util.isFileExist(path) and Util.ploadLua(path)) or content),k,0)
        end
    end
elseif type(listener) == "table" and #listener == 0 then
    log.info("无更新")
else
    log.error("自定义listener失败")
end

