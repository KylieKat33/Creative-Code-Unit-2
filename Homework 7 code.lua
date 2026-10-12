Homework 7 code
require("L5")
-- Homework 7: Randomization and For Loops
-- Left side:  a daisy built from a circle of petals (and a spiral of seeds)
-- Right side: a honeycomb built from a grid of hexagons
--
-- Click anywhere to re-roll the randomness. Hover over a hexagon to light it up.

require("L5")

-- ---------------------------------------------------------------
-- COLORS
-- RISO inks (swap these hex values for the class palette if they differ)
local RISO_TEAL      = "#00838A"
local RISO_SUNFLOWER = "#FFB511"
local RISO_ORANGE    = "#FF6C2F"
local RISO_PINK      = "#FF48B0"
local RISO_RED       = "#F15060"

-- Other colors
local PETAL_WHITE = "#FFFFFF"
local SEED_BROWN  = "#7A4B1E"
local NIGHT_NAVY  = "#14213D"
local CREAM       = "#FFF4DC"

-- Cells in the honeycomb pick their color at random from this list
local hexPalette = { RISO_ORANGE, RISO_PINK, RISO_RED, RISO_SUNFLOWER }

-- ---------------------------------------------------------------
-- SETTINGS
local PANEL_W = 500       -- each side is 500 x 500, so the canvas is 1000 x 500
local PANEL_H = 500

local PETALS = 16         -- daisy
local SEEDS  = 140

local HEX_R   = 32        -- honeycomb (distance from center to a corner)
local HEX_W   = math.sqrt(3) * HEX_R
local HEX_ROWS = 9
local HEX_COLS = 6

-- State that changes when you click
local seed = 1
local hexColors = {}      -- one random color per cell

function setup()
  size(PANEL_W * 2, PANEL_H)
  windowTitle("Homework 7: Daisy + Honeycomb")
  describe("A daisy whose petals appear one at a time on the left, and a honeycomb of hexagons that change color on the right.")
  frameRate(30)
  rollTheDice()
end

-- Picks a new seed for the daisy and a new random color for every hexagon
function rollTheDice()
  seed = math.floor(random(1, 100000))
  hexColors = {}
  for row = 1, HEX_ROWS do
    hexColors[row] = {}
    for col = 1, HEX_COLS do
      hexColors[row][col] = random(hexPalette)   -- RANDOM: pick a color from the list
    end
  end
end

function draw()
  -- This runs before the daisy locks the random seed, so it stays truly random.
  -- Every 45 frames (a set increment), one random cell picks a new color.
  if frameCount % 45 == 0 then
    local row = math.floor(random(1, HEX_ROWS + 1))
    local col = math.floor(random(1, HEX_COLS + 1))
    hexColors[row][col] = random(hexPalette)
  end

  drawDaisyPanel()
  drawHoneycombPanel()
end

-- ---------------------------------------------------------------
-- LEFT SIDE: circle arrangement
function drawDaisyPanel()
  noStroke()
  fill(RISO_TEAL)
  rect(0, 0, PANEL_W, PANEL_H)

  push()
  translate(PANEL_W / 2, PANEL_H / 2)

  -- The same seed every frame keeps the random petal sizes from flickering.
  -- Clicking changes the seed, which gives the daisy a new set of random petals.
  randomSeed(seed)

  -- Petals appear one at a time, then the whole cycle starts over.
  local visible = math.floor(frameCount / 6) % (PETALS + 6)

  -- FOR LOOP 1: a ring of petals
  for i = 0, PETALS - 1 do
    -- RANDOM: every petal gets its own length and a tiny wobble in its angle
    local petalLength = random(150, 185)
    local wobble      = random(-0.05, 0.05)

    if i < visible then
      local angle = i * TWO_PI / PETALS + wobble + frameCount * 0.002

      push()
      rotate(angle)
      -- every other petal is shaded a little differently
      if i % 2 == 0 then
        fill(PETAL_WHITE)
      else
        fill(CREAM)
      end
      ellipse(petalLength / 2 + 25, 0, petalLength, 34)
      pop()
    end
  end

  -- FOR LOOP 2: the center is a spiral of seeds placed 137.5 degrees apart
  local goldenAngle = radians(137.5)
  for n = 1, SEEDS do
    local r = 5.2 * math.sqrt(n)
    local a = n * goldenAngle
    local x = r * math.cos(a)
    local y = r * math.sin(a)

    -- RANDOM: each seed is a slightly different size
    local d = random(5, 9)

    -- the color alternates and the size grows a bit toward the edge
    if n % 3 == 0 then
      fill(RISO_SUNFLOWER)
    else
      fill(SEED_BROWN)
    end
    circle(x, y, d + n * 0.01)
  end

  pop()
end

-- ---------------------------------------------------------------
-- RIGHT SIDE: grid arrangement
function drawHoneycombPanel()
  noStroke()
  fill(NIGHT_NAVY)
  rect(PANEL_W, 0, PANEL_W, PANEL_H)

  -- start so the whole grid is centered in the right panel
  local gridW = HEX_W * HEX_COLS
  local gridH = HEX_R * 1.5 * (HEX_ROWS - 1) + HEX_R * 2
  local startX = PANEL_W + (PANEL_W - gridW) / 2 + HEX_W / 4
  local startY = (PANEL_H - gridH) / 2 + HEX_R

  -- FOR LOOPS 3 and 4: rows and columns of hexagons
  for row = 1, HEX_ROWS do
    for col = 1, HEX_COLS do
      local cx = startX + (col - 1) * HEX_W
      local cy = startY + (row - 1) * HEX_R * 1.5
      if row % 2 == 0 then
        cx = cx + HEX_W / 2          -- every other row slides over half a cell
      end

      -- the cells swell and shrink in a wave that rolls across the grid
      local pulse = 0.82 + 0.1 * math.sin(frameCount * 0.06 + col * 0.7 + row * 0.5)

      -- is the mouse over this one?
      local dx = mouseX - cx
      local dy = mouseY - cy
      local hovered = math.sqrt(dx * dx + dy * dy) < HEX_R * 0.85

      if hovered then
        fill(CREAM)
      else
        fill(hexColors[row][col])
      end

      -- FOR LOOP 5: six corners for each hexagon
      beginShape()
      for k = 0, 5 do
        local a = radians(60 * k - 30)
        vertex(cx + HEX_R * pulse * math.cos(a), cy + HEX_R * pulse * math.sin(a))
      end
      endShape(CLOSE)
    end
  end
end

-- ---------------------------------------------------------------
function mousePressed()
  rollTheDice()
end

function keyPressed()
  if key == "s" then
    save("hw7.png")
  end
end
