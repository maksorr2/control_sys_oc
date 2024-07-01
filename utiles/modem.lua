local modem = require("component").modem 
local serialize = require("serialization").serialize 

Modem={}

function Modem:new(name, port)
    local obj={}
    obj.name = name
    obj.port = port or 0
    setmetatable(obj, self)
    print('Modem: '..obj.name, obj.port)
    self.__index = self
    return obj
end

function Modem:createConnect(port)
    modem.open(port)
end

function Modem:closeConnect(port)
    modem.close(port)
end

function Modem:test(a)
    print('test: '..a)
end


function Modem:sendMessage(table, port)
    local message = serialization(table)
end


