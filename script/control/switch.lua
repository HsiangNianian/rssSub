local DIR_SEP = package.config:sub(1,1)
package.path = getDiceDir()..
    DIR_SEP..'mod'..
        DIR_SEP..'rssSub'..
            DIR_SEP..'script'..
                DIR_SEP..'?.lua;'..
                    package.path
local Util = require('control.Utils')
local xml2lua = Util.prequire('xml.xml2lua') ---@module xml2lua
local yaml = Util.prequire('control.yaml') ---@module yaml
Util.prequire('Constant') ---@module CONST
Util.prequire('control._config') ---@module C
Util.prequire('control.logger') ---@module log
local IS_DEBUG_ON = getUserConf(getDiceQQ(), "RssSubDebugger") == "on"
if not IS_DEBUG_ON then
    log.info = tostring
    log.warn = tostring
    log.error = tostring
end
local strRssSubSwitchOn = yaml.parse(Util.read(CONST.DIR_LIST.MOD.."speech"..DIR_SEP.."strRssSub.yml"))["strRssSubSwitchOn"]
local uid = msg.fromQQ
local gid = msg.gid ---@msg nil
local _C = Util.copy(C,false) ---@Const _config.lua
local Switch = msg.fromMsg == strRssSubSwitchOn
if Switch then ---@SwitchOn
    if gid then
        if _C.target.group_id[tostring(gid)] then ---@AlreadyOn
            msg:echo(log.warn("{strRssSubSwitchAlreadyOn}"))
        else
            _C.target.group_id[tostring(gid)] = true
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                msg:echo(log.info("{strRssSubSwitchOnSuccess}"))
            else
                msg:echo(log.error("{strRssSuSwitchonFail}".."\n写入配置时发生了不可避免的错误×"))
            end
        end
    else
        if _C.target.user_id[uid] then ---@AlreadyOn
            msg:echo(log.warn("{strRssSubSwitchAlreadyOn}"))
        else
            _C.target.user_id[uid] = true
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                msg:echo(log.info("{strRssSubSwitchOnSuccess}"))
            else
                msg:echo(log.error("{strRssSubSwitchOnFail}".."\n写入配置时发生了不可避免的错误×"))
            end
        end
    end
else ---@SwitchOff
    if gid then
        if not _C.target.group_id[tostring(gid)] then ---@AlreadyOff
            msg:echo(log.warn("{strRssSubSwitchAlreadyOff}"))
        else
            _C.target.group_id[tostring(gid)] = nil
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                msg:echo(log.info("{strRssSubSwitchOffSuccess}"))
            else
                msg:echo(log.error("{strRssSubSwitchOffFail}".."\n写入配置时发生了不可避免的错误×"))
            end
        end
    else
        if not _C.target.user_id[uid] then ---@AlreadyOff
            msg:echo(log.warn("{strRssSubSwitchAlreadyOff}"))
        else
            _C.target.user_id[uid] = nil
            if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
                msg:echo(log.info("{strRssSubSwitchOffSuccess}"))
            else
                msg:echo(log.error("{strRssSubSwitchOffFail}".."\n写入配置时发生了不可避免的错误×"))
            end
        end
    end
end