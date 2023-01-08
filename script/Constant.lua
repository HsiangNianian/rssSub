local modname = "CONST"
local M = {}
_G[modname] = M
package.loaded[modname] = M
local DIR_SEP = package.config:sub(1,1)
M.INFO = {
    VERSION = 'release-0.1.2',
    MOD_NAME = 'rssSub',
    AUTHOR = '简律纯',
    LICENSE = 'MIT'
};
M.DIR_LIST = {}
M.DIR_LIST.MOD_SCRIPT = getDiceDir()..DIR_SEP.."mod"..DIR_SEP..M.INFO.MOD_NAME..DIR_SEP.."script"..DIR_SEP
M.CONTROL = M.DIR_LIST.MOD_SCRIPT.."control"..DIR_SEP
M.XML2LUA = M.DIR_LIST.MOD_SCRIPT.."xml2lua"..DIR_SEP
M.DEFAULT_CONFIG = [[_C = {
    target = {
        user_id = {
            ["2753364619"] = true
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