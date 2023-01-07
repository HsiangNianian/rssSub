local DIR_SEP = package.config:sub(1,1)
package.path = getDiceDir()..DIR_SEP..'mod'..DIR_SEP..'rssSub'..DIR_SEP..'script'..DIR_SEP..'?.lua;'..package.path
local Util = require('control.util')
local CONST = Util.prequire('CONST')
local json = Util.prequire('json')
local xml2lua = Util.prequire('xml2lua.xml2lua')
local config = Util.prequire('control._config')
local log = Util.prequire('control.logger')

return "{strRssSubOnFail}"