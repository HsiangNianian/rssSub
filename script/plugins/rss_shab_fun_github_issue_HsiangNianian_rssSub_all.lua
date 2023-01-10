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
local native_f = rss.feed(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..fileName..".xml")
local status,data = http.get(C.feeds.online_src[fileName])
if not status then return nil end
--Util.write(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP.."tmp",data,"w")
local online_f = rss.feed(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP.."tmp","r")
-- 转换格林威治时间为时间戳
local iwday = {
    ["Sun"] = 1,
    ["Mon"] = 2,
    ["Tue"] = 3,
    ["Wed"] = 4, 
    ["Thu"] = 5, 
    ["Fri"] = 6, 
    ["Sat"] = 7, 
}
local imonth = {
    ["Jan"] = 1, 
    ["Feb"] = 2, 
    ["Mar"] = 3, 
    ["Apr"] = 4, 
    ["May"] = 5, 
    ["Jun"] = 6, 
    ["Jul"] = 7, 
    ["Aug"] = 8, 
    ["Sep"] = 9, 
    ["Oct"] = 10, 
    ["Nov"] = 11, 
    ["Dec"] = 12, 
}
local function GMT2TimeStamp(timeStr)
    local res = {
        year=tonumber(string.sub(timeStr,13,16)),   
        month=imonth[string.sub(timeStr,9,11)],
        day=tonumber(string.sub(timeStr,6,7)),
        hour=tonumber(string.sub(timeStr,18,19)),   
        min=tonumber(string.sub(timeStr,21,22)),
        sec=tonumber(string.sub(timeStr,24,25)) 
    }
    return os.time(res)
end
local native_issue_list = {}
local online_issue_list = {}
native_issue_list=Util.keys(native_f.items)
online_issue_list=Util.keys(online_f.items)
local f = online_f
local cont = ""
local dvc = #online_issue_list - #native_issue_list
Util.write(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..fileName..".xml",data,"w")
for i=1,dvc do
    local post = f.items[i]
    post.desc,_ = post.description:gsub("<[^>]+>","")
    cont = cont.."\f"..string.format("%s\nopened a new issue #%s\n--------------------\n\"%s\"\n\ncommited by %s\n%s\n%s",f.title,post.link:match("issues/(%d+)"),post.desc,post.author,post.pubDate,post.guid)
--string.format("%s\n%s closed an issue\n------------\n%s\n\nSee:\n%s",f.title,post.author,post.pubDate,post.guid)
end
return cont