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
    fs.makeDirectory('home/control_sys/utiles')
    fs.makeDirectory('home/control_sys/localization')

    for i = 1, #download do
        if i <= 2 then
          print(i)
          shell.setWorkingDirectory("/home/control_sys")
          shell.execute('wget https://raw.githubusercontent.com/maksorr2/control_sys_oc/main/'..download[i])
        elseif i == 3 then
          print(i)
          shell.setWorkingDirectory("/home/control_sys/utils")
          shell.execute('wget https://raw.githubusercontent.com/maksorr2/control_sys_oc/main/'..download[i])
        elseif i > 3 then
          print(i)
          shell.setWorkingDirectory("/home/control_sys/localization")
          shell.execute('wget https://raw.githubusercontent.com/maksorr2/control_sys_oc/main/'..download[i])
        end
    end
    shell.setWorkingDirectory("/home/control_sys")
else
    print('Project was been downloaded already! | Проект уже существует!')
    shell.setWorkingDirectory("/home/control_sys")
end