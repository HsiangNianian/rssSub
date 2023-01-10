local fileName = "academic_jyunko_cn_feed"
local DIR_SEP = package.config:sub(1,1)
package.path = getDiceDir()..
    DIR_SEP..'mod'..
        DIR_SEP..'rssSub'..
            DIR_SEP..'script'..
                DIR_SEP..'?.lua;'..
                    package.path
local Util = require('control.Utils')
Util.prequire('Constant') ---@module CONST
local f = atom.feed(CONST.DIR_LIST.MOD_SCRIPT.."src"..DIR_SEP..fileName..".xml")
local function CST2UnixTimeStamp(timeStr)   -- 将CST格式的字符串转换为时间戳
    if timeStr then
        local res = os.time({year=string.sub(timeStr,1,4), month=string.sub(timeStr,6,7),day=string.sub(timeStr,9,10),hour=string.sub(timeStr,12,13),min=string.sub(timeStr,15,16),sec=string.sub(timeStr,18,19)   })   
        return tonumber(res)
    else
        return 1
    end
end
local t = CST2UnixTimeStamp(f.entries[1].pubDate)
local k = 1
for i=k,#f.entries do
    if t < CST2UnixTimeStamp(f.entries[i].pubDate) then
    t = CST2UnixTimeStamp(f.entries[i].pubDate)
    k = i
    break
    end
end
local post = f.entries[k]
return string.format("%s\n%s | %s\n\n%s 更新了 《%s》\n\n源链接：\n%s",post.pubDate,f.title,f.subtitle,post.author,post.title,f.id).."\n\n"..f.entries[k].title..CST2UnixTimeStamp(f.entries[k].pubDate)