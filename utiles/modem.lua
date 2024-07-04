local modem = require("component")
local srl = require("serialization")
local event = require("event")


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
    if port ~= nil then
        modem.open(port)
    else
        local port = obj.port
        modem.open(port)
end

function Modem:closeConnect(port)
    modem.close(port)
end

function Modem:test(a)
    print('test: '..a)
end


function Modem:sendMessage(reciever, table, port)
    if port == nil then
        local port = 0
    end
    modem.open(port)
    local message = srl.serialize(table)
    modem.send(reciever, message, port)
end



function Modem:handleEvent(event_name, _, _, port, _, message)
    if (event_name) then 
        local listener_id = event.listen("modem_message", handleEvent)
        if (listener_id) ~= false then
            print('pass')
        else
            print("failed to register listener")
            return 
        end
    end
end

