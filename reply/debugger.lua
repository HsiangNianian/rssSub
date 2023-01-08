msg_reply.debug_on = {
    keyword = {
        match = {"{strRssSubDebugOn}"}
    }, 
    limit = {
        user_var = {
            trust = { at_least = 4}
        }
    }, 
    echo = function ()
        if getUserConf(getDiceQQ(), "RssSubDebugger") == "on" then
            return "{strRssSubDebugAlreadyOn}"
        else
            setUserConf(getDiceQQ(), "RssSubDebugger", "on")
            return "{strRssSubDebugOnSuccess}"
        end
    end
}

msg_reply.debug_off = {
    keyword = {
        match = {"{strRssSubDebugOff}"}
    }, 
    limit = {
        user_var = {
            trust = { at_least = 4}
        }
    }, 
    echo = function () 
        if getUserConf(getDiceQQ(), "RssSubDebugger") == "off" then
            return "{strRssSubDebugAlreadyOff}"
        else
            setUserConf(getDiceQQ(), "RssSubDebugger", "off")
            return "{strRssSubDebugOffSuccess}"
        end
    end
}