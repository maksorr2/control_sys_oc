local fs = require('filesystem')
local shell = require('shell')

local download = {
    'main.lua',
    'test.lua',
    'utiles/modem.lua',
    'localization/en.lua',
    'localization/ru.lua',
    'localization/localization.lua'
}
if fs.path('home/control_sys') == nil then
    fs.makeDirectory('home/control_sys')
    fs.open('home/control_sys')
    shell.execute('wget https://raw.githubusercontent.com/maksorr2/control_sys_oc/main/'..download)
else
    print('Файл уже существует')
end
