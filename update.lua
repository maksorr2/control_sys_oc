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
if fs.path('home/control_sys') then
    fs.makeDirectory('home/control_sys')
    shell.setWorkingDirectory("/home/control_sys/")
    for i = 1, #download do
        shell.execute('wget https://raw.githubusercontent.com/maksorr2/control_sys_oc/main/'..download[i])
    end
else
    print('Project was been downloaded already! | Проект уже существует!')
end
