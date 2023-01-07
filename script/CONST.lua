local _M = {}
local DIR_SEP = package.config:sub(1,1)

_M.DEFAULT_CONFIG = [[_C = {
    target = {
        user_id = {
            2753364619
        },
        group_id = {
            
        }
    },
    feeds = {
        native_src = {
        
        },
        online_src = {
            academic_jyunko_cn = "https://academic.jyunko.cn/feed.xml"
        }
    }
}]]
_M.DIR_LIST = {
    MOD_SCRIPT = getDiceDir()..DIR_SEP.."mod"..DIR_SEP.._M.INFO.MOD_NAME..DIR_SEP.."script"..DIR_SEP,
    CONTROL = _M.DIR_LIST.MOD_SCRIPT.."control"..DIR_SEP,
    XML2LUA = _M.DIR_LIST.MOD_SCRIPT.."xml2lua"..DIR_SEP,
}
_M.INFO = {
    VERSION = 'alpha-0.1',
    MOD_NAME = 'rssSub',
    AUTHOR = '简律纯',
    LICENSE = 'MIT'
}

return _M
