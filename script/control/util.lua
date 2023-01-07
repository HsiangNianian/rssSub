local _M = {}

_M.prequire = function(...)
    local ok, mod=pcall(require, ...)
    if not ok then return nil, mod end
    return mod
end

--! @brief 模拟TryCatch块
--! @param t 条件上下文
--!
--! 执行一个try..catch..finally块
--! 当try语句中出现错误时，将把错误信息发送到catch语句块，否则返回try函数结果
--! 当catch语句块被执行时，若发生错误将重新抛出，否则返回catch函数结果
--! finally块总是会保证在try或者catch后被执行
_M.TryCatch = function(t)
    assert(t.try ~= nil, "invalid argument.")

    local ret = {
        xpcall(t.try, function(err)
            return err .. "\n<=== inner traceback ===>\n" .. debug.traceback() .. "\n<=======================>"
        end)
    }
    if ret[1] == true then
        if t.finally then
            t.finally()
        end
        return unpack(ret, 2)
    else
        local cret

        if t.catch then
            cret = {
                xpcall(t.catch, function(err)
                    return "error in catch block: " .. err .. "\n<=== inner traceback ===>\n" .. debug.traceback() .. "\n<=======================>"
                end, ret[2])
            }
        end

        if t.finally then
            t.finally()
        end

        if cret == nil then
            error("unhandled error: " .. ret[2])
        else
            if cret[1] == true then
                return unpack(cret, 2)
            else
                error(cret[2])
            end
        end
    end
end

--Unit列表操作
---对一个对象表进行更新
---@param lst table
---@return number @表长度
_M.UnitListUpdate function(lst)
    local n = #lst
    local j = 0
    for i = 1, n do
        local z = lst[i]
        if IsValid(z) then
            j = j + 1
            lst[j] = z;
            if i ~= j then
                lst[i] = nil;
            end
        else
            lst[i] = nil;
        end
    end
    return j
end

---添加一个luastg object对象或者luastg object对象表到已有的对象表上
---@param lst table
---@param obj object|table
---@return number @表长度
_M.UnitListAppend = function(lst, obj)
    if IsValid(obj) then
        local n = #lst
        lst[n + 1] = obj
        return n + 1
    elseif IsValid(obj[1]) then
        return _M.UnitListAppendList(lst, obj)
    else
        return #lst
    end
end

---连接两个对象表
---@param lst table
---@param objlist table
---@return number @两个对象表的对象总和
_M.UnitListAppendList = function(lst, objlist)
    local n = #lst
    local n2 = #objlist
    for i = 1, n2 do
        lst[n + i] = objlist[i]
    end
    return n + n2
end

---返回指定对象在对象表中的位置
---@param lst table
---@param obj any
---@return number
_M.UnitListFindUnit = function(lst, obj)
    local n = #lst
    for i = 1, n do
        local z = lst[i]
        if z == obj then
            return i
        end
    end
    return 0
end

---添加一个luastg object对象或者luastg object对象表到已有的对象表上
---如果已有则返回目标当前的所在位置
---@param lst table
---@param obj object|table
---@return number @表长度
_M.UnitListInsertEx = function(lst, obj)
    local l = _M.UnitListFindUnit(lst, obj)
    if l == 0 then
        return _M.UnitListAppend(lst, obj)
    else
        return l
    end
end

---拆解表至同一层级
_M.GetUnpackList = function(...)
    local ref, p = {}, { ... }
    for _, v in pairs(p) do
        if type(v) ~= 'table' then
            table.insert(ref, v)
        else
            local tmp = _M.GetUnpackList(unpack(v))
            for _, t in pairs(tmp) do
                table.insert(ref, t)
            end
        end
    end
    return ref
end

---拆解表至同一层级并解包成参数列
_M.GetUnpack = function(...)
    return unpack(_M.GetUnpackList(...))
end

---复制表
---@param t table @要复制的表
---@param all boolean @是否深度复制
---@return table
_M.copy = function(t, all)
    local lookup = {}
    local function _copy(t)
        if type(t) ~= 'table' then
            return t
        elseif lookup[t] then
            return lookup[t]
        end
        local ref = {}
        lookup[t] = ref
        for k, v in pairs(t) do
            ref[_copy(k)] = _copy(v)
        end
        return setmetatable(ref, getmetatable(t))
    end
    if all then
        return _copy(t)
    else
        local ref = {}
        for k, v in pairs(t) do
            ref[k] = v
        end
        return setmetatable(ref, getmetatable(t))
    end
end

---整理字符串
---@param str string @要处理的字符串
---@param length number @单字符宽度
---@return number, table
_M.SplitText = function(str, length)
    local s = 0
    local list = {}
    local len = string.len(str)
    local i = 1
    while i <= len do
        local c = string.byte(str, i)
        local shift = 1
        if c > 0 and c <= 127 then
            shift = 1
            s = s + 1
        elseif (c >= 192 and c <= 223) then
            shift = 2
            s = s + 2
        elseif (c >= 224 and c <= 239) then
            shift = 3
            s = s + 2
        elseif (c >= 240 and c <= 247) then
            shift = 4
            s = s + 2
        end
        local char = string.sub(str, i, i + shift - 1)
        i = i + shift
        table.insert(list, char)
    end
    if length then
        s = s * length
    end
    return s, list
end

---按位置截取信息表
---@param list table @目标表
---@param n number @截取最大长度
---@param pos number @选择位标
---@param s number @锁定位标
---@return table, number
_M.GetListSection = function(list, n, pos, s)
    n = int(n or #list)
    s = min(max(int(s or n), 1), n)
    local cut, c, m = {}, #list, pos
    if c <= n then
        cut = list
    elseif pos < s then
        for i = 1, n do
            table.insert(cut, list[i])
        end
    else
        local t = max(min(pos + (n - s), c), pos)
        for i = t - n + 1, t do
            table.insert(cut, list[i])
        end
        m = min(max(n - (t - pos), s), n)
    end
    return cut, m
end

---分割字符串迭代器
---@param input string @要分割的字符串
---@param delimiter string @分割符
---@return fun():(string, number)
_M.Split = function(input, delimiter)
    local len = #input
    local pos = 0
    local i = 0
    return function()
        local p1, p2 = string.find(input, delimiter, pos + 1)
        if p1 then
            i = i + 1
            local cut = string.sub(input, pos + 1, p1 - 1)
            pos = p2
            return cut, i
        elseif pos < len then
            i = i + 1
            local cut = string.sub(input, pos + 1, len)
            pos = len
            return cut, i
        end
    end
end

---分割字符串
---@param input string @要分割的字符串
---@param delimiter string @分割符
---@return table @分割好的字符串表
_M.SplitText = function(input, delimiter)
    if (delimiter == "") then
        return false
    end
    local pos, arr = 0, {}
    for st, sp in function()
        return string.find(input, delimiter, pos, true)
    end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

return _M