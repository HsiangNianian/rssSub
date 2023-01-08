msg_reply.switch_on = {
    keyword = {
        match = {"{strRssSubSwitchOn}"}
    }, 
    limit = {
        user_var = {
            trust = { at_least = 4}
        }
    }, 
    echo = function ()
        if getUserConf(getDiceQQ(), "RssSubSwitch") == "on" then
            return "{strRssSubSwitchAlreadyOn}"
        else
            setUserConf(getDiceQQ(), "RssSubSwitch", "on")
            loadLua("control.switch")
            return "{strRssSubSwitchOnSuccess}"
        end
    end
}

msg_reply.switch_off = {
    keyword = {
        match = {"{strRssSubSwitchOff}"}
    }, 
    limit = {
        user_var = {
            trust = { at_least = 4}
        }
    }, 
    echo = function () 
        if getUserConf(getDiceQQ(), "RssSubSwitch") == "off" then
            return "{strRssSubSwitchAlreadyOff}"
        else
            setUserConf(getDiceQQ(), "RssSubSwitch", "off")
            loadLua("control.switch")
            return "{strRssSubSwitchOffSuccess}"
        end
    end
}
