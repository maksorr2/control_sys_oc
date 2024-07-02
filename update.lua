local fs = require('filesystem')
local shell = require('shell')

local download = {
    'main.lua',
    'test.lua',
    'utiles/modem.lua'
}

for i in download do
    shell.execute('wget https://github.com/maksorr2/control_sys_oc/'..download)
end