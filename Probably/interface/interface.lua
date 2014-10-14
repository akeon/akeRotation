-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

ProbablyEngine.interface = {}

-- Lag Timer stuff

PE_CycleLag = CreateFrame("Frame", "PE_CycleLag", UIParent)
local CycleLag = PE_CycleLag
CycleLag.show = false
CycleLag:SetFrameLevel(90)
CycleLag:SetWidth(32)
CycleLag:SetHeight(32)
CycleLag:SetPoint("CENTER", UIParent)
CycleLag:SetMovable(true)
CycleLag:Hide()

local CycleLag_texture = CycleLag:CreateTexture(nil, "BACKGROUND")
CycleLag_texture:SetTexture(0,0,0,0.3)
CycleLag_texture:SetAllPoints(CycleLag)
CycleLag.texture = CycleLagText_texture

CycleLag.text = CycleLag:CreateFontString('PE_CycleLagText')
CycleLag.text:SetFont("Fonts\\ARIALN.TTF", 10)
CycleLag.text:SetPoint("CENTER", CycleLag, 0, 0)
CycleLag.text:SetText("Action")

CycleLag:SetScript("OnMouseDown", function(self, button)
  if not self.isMoving then
    self:StartMoving()
    self.isMoving = true
  end
end)
CycleLag:SetScript("OnMouseUp", function(self, button)
  if self.isMoving then
    self:StopMovingOrSizing()
    self.isMoving = false
  end
end)
CycleLag:SetScript("OnHide", function(self)
  if self.isMoving then
    self:StopMovingOrSizing()
    self.isMoving = false
  end
end)

ProbablyEngine.timer.register('cycleLag', function(elapsed)
  PE_CycleLag.text:SetText(math.floor(elapsed * 1000) .. 'ms')
end, 1000)

function ProbablyEngine.interface.init()
  ProbablyEngine.interface.minimap.create()
end
