local fs = require('filesystem')
local srl = require("serialization")


function localization(language, value)
    language = language or 'en' or 'ru'
    if fs.exists('home/localization/'..language.. '.lua') then
        local file = io.open('home/localization'..language.. '.lua', 'rb')
        print(file, content)
        print('home/localization/'..language.. '.lua')
        local content = file:read("*a")
        local table = srl.serialize(content)

        file:close()
    else 
        if fs.exists('home/logs') == false then
            fs.makeDirectory('home/logs')
            local file = io.open('logs/errors.txt', 'wb') 
            local content = file:write("You didn't chosen any language | Вы не выбрали никакой язык".. language)
            file:close()
        end
    end
    return (print('home/localization/'..language.. '.lua'))
end


