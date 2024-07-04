local srl = require("serialization")


function splitString(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
    end
    return t
end

local split = splitString('TEST \n popa \n sika')
local table = srl.serialize(split)
print(table)