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
local IS_DEBUG_ON = getUserConf(getDiceQQ(), "RssSubDebugger") == "on"
if not IS_DEBUG_ON then
    log.info = tostring
    log.warn = tostring
    log.error = tostring
end
local feed = msg.fromMsg:match("%[(.*)%]") or ""
if #feed == 0 then return log.info("帮助:\n\t{strRssSubRemove}[分片url]\n\t删除一个监听列表里的rss源。可通过【{strRssSubListAll}】查看分片url具体内容。\n示例:\n\t{strRssSubRemove}[academic_jyunko_cn]") end
feed,_ = feed:gsub("%[","")
feed,_ = feed:gsub("%]","")
local _C = Util.copy(C,false) ---@Const _config.lua
local keys = Util.keys(_C.feeds.online_src)
local obj = feed
if not _C.feeds.online_src[obj] then
    return log.warn("{strRssSubAlreadyRemoved}")
else
    _C.feeds.online_src[obj] = nil ---@_C 删除键值对
    os.remove(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..obj..".xml") ---@os 删除本地.xml文件
    if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
        return log.info("{strRssSubRemoveSuccess}")
    else
        return log.error("{strRssSubRemoveFail}".."\n写入配置时发生了不可避免的错误×")
    end
end
    