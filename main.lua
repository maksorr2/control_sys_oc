local component = require("component")
local gpu = component.gpu
local colors = require("colors")
local event = require("event")
local terminal = require("term")
local unicode = require('unicode')
local os = require("os")

require("utiles/modem")
require('localization/localization')

local oldbg = gpu.getBackground()
local oldfg = gpu.getForeground()
local width, height = gpu.maxResolution()
local version = "ver 0.1"
local loadProgress = 0
local language = localization('ru')
print(language)


local ModemA = Modem:new("modemA", 1)

--Текст и пиксели
function drawPixel(x,y,bg,fg,text)
  gpu.setBackground(bg)
  gpu.setForeground(fg)
  gpu.set(x,y, tostring(text))
  gpu.setBackground(oldbg)
  gpu.setForeground(oldfg)
end

--Прямоугольник
function drawRectangle(x, y, width, height, bg, fg, text)
  gpu.setBackground(bg)
  gpu.setForeground(fg)
  gpu.fill(x, y, width, height, tostring(text))
  gpu.setBackground(oldbg)
  gpu.setForeground(oldfg)
end 

function drawString(text, x, y, bg, fg, value)
	local l = string.len(text)
	local n = 0
	
	--Пробелы	
	for i = l, 1, -1 do
		if string.sub(text, i, i) == ' ' then
			n = n + 1
		end
	end

	if value == "here" then
		x = x
		drawPixel(x,y,bg, fg, text)
	elseif value == "center" then
		x = (x//2 - l) + (n*4)
		drawPixel(x,y,bg, fg, text)
	elseif value == "left" then
		x = width//8
		drawPixel(x,y,bg, fg, text)
	--elseif value == "left" then
	--	x = x - l*5+2 + n*4
	--	drawPixel(x,y,oldbg, oldfg, text)
	--elseif value == "right" then
	--	x = x - math.floor(l*6/2 + n*4)
	--	drawPixel(x,y,oldbg, oldfg, text)
	end
	return x,y
end

--Выход
function exit()
  local tEvent = {event.pull("touch")}
  if tEvent[1] ~= nil then
    if tEvent[3] == 1 and tEvent[4] == 1 then
      gpu.set(80, 20, "Bye-Bye!")
      os.sleep(1)
	  terminal.clear()
      os.exit()
    end
  end
end

--Логика прогресса

function drawLoading()

	gpu.setBackground(oldbg)
	
	os.sleep(0.5)
	
	drawString(language, 160, 20, 0x000000, 0xFFFFFF, "center")
	drawString("Please wait...", 165, 21, 0x000000, 0xFFFFFF, "center")
	drawString(version, 154, 50, 0x000000, 0xFF0040, "here") 

	drawRectangle(50, 23, 60, 1, 0x000000, 0xFFFFFF, unicode.char(0x2501))
	drawRectangle(49, 24, 1, 1, 0x000000, 0xFFFFFF, unicode.char(0x2503))
	drawRectangle(110, 24, 1, 1, 0x000000, 0xFFFFFF, unicode.char(0x2503))
	drawRectangle(50, 25, 60, 1, 0x000000, 0xFFFFFF, unicode.char(0x2501))
end

-- Прогресс
function drawProgress()
	loadProgress = loadProgress + 6.25
	if loadProgress ~= 0 then
		local barWidth = 157 * (loadProgress/100)
		drawRectangle(51, 24, barWidth, 1, 0x000000, 0xFFFFFF, unicode.char(0x2588))
	end
end

function connect()
	drawLoading()
	
	drawProgress()
end
function drawUI()
  --Кнопка выхода
  drawPixel(1,1,0x000000, 0xFF0040, "X")
end

function main()
  terminal.clear()
  drawUI()
  exit()
end

--while true do
--  main()
--end