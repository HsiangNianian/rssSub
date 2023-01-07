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
local check = function(...)
    return false
end
if check() then
    for k,v in pairs(_C.target.user_id) do
        sendMsg('滴滴~',0,v)
    end

    for k,v in pairs(_C.target.group_id) do
        sendMsg('滴滴~',v,0)
    end
end