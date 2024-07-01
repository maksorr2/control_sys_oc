local component = require("component")
local fs = require("filesystem")
local srl = require("serialization")


local modems = {}


--for address, name in component.list("gpu") do
--    table.insert(modems, component.proxy(address))
--end
local gpu1 = component.proxy('9485c201-a67d-4994-8157-8eac8a6bd8e7')
local gpu2 = component.proxy('6a465c0c-93fd-409b-b07a-037f3ab42d6d')


gpu1.bind('526542bc-bfa9-49ca-adc2-7ea810793469')
gpu2.bind('b53968e4-740c-409c-9ad9-5ea1a1e8bc7b')

gpu1.set(1, 1, 'test1')
gpu2.set(1, 1, 'test2')
--file = io.open('test.log', 'w')
--file:write(srl.serialize(modems))
--file:close()

