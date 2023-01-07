local DIR_SEP = package.config:sub(1,1)
package.path = getDiceDir()..
    DIR_SEP..'mod'..
        DIR_SEP..'rssSub'..
            DIR_SEP..'script'..
                DIR_SEP..'?.lua;'..
                    package.path
local Util = require('control.Utils')
Util.prequire('Constant')
Util.prequire('xml2lua.tsj')
Util.prequire('xml2lua.xml2lua')
Util.prequire('control._config')
Util.prequire('control.logger')
local feed = msg.fromMsg:match("https?://[^%s]*%.xml") or ""
local status,content = http.get(feed)
if status then
    local url,_ = feed:match("https?%://(.*)/"):gsub("%.","_")
    -- local _C = C ---@Const _config.lua
    C.feeds.online_src[url] = feed
    if Util.write("C = "..Util.table2string(C),CONST.CONTROL.."_config.lua","a") then
        msg:echo("{strRssSubAddSuccess}")
    else
        msg:echo("{strRssSubAddFail}".."\n写入配置时发生了不可避免的错误×")
    end
else
    msg:echo("{strRssSubAddFail}".."\n无效的rss源！")
end