local fs = require('filesystem')
local shell = require('shell')

local download = {
    'main.lua',
    'test.lua',
    'utiles/modem.lua'
}
if fs.path('home/control_sys') ~= nil then
    fs.makeDirectory('home/control_sys')
    fs.open('home/control_sys')
end
--for i in download do
--    shell.execute('wget https://github.com/maksorr2/control_sys_oc/'..download)
--end