local modname = "Util"
local M = {}
_G[modname] = M
package.loaded[modname] = M
local DIR_SEP = package.config:sub(1,1)
local unpack = table.unpack
M.prequire = function(...)
    local ok, mod=pcall(require, ...)
    if not ok then return nil, mod end
    return mod
end
M.ploadLua = function(...)
    local ok, mod=pcall(loadLua, ...)
    if not ok then return nil, mod end
    return mod
end
M.merge = function(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
end
M.isFileExist=function(path)
    f=io.open(path,"r")
    return f~=nil and f:close();
end;
M.keys = function(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end
M.filter = function(t, fn)
    for k, v in pairs(t) do
        if not fn(v, k) then t[k] = nil end
    end
end
M.keyof = function(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then return k end
    end
    return nil
end
M.indexof = function(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then return i end
    end
	return false
end
M.values = function(hashtable)
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end
local function value2string(value, isArray)
    if type(value)=='table' then
       return M.table2string(value, isArray)
    elseif type(value)=='string' then
        return "\""..value.."\""
    else
       return tostring(value)
    end
end
function M.string2table(str)
    if str == nil or type(str) ~= "string" or str == "" then
        return {}
    end
	return load("return " .. str)()
end
M.write = function(path, text, mode)
    file = io.open(path, mode) --"a"
    if file then
        io.output(file)
        io.write(text)
        io.close()
        return true
    else
        return false
    end
end
M.read = function(path, mode)
    local text = ""
    local file = io.open(path, mode)
    if (file ~= nil) then
        text = file.read(file, "*a")
        io.close(file)
    else
        return false
    end
    return text
end
function M.table2string(t, isArray)
    if t == nil then return "" end
    local sStart = "{"

    local i = 1
    for key,value in pairs(t) do
        local sSplit = ","
        if i==1 then
            sSplit = ""
        end

        if isArray then
            sStart = sStart..sSplit..value2string(value, isArray)
        else
            if type(key)=='number' or type(key) == 'string' then
                sStart = sStart..sSplit..'['..value2string(key).."]="..value2string(value)
            else
                if type(key)=='userdata' then
                    sStart = sStart..sSplit.."*s"..M.table2string(getmetatable(key)).."*e".."="..value2string(value)
                else
                    sStart = sStart..sSplit..key.."="..value2string(value)
                end
            end
        end

        i = i+1
    end

	sStart = sStart.."}"
	return sStart
end
--! @brief ??????TryCatch???
--! @param t ???????????????
--!
--! ????????????try..catch..finally???
--! ???try??????????????????????????????????????????????????????catch????????????????????????try????????????
--! ???catch?????????????????????????????????????????????????????????????????????catch????????????
--! finally?????????????????????try??????catch????????????
M.TryCatch = function(t)
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

--Unit????????????
---??????????????????????????????
---@param lst table
---@return number @?????????
M.UnitListUpdate = function(lst)
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

---@param table
---@param obj object|table
---@return number @?????????
M.UnitListAppend = function(lst, obj)
    if IsValid(obj) then
        local n = #lst
        lst[n + 1] = obj
        return n + 1
    elseif IsValid(obj[1]) then
        return M.UnitListAppendList(lst, obj)
    else
        return #lst
    end
end

---?????????????????????
---@param table
---@param objlist table
---@return number @??????????????????????????????
M.UnitListAppendList = function(lst, objlist)
    local n = #lst
    local n2 = #objlist
    for i = 1, n2 do
        lst[n + i] = objlist[i]
    end
    return n + n2
end

---??????????????????????????????????????????
---@param table
---@param obj any
---@return number
M.UnitListFindUnit = function(lst, obj)
    local n = #lst
    for i = 1, n do
        local z = lst[i]
        if z == obj then
            return i
        end
    end
    return 0
end

---????????????object?????????????????????????????????
---????????????????????????????????????????????????
---@param table
---@param obj object|table
---@return number @?????????
M.UnitListInsertEx = function(lst, obj)
    local l = M.UnitListFindUnit(lst, obj)
    if l == 0 then
        return M.UnitListAppend(lst, obj)
    else
        return l
    end
end

---????????????????????????
M.GetUnpackList = function(...)
    local ref, p = {}, { ... }
    for _, v in pairs(p) do
        if type(v) ~= 'table' then
            table.insert(ref, v)
        else
            local tmp = M.GetUnpackList(unpack(v))
            for _, t in pairs(tmp) do
                table.insert(ref, t)
            end
        end
    end
    return ref
end

---?????????????????????????????????????????????
M.GetUnpack = function(...)
    return unpack(M.GetUnpackList(...))
end

---?????????
---@param t table @???????????????
---@param all boolean @??????????????????
---@return table
M.copy = function(t, all)
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

---???????????????
---@param str string @?????????????????????
---@param length number @???????????????
---@return number, table
M.SplitText = function(str, length)
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

---????????????????????????
---@param list table @?????????
---@param n number @??????????????????
---@param pos number @????????????
---@param s number @????????????
---@return table, number
M.GetListSection = function(list, n, pos, s)
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

---????????????????????????
---@param input string @?????????????????????
---@param delimiter string @?????????
---@return fun():(string, number)
M.Split = function(input, delimiter)
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

---???????????????
---@param input string @?????????????????????
---@param delimiter string @?????????
---@return table @????????????????????????
M.SplitText = function(input, delimiter)
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

return M