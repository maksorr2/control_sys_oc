local fs = require('filesystem')
local srl = require("serialization")

function language(language)
    if fs.exists('home/control_sys/localization/'..language..'.lua') then
        local file = io.open('/home/control_sys/localization/'..language..'.lua')
        local content = file:read("*a")
        local table = srl.unserialize(content)
        file:close()

        return table
    elseif fs.exists('home/control_sys/logs') == false then
        fs.makeDirectory('home/control_sys/logs')
        local file = io.open('logs/errors.txt', 'wb') 
        local content = file:write("You didn't chosen any language | Вы не выбрали никакой язык")
        file:close()

    end
end