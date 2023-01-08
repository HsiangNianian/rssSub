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
local feed = msg.fromMsg:match("https?://[^%s]*%.xml") or ""
if #feed == 0 then return log.info([[帮助:
    {strRssSubAdd}[(\n)url]
    添加一个rss源订阅至监听列表。
示例:
    {strRssSubAdd}https://academic.jyunko.cn/feed.xml]]) end
local status,content = http.get(feed)
if status then
    local url,_ = feed:match("https?%://(.*)/"):gsub("%.","_")
    local _C = Util.copy(C,false) ---@Const _config.lua
    if _C.feeds.online_src[url] then
        return log.warn("{strRssSubAlreadyAdded}")
    else
        _C.feeds.online_src[url] = feed
        if Util.write(CONST.CONTROL.."_config.lua","C = "..Util.table2string(_C),"w") then
            return log.info("{strRssSubAddSuccess}")
        else
            return log.error("{strRssSubAddFail}".."\n写入配置时发生了不可避免的错误×")
        end
    end
else
    return log.warn("{strRssSubAddFail}".."\n无效的rss源！")
end