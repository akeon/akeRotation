-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

local GetClassInfoByID = GetClassInfoByID

ProbablyEngine.rotation = {
  rotations = { },
  oocrotations =  { },
  custom = { },
  ooccustom = { },
  cdesc = { },
  buttons = { },
  specId = { },
  classSpecId = { },
  currentStringComp = "",
  activeRotation = false,
  activeOOCRotation = false,
}

ProbablyEngine.rotation.specId[62] = pelg('arcane_mage')
ProbablyEngine.rotation.specId[63] = pelg('fire_mage')
ProbablyEngine.rotation.specId[64] = pelg('frost_mage')
ProbablyEngine.rotation.specId[65] = pelg('holy_paladin')
ProbablyEngine.rotation.specId[66] = pelg('protection_paladin')
ProbablyEngine.rotation.specId[70] = pelg('retribution_paladin')
ProbablyEngine.rotation.specId[71] = pelg('arms_warrior')
ProbablyEngine.rotation.specId[72] = pelg('furry_warrior')
ProbablyEngine.rotation.specId[73] = pelg('protection_warrior')
ProbablyEngine.rotation.specId[102] = pelg('balance_druid')
ProbablyEngine.rotation.specId[103] = pelg('feral_combat_druid')
ProbablyEngine.rotation.specId[104] = pelg('guardian_druid')
ProbablyEngine.rotation.specId[105] = pelg('restoration_druid')
ProbablyEngine.rotation.specId[250] = pelg('blood_death_knight')
ProbablyEngine.rotation.specId[251] = pelg('frost_death_knight')
ProbablyEngine.rotation.specId[252] = pelg('unholy_death_knight')
ProbablyEngine.rotation.specId[253] = pelg('beast_mastery_hunter')
ProbablyEngine.rotation.specId[254] = pelg('marksmanship_hunter')
ProbablyEngine.rotation.specId[255] = pelg('survival_hunter')
ProbablyEngine.rotation.specId[256] = pelg('discipline_priest')
ProbablyEngine.rotation.specId[257] = pelg('holy_priest')
ProbablyEngine.rotation.specId[258] = pelg('shadow_priest')
ProbablyEngine.rotation.specId[259] = pelg('assassination_rogue')
ProbablyEngine.rotation.specId[260] = pelg('combat_rogue')
ProbablyEngine.rotation.specId[261] = pelg('subtlety_rogue')
ProbablyEngine.rotation.specId[262] = pelg('elemental_shaman')
ProbablyEngine.rotation.specId[263] = pelg('enhancement_shaman')
ProbablyEngine.rotation.specId[264] = pelg('restoration_shaman')
ProbablyEngine.rotation.specId[265] = pelg('affliction_warlock')
ProbablyEngine.rotation.specId[266] = pelg('demonology_warlock')
ProbablyEngine.rotation.specId[267] = pelg('destruction_warlock')
ProbablyEngine.rotation.specId[268] = pelg('brewmaster_monk')
ProbablyEngine.rotation.specId[269] = pelg('windwalker_monk')
ProbablyEngine.rotation.specId[270] = pelg('mistweaver_monk')

ProbablyEngine.rotation.classSpecId[62] = 8
ProbablyEngine.rotation.classSpecId[63] = 8
ProbablyEngine.rotation.classSpecId[64] = 8
ProbablyEngine.rotation.classSpecId[65] = 2
ProbablyEngine.rotation.classSpecId[66] = 2
ProbablyEngine.rotation.classSpecId[70] = 2
ProbablyEngine.rotation.classSpecId[71] = 1
ProbablyEngine.rotation.classSpecId[72] = 1
ProbablyEngine.rotation.classSpecId[73] = 1
ProbablyEngine.rotation.classSpecId[102] = 11
ProbablyEngine.rotation.classSpecId[103] = 11
ProbablyEngine.rotation.classSpecId[104] = 11
ProbablyEngine.rotation.classSpecId[105] = 11
ProbablyEngine.rotation.classSpecId[250] = 6
ProbablyEngine.rotation.classSpecId[251] = 6
ProbablyEngine.rotation.classSpecId[252] = 6
ProbablyEngine.rotation.classSpecId[253] = 3
ProbablyEngine.rotation.classSpecId[254] = 3
ProbablyEngine.rotation.classSpecId[255] = 3
ProbablyEngine.rotation.classSpecId[256] = 5
ProbablyEngine.rotation.classSpecId[257] = 5
ProbablyEngine.rotation.classSpecId[258] = 5
ProbablyEngine.rotation.classSpecId[259] = 4
ProbablyEngine.rotation.classSpecId[260] = 4
ProbablyEngine.rotation.classSpecId[261] = 4
ProbablyEngine.rotation.classSpecId[262] = 7
ProbablyEngine.rotation.classSpecId[263] = 7
ProbablyEngine.rotation.classSpecId[264] = 7
ProbablyEngine.rotation.classSpecId[265] = 9
ProbablyEngine.rotation.classSpecId[266] = 9
ProbablyEngine.rotation.classSpecId[267] = 9
ProbablyEngine.rotation.classSpecId[268] = 10
ProbablyEngine.rotation.classSpecId[269] = 10
ProbablyEngine.rotation.classSpecId[270] = 10

ProbablyEngine.rotation.register = function(specId, spellTable, arg1, arg2)
  local name = ProbablyEngine.rotation.specId[specId] or GetClassInfoByID(specId)

  local buttons, oocrotation = nil, nil

  if type(arg1) == "table" then
    oocrotation = arg1
  end
  if type(arg1) == "function" then
    buttons = arg1
  end
  if type(arg2) == "table" then
    oocrotation = arg2
  end
  if type(arg2) == "function" then
    buttons = arg2
  end

  ProbablyEngine.rotation.rotations[specId] = spellTable

  if oocrotation then
    ProbablyEngine.rotation.oocrotations[specId] = oocrotation
  end

  if buttons and type(buttons) == 'function' then
    ProbablyEngine.rotation.buttons[specId] = buttons
  end

  ProbablyEngine.debug.print('Loaded Rotation for ' .. name, 'rotation')
end


ProbablyEngine.rotation.register_custom = function(specId, _desc, _spellTable, arg1, arg2)

  local _oocrotation, _buttons = false

  if type(arg1) == "table" then
    _oocrotation = arg1
  end
  if type(arg1) == "function" then
    _buttons = arg1
  end
  if type(arg2) == "table" then
    _oocrotation = arg2
  end
  if type(arg2) == "function" then
    _buttons = arg2
  end

  if _oocrotation then
    ProbablyEngine.rotation.ooccustom[specId] = _oocrotation
  end

  if not ProbablyEngine.rotation.custom[specId] then
    ProbablyEngine.rotation.custom[specId] = { }
  end

  table.insert(ProbablyEngine.rotation.custom[specId], {
    desc = _desc,
    spellTable = _spellTable,
    oocrotation = _oocrotation,
    buttons = _buttons,
  })

  ProbablyEngine.debug.print('Loaded Custom Rotation for ' .. ProbablyEngine.rotation.specId[specId], 'rotation')
end

-- Lower memory used, no need in storing rotations for other classes
ProbablyEngine.rotation.auto_unregister = function()
  local classId = select(3, UnitClass("player"))
  for specId,_ in pairs(ProbablyEngine.rotation.rotations) do
    if ProbablyEngine.rotation.classSpecId[specId] ~= classId and specId ~= classId then
      local name = ProbablyEngine.rotation.specId[specId] or GetClassInfoByID(specId)
      ProbablyEngine.debug.print('AutoUnloaded Rotation for ' .. name, 'rotation')
      ProbablyEngine.rotation.classSpecId[specId] = nil
      ProbablyEngine.rotation.specId[specId] = nil
      ProbablyEngine.rotation.rotations[specId] = nil
      ProbablyEngine.rotation.buttons[specId] = nil
    end
  end
  collectgarbage('collect')
end

ProbablyEngine.rotation.add_buttons = function()
  -- Default Buttons
  if ProbablyEngine.rotation.buttons[ProbablyEngine.module.player.specID] then
    ProbablyEngine.rotation.buttons[ProbablyEngine.module.player.specID]()
  end

  -- Custom Buttons
  if ProbablyEngine.rotation.custom[ProbablyEngine.module.player.specID] then
    for _, rotation in pairs(ProbablyEngine.rotation.custom[ProbablyEngine.module.player.specID]) do
      if ProbablyEngine.rotation.currentStringComp == rotation.desc then
        if rotation.buttons then
          rotation.buttons()
        end
      end
    end
  end
end
