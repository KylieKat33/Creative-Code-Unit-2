require("L5")

-- draws a star: center x, center y, outer radius, inner radius
function drawStar (cx, cy, outer, inner)
  beginShape (TRIANGLE_FAN)
  vertex(cx, cy) 
  for i = 0, 10 do
    local angle = -HALF_PI + i * PI / 5
    local r = outer
    if i % 2 == 1 then
      r = inner
    end
    vertex(cx + cos(angle) * r, cy + sin(angle) * r)
  end
endShape()
end

 -- draws a regular polygon: center x, center y, radius, number of sides
 function drawPolygon(cx, cy, r, n)
beginShape (TRIANGLE_FAN)
vertex(cx, cy) 
for i = 0, n do
  local angle = i * TWO_PI / n
  vertex(cx + cos(angle) * r, cy + sin(angle) * r)
end 
endShape()
end

-- draws a frog: body center x, body center y, body width
function drawFrog (cx, cy, s)
  local eye = s * 0.32
  local pupil = s * 0.16
  local eyeX = s * 0.22
  local eyeY = cy - s * 0.38

  -- body
  fill(60, 160, 60)
  stroke(20, 90, 20)
  strokeWeight(1)
  ellipse(cx, cy, s, s * 0.7)

  -- eyes (both the same size)
  fill(255)
  circle(cx - eyeX, eyeY, eye)
  circle(cx + eyeX, eyeY, eye)

  -- pupils (both the same size)
  fill(0)
  noStroke()
  circle(cx - eyeX, eyeY, pupil)
  circle(cx + eyeX, eyeY, pupil)

  -- mouth
  stroke(20, 90, 20)
  line(cx - s * 0.25, cy + s * 0.05, cx + s * 0.25, cy + s * 0.05)
end


function setup()
  size(800, 600)
  windowTitle("Cityscape")
  noCursor()
  describe('A night cityscape with a moon, tall building, and a frog on a balloon.')
end

function draw()
  -- night sky
  background(20, 24, 60)

  -- moon
  noStroke()
  fill(240, 240, 200)
  circle(width * 0.1, height * 0.12, width / 10)

  -- buildings: x, top edge, width, and height are all fractions of the canvas
  stroke(10, 10, 30)
  strokeWeight(2)

  -- building 1
  fill(70, 80, 120)
  rect(width * 0.00, height * 0.39, width * 0.18, height * 0.61)

  -- building 2 (tall)
  fill(110, 190, 255)
  rect(width * 0.18, height * 0.20, width * 0.12, height * 0.80)

  -- building 3
  fill(60, 70, 105)
  rect ( width * 0.30, height * 0.29, width * 0.13, height * 0.71)

  -- building 4
  fill(80, 90, 130)
  rect(width * 0.43, height * 0.29, width * 0.11, height * 0.71)

  -- building 5
  fill(100, 110, 150)
  rect(width * 0.54, height * 0.38, width * 0.10, height * 0.62)

  -- building 6 (clock tower)
  fill(65, 75, 110)
  rect(width * 0.64, height * 0.20, width * 0.09, height * 0.80)

  -- building 7
  fill(85, 95, 135)
  rect(width * 0.73, height * 0.33, width * 0.11, height * 0.67)

  -- building 8 (short)
  fill(75, 85, 125)
  rect(width * 0.84, height * 0.53, width * 0.06, height * 0.47)

  -- building 9 (right edge)
  fill(95, 105, 145)
  rect(width * 0.90, height * 0.17, width * 0.10, height * 0.83)

  -- ===== windows and doors =====
  noStroke()
  fill(255, 220, 100)

  -- building 1 windows (2columsn, 3 rows)
  for row = 0, 2 do
    for col = 0, 1 do
      rect(width * (0.03 + col * 0.07), height * (0.47 + row * 0.14), width * 0.04, height * 0.07)
    end
  end

   -- building 2 windows
   rect(width * 0.225, height * 0.24, width * 0.03, height * 0.05)
   rect(width * 0.21, height * 0.50, width * 0.06, height * 0.08)
   rect(width * 0.21, height * 0.68, width * 0.06, height * 0.08)

   -- building 3 windows
   rect(width * 0.32, height * 0.35, width * 0.09, height * 0.05)
   rect(width * 0.32, height * 0.52, width * 0.09, height * 0.09)

   -- building 4 arched windows (rect plus half-ellipse on top)
   for row = 0, 2 do
    for col = 0, 1 do
      local wx = width * (0.45 + col * 0.05)
      local wy = height * (0.37 + row * 0.15)
      rect(wx, wy, width * 0.03, height * 0.07)
      ellipse(wx + width * 0.015, wy, width * 0.03, height * 0.04)
    end
  end

  -- building 6 ovals
  ellipse(width * 0.685, height * 0.45, width * 0.07, height * 0.05)
  ellipse(width * 0.685, height * 0.660, width * 0.07, height * 0.05)
  ellipse(width * 0.785, height * 0.85, width * 0.07)

  -- building 5 stars
  drawStar(width * 0.59, height * 0.52, width * 0.035, width * 0.015)
  drawStar(width * 0.59, height * 0.70, width * 0.035, width * 0.015)

  -- building 8 hexagon
  drawPolygon(width * 0.87, height * 0.65, width * 0.02, 6)

  -- doors
  fill(70, 45, 30)
  rect(width * 0.06, height * 0.88, width * 0.06, height * 0.12)
  ellipse(width * 0.09, height * 0.88, width * 0.06, height * 0.06)
  rect(width * 0.365, height * 0.85, width * 0.04, height * 0.15)
  ellipse(width * 0.365, height * 0.85, width * 0.04, height * 0.06)
  rect(width * 0.465, height * 0.85, width * 0.04, height * 0.06)
  rect(width * 0.57, height * 0.86, width * 0.04, height * 0.14)
  rect(width * 0.665, height * 0.88, width * 0.04, height * 0.12)

  -- ===== clock tower face and spiral =====
  fill(235, 235, 210)
  circle(width * 0.685, height * 0.27, width * 0.07)

  noFill()
  stroke(20, 20, 40)
  strokeWeight(2)
local prevx = width * 0.685
local prevy = height * 0.27
for i = 1, 60 do
  local a = i * 0.35
  local r = i / 60 * width * 0.03
  local x = width * 0.685 + cos(a) * r
  local y = height * 0.27 + sin(a) * r
  line(prevx, prevy, x, y)
  prevx = x
  prevy = y
end
   
-- ===== zigzag on building 9 =====
fill(50, 55, 90)
stroke(10, 10, 30)
strokeWeight(1)
for i = 0, 6 do
  local y = height * (0.20 + i * 0.115)
  triangle(width * 0.90, y, width * 1.00, y, width * 0.90 + height * 0.0575, y + height * 0.115)
end

-- ===== cat on the roof of building 1 =====
fill(120, 120, 130)
stroke(10, 10, 30)
ellipse(width * 0.10, height * 0.36, width * 0.07, height * 0.05)
circle(width * 0.14, height * 0.325, width * 0.035)
triangle(width * 0.128, height * 0.315, width * 0.130, height * 0.285, width * 0.14, height * 0.307)
triangle(width * 0.14, height * 0.307, width * 0.150, height * 0.285, width * 0.152, height * 0.315)
line(width * 0.065, height * 0.36, width * 0.045, height * 0.32)

-- ===== frogs on the roof of buildings 3 and 7 =====
drawFrog(width * 0.36, height * 0.29, width * 0.07)
drawFrog(width * 0.785, height * 0.33 - width * 0.0245, width * 0.07)

-- ===== mouse follower: frog hanging from a balloon =====
-- balloon ( centered on the mouse)
fill(220, 60, 60)
stroke(100, 20, 20)
strokeWeight(1)
ellipse(mouseX, mouseY, width * 0.09, height * 0.16)

-- balloon shine
noStroke()
fill(255, 255, 255, 120)
circle(mouseX - width * 0.09, height * 0.16, width * 0.02)

-- balloon knot
fill(180, 20, 20)
triangle(mouseX, mouseY, mouseX - width * 0.008, mouseY + height * 0.095, mouseX + width * 0.008, mouseY + height * 0.095)

-- string
stroke(255)
strokeWeight(2)
line(mouseX, mouseY + height * 0.095, mouseX, mouseY + height * 0.2)

-- hanging frog
drawFrog(mouseX, mouseY + height * 0.2 + width * 0.03, width * 0.06)
end



