local component = require("component")
local colors = require("colors")
local event = require("event")
local terminal = require("term")
local unicode = require('unicode')
local os = require("os")
local srl = require("serialization")
local gpu = component.gpu

require("utiles/modem")
require('localization/localization')

local oldbg = gpu.getBackground()
local oldfg = gpu.getForeground()
local width, height = gpu.maxResolution()
local version = "ver 0.1"
local loadProgress = 0
--en, ru
local language = language('en')

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

--function splitString(inputstr, sep)
--  if sep == nil then
--    sep = "%s"
--  end
--  local t = {}
--  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
--    table.insert(t, str)
--  end
--  local table = srl.serialize(t) 
--  return table
--end

function drawString(text, x, y, bg, fg, value)
  local x = x or 0
  local y = y or 0
  local textLength = string.len(text)
  --local split = splitString(text)

  --print(split)

  local topRightX = width - textLength
  local bottomLeft = height - 1
  local bottomRight = width - textLength
  local centerX = (width - textLength) // 2
  local centerY = (height // 2) - 1
	
  if value == "topLeft" then
    drawPixel(x,y, bg, fg, text)
  elseif value == "topRight" then
    drawPixel(topRightX,y,bg,fg,text)
  elseif value == "bottomLeft" then
    drawPixel(x,bottomLeft, bg, fg, text)
  elseif value == "bottomRight" then
    drawPixel(bottomRight, bottomLeft, bg, fg, text)
  elseif value == "centerX" then
    drawPixel(centerX, y, bg, fg, text)
  end
  return x, y, value
end

--Выход
function exit()
  local tEvent = {event.pull("touch")}
  if tEvent[1] ~= nil then
    if tEvent[3] == 1 and tEvent[4] == 1 then
      drawString(language['exit'], nil, 49, 0x000000, 0xFFFFFF, "centerX")
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
	
	drawString(language['StartSys1'], nil, 20, 0x000000, 0xFFFFFF, "centerX")
	drawString(language['StartSys2'], nil, 21, 0x000000, 0xFFFFFF, "centerX")
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
  connect()
  --Кнопка выхода (dev)
  drawPixel(1,1,0x000000, 0xFF0040, "X")
end

function main()
  terminal.clear()
  drawUI()
  exit()
end

while true do
  main()
end
