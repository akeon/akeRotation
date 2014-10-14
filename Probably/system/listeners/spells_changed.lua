-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

ProbablyEngine.listener.register('SPELLS_CHANGED', clearOverloadCache)

--[[
local activeFrame = CreateFrame('Frame', 'activeCastFrame', UIParent)
activeFrame:SetWidth(32)
activeFrame:SetHeight(32)
activeFrame:SetPoint("CENTER", UIParent, "CENTER")
activeFrame.texture = activeFrame:CreateTexture()
activeFrame.texture:SetTexture("Interface/CURSOR/Attack")
activeFrame.texture:SetAllPoints(activeFrame)
activeFrame:SetFrameStrata(HIGH)

buttonMap = {
	
}

function populateActions()
	table.empty(buttonMap)
	local bars = {
		"ActionButton",
		"MultiBarBottomRightButton",
		"MultiBarBottomLeftButton",
		"MultiBarRightButton",
		"MultiBarLeftButton"
	}
	for _, group in ipairs(bars) do
		for i =1, 10 do
			local button = _G[group .. i]
			if button then
				local actionType, id, subType = GetActionInfo(ActionButton_CalculateAction(button, "LeftButton"))
				if actionType == 'spell' then
					local spell = GetSpellInfo(id)
					if spell then
						buttonMap[spell] = button
					end
				end
			end
		end
	end
end

ProbablyEngine.listener.register('ACTIONBAR_SLOT_CHANGED', populateActions)

local lastFrame = false
local function showActiveSpell()
	local current_spell = ProbablyEngine.current_spell
	local spellButton = buttonMap[current_spell]
	if spellButton then
		activeFrame:Show()
		activeFrame:SetPoint("CENTER", spellButton, "CENTER")
	end
end


ProbablyEngine.timer.register("visualCast", showActiveSpell, 50)


ProbablyEngine.listener.register("UNIT_SPELLCAST_SUCCEEDED", function(...)
  local turbo = ProbablyEngine.config.read('pe_turbo', false)
  local unitID, spell, rank, lineID, spellID = ...
  if unitID == "player" then
  	if spell == ProbablyEngine.current_spell then
  		activeFrame:Hide()
  		ProbablyEngine.current_spell = false
  	end
  end
end)
]]