local fileName = "rss_shab_fun_github_issue_HsiangNianian_rssSub_all"
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
local _C = C
local status,online_content = http.get(_C.feeds.online_src[fileName])
if not Util.isFileExist(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..fileName..".xml") then
Util.write(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..fileName..".xml",online_content,"w")
end
local native_f = rss.feed(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..fileName..".xml")
if not status then return {} end
Util.write(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP.."tmp",online_content,"w")
local online_f = rss.feed(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP.."tmp","r")
local native_post = native_f.items
local online_post = online_f.items
if #online_post > #native_post then
    Util.write(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..fileName..".xml",online_content,"w")
    return {fileName}
else
    return false
end
