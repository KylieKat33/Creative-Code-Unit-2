
require("L5")

local CANVAS_W = 900
local CANVAS_H = 600
local landscape

function setup()
  size(CANVAS_W, CANVAS_H)
  windowTitle("Last Light")
  describe("A vivid city sunset above a parking lot, accented with subtle halos, cloud highlights, and pavement glints.")
  landscape = loadImage("urban-sunset.jpg")
end

function draw()
  image(landscape, 0, 0, CANVAS_W, CANVAS_H)
  drawAfterglow()
end

function drawAfterglow()
  noStroke()

  -- Layered coral and gold halos intensify the brightest streak of sunset.
  fill(255, 99, 105, 24)
  ellipse(622, 273, 244, 118)

  fill(255, 143, 103, 34)
  ellipse(620, 270, 158, 70)

  fill(255, 207, 145, 185)
  circle(620, 270, 18)

  noFill()
  stroke(255, 229, 188, 160)
  strokeWeight(1.5)
  ellipse(620, 270, 48, 48)

  -- Fine strokes echo the cloud band and guide the eye toward the horizon.
  stroke(255, 189, 139, 115)
  strokeWeight(2)
  line(465, 253, 698, 253)
  stroke(255, 119, 111, 105)
  strokeWeight(3)
  line(514, 286, 719, 286)
  stroke(255, 227, 184, 95)
  strokeWeight(1)
  line(571, 304, 755, 304)

  -- The roadside lamps become small warm anchors against the dusk.
  noStroke()
  fill(255, 174, 105, 38)
  ellipse(19, 306, 56, 56)
  fill(255, 222, 159, 190)
  circle(18, 303, 9)
  fill(255, 222, 159, 155)
  circle(37, 310, 8)
  noFill()
  stroke(255, 213, 156, 115)
  strokeWeight(1)
  ellipse(19, 306, 34, 34)

  -- Cool pavement glints contrast with the warmth above the silhouetted lot.
  stroke(130, 201, 220, 68)
  strokeWeight(2)
  line(68, 537, 222, 533)
  stroke(255, 174, 126, 75)
  strokeWeight(3)
  line(279, 556, 399, 551)
  stroke(204, 177, 221, 58)
  strokeWeight(2)
  line(705, 528, 843, 533)

  noStroke()
  fill(255, 142, 117, 36)
  ellipse(334, 574, 180, 13)
  fill(108, 194, 214, 35)
  ellipse(745, 573, 146, 10)
end
