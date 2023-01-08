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
local uid = msg.fromQQ
local gid = msg.gid ---@msg nil
local _C = Util.copy(C,false) ---@Const _config.lua
local Switch = getUserConf(getDiceQQ(), "RssSubSwitch") == "on"
if Switch then ---@SwitchOn
    if gid then
        if _C.target.group_id[gid] then ---@AlreadyOn
            return log.warn("{strRssSubAlreadyOn}")
        else
            _C.target.group_id[gid] = true
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                return log.info("{strRssSubOnSuccess}")
            else
                return log.error("{strRssSuSwitchFail}".."\n写入配置时发生了不可避免的错误×")
            end
        end
    else
        if _C.target.user_id[uid] then ---@AlreadyOn
            return log.warn("{strRssSubAlreadyOn}")
        else
            _C.target.user_id[uid] = true
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                return log.info("{strRssSubOnSuccess}")
            else
                return log.error("{strRssSubOnFail}".."\n写入配置时发生了不可避免的错误×")
            end
        end
    end
else ---@SwitchOff
    if gid then
        if not _C.target.group_id[gid] then ---@AlreadyOff
            return log.warn("{strRssSubAlreadyOff}")
        else
            _C.target.group_id[gid] = nil
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                return log.info("{strRssSubOffSuccess}")
            else
                return log.error("{strRssSubOffFail}".."\n写入配置时发生了不可避免的错误×")
            end
        end
    else
        if not _C.target.user_id[uid] then ---@AlreadyOff
            return log.warn("{strRssSubAlreadyOff}")
        else
            _C.target.user_id[uid] = nil
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                return log.info("{strRssSubOffSuccess}")
            else
                return log.error("{strRssSubOffFail}".."\n写入配置时发生了不可避免的错误×")
            end
        end
    end
end