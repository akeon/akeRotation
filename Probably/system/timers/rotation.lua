-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

local function resolveGround(spell, target)
  if FireHack then
    CastSpellByName(spell)
    CastAtPosition(ObjectPosition(target))
  else
    local stickyValue = GetCVar("deselectOnClick")
    SetCVar("deselectOnClick", "0")
    CameraOrSelectOrMoveStart(1) -- this is unlocked
    CastSpellByName(spell)
    CameraOrSelectOrMoveStop(1) -- this isn't unlocked
    SetCVar("deselectOnClick", "1")
    SetCVar("deselectOnClick", stickyValue)
  end
end

local GetSpellInfo = GetSpellInfo

ProbablyEngine.current_spell = false

ProbablyEngine.cycleTime = ProbablyEngine.cycleTime or 50

ProbablyEngine.cycle = function(skip_verify)

  local turbo = ProbablyEngine.config.read('pe_turbo', false)
  local cycle =
    IsMounted() ~= 1
    and UnitInVehicle("player") ~= 1
    and ProbablyEngine.module.player.combat
    and ProbablyEngine.config.read('button_states', 'MasterToggle', false)
    and ProbablyEngine.module.player.specID

  if cycle or skip_verify then
    
    local spell, target = false

    local queue = ProbablyEngine.module.queue.spellQueue
    if queue ~= nil and ProbablyEngine.parser.can_cast(queue) then
      spell = queue
      target = 'target'
      ProbablyEngine.module.queue.spellQueue = nil
    elseif ProbablyEngine.parser.lastCast == queue then
      ProbablyEngine.module.queue.spellQueue = nil
    else
      spell, target = ProbablyEngine.parser.table(ProbablyEngine.rotation.activeRotation)
    end

    if not spell then
      spell, target = ProbablyEngine.parser.table(ProbablyEngine.rotation.activeRotation)
    end

    if spell then
      local spellIndex, spellBook = GetSpellBookIndex(spell)
      local spellID, name, icon
      if spellBook ~= nil then
        _, spellID = GetSpellBookItemInfo(spellIndex, spellBook)
        name, _, icon, _, _, _, _, _, _ = GetSpellInfo(spellIndex, spellBook)
      else
        spellID = spellIndex
        name, _, icon, _, _, _, _, _, _ = GetSpellInfo(spellID)
      end

      ProbablyEngine.buttons.icon('MasterToggle', icon)
      ProbablyEngine.current_spell = name

      if target == "ground" then
        resolveGround(name, 'target')
      elseif string.sub(target, -7) == ".ground" then
        target = string.sub(target, 0, -8)
        resolveGround(name, target)
      else
        if spellID == 110309 then
          RunMacroText("/target " .. target)
          target = "target"
        end
        CastSpellByName(name, target or "target")
        if spellID == 110309 then
          RunMacroText("/targetlasttarget")
        end
        if icon then
          ProbablyEngine.actionLog.insert('Spell Cast', name, icon, target or "target")
        end
      end

      if target ~= "ground" then
        ProbablyEngine.debug.print("Casting |T"..icon..":10:10|t ".. name .. " on ( " .. UnitName((target or 'target')) or 'Unknown' .. " )", 'spell_cast')
      else
        ProbablyEngine.debug.print("Casting |T"..icon..":10:10|t ".. name .. " on the ground!", 'spell_cast')
      end

    end
    
  end
end

ProbablyEngine.timer.register("rotation", function()
    ProbablyEngine.cycle()
end, ProbablyEngine.cycleTime)

ProbablyEngine.timer.register("oocrotation", function()
  local cycle =
    IsMounted() ~= 1
    and UnitInVehicle("player") ~= 1
    and ProbablyEngine.module.player.combat ~= true
    and ProbablyEngine.config.read('button_states', 'MasterToggle', false)
    and ProbablyEngine.module.player.specID ~= 0
    and ProbablyEngine.rotation.activeOOCRotation ~= false

  if cycle then
    local spell, target = ''
    spell, target = ProbablyEngine.parser.table(ProbablyEngine.rotation.activeOOCRotation, 'player')

    if target == nil then target = 'player' end
    if spell then
      local spellIndex, spellBook = GetSpellBookIndex(spell)
      local spellID, name, icon
      if spellBook ~= nil then
        _, spellID = GetSpellBookItemInfo(spellIndex, spellBook)
        name, _, icon, _, _, _, _, _, _ = GetSpellInfo(spellIndex, spellBook)
      else
        spellID = spellIndex
        name, _, icon, _, _, _, _, _, _ = GetSpellInfo(spellID)
      end

      ProbablyEngine.buttons.icon('MasterToggle', icon)
      ProbablyEngine.current_spell = name

      if target == "ground" then
        resolveGround(name, 'target')
      elseif string.sub(target, -7) == ".ground" then
        target = string.sub(target, 0, -8)
        resolveGround(name, target)
      else
        if spellID == 110309 then
          RunMacroText("/target " .. target)
          target = "target"
        end
        CastSpellByName(name, target)
        if spellID == 110309 then
          RunMacroText("/targetlasttarget")
        end
        if icon then
          ProbablyEngine.actionLog.insert('Spell Cast', name, icon, target)
        end
      end

      if target ~= "ground" then
        ProbablyEngine.debug.print("Casting |T"..icon..":10:10|t ".. name .. " on ( " .. UnitName((target or 'target')) or 'Unknown' .. " )", 'spell_cast')
      else
        ProbablyEngine.debug.print("Casting |T"..icon..":10:10|t ".. name .. " on the ground!", 'spell_cast')
      end

    end
  end
end, ProbablyEngine.cycleTime)
