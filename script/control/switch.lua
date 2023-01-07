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

return "{strRssSubOnFail}"