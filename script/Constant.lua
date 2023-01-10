local modname = "CONST"
local M = {}
_G[modname] = M
package.loaded[modname] = M
local DIR_SEP = package.config:sub(1,1)
M.INFO = {
    VERSION = 'release-1.1.0',
    MOD_NAME = 'rssSub',
    AUTHOR = '简律纯',
    LICENSE = 'MIT'
};
M.DIR_LIST = {}
M.DIR_LIST.MOD = getDiceDir()..DIR_SEP.."mod"..DIR_SEP..M.INFO.MOD_NAME..DIR_SEP
M.DIR_LIST.MOD_SCRIPT = M.DIR_LIST.MOD.."script"..DIR_SEP
M.CONTROL = M.DIR_LIST.MOD_SCRIPT.."control"..DIR_SEP
M.XML2LUA = M.DIR_LIST.MOD_SCRIPT.."xml2lua"..DIR_SEP
M.DEFAULT_CONFIG = [[_C = {
    target = {
        user_id = {
        },
        group_id = {
            
        }
    },
    feeds = {
        native_src = {
        
        },
        online_src = {
            
        }
    }
}]]
