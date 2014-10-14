-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

local BOOKTYPE_SPELL = BOOKTYPE_SPELL
local BOOKTYPE_PET = BOOKTYPE_PET
local GetSpellBookItemName = GetSpellBookItemName
local GetSpellInfo = GetSpellInfo
local GetSpellLink = GetSpellLink
local GetSpellTabInfo = GetSpellTabInfo
local HasPetSpells = HasPetSpells
local stringLower = string.lower
local stringMatch = string.match

local spellCache = {}
local spellIndexCache = {}
local itemCache = {}

function clearOverloadCache()
  spellCache = {}
  spellIndexCache = {}
  itemCache = {}
end

function GetSpellID(spell)
  if type(spell) == 'number' then return spell end

  local spellID = stringMatch(GetSpellLink(spell) or '', 'Hspell:(%d+)|h')
  if spellID then
    return tonumber(spellID)
  end

  return false
end

function GetSpellName(spell)
  local spellID = tonumber(spell)
  if spellID then
    return GetSpellInfo(spellID)
  end

  return spell
end

function GetSpellBookIndex(spell)
  local spellName = GetSpellName(spell)
  if not spellName then return false end
  spellName = stringLower(spellName)

  for t = 1, 2 do
    local _, _, offset, numSpells = GetSpellTabInfo(t)
    local i
    for i = 1, (offset + numSpells) do
      if stringLower(GetSpellBookItemName(i, BOOKTYPE_SPELL)) == spellName then
        return i, BOOKTYPE_SPELL
      end
    end
  end

  local numFlyouts = GetNumFlyouts()
  for f = 1, numFlyouts do
    local flyoutID = GetFlyoutID(f)
    local _, _, numSlots, isKnown = GetFlyoutInfo(flyoutID)
    if isKnown and numSlots > 0 then
      for g = 1, numSlots do
        local spellID, _, isKnownSpell = GetFlyoutSlotInfo(flyoutID, g)
        local name = GetSpellName(spellID)
        if name and isKnownSpell and stringLower(GetSpellName(spellID)) == spellName then
          return spellID, nil
        end
      end
    end
  end

  local numPetSpells = HasPetSpells()
  if numPetSpells then
    for i = 1, numPetSpells do
      if stringLower(GetSpellBookItemName(i, BOOKTYPE_PET)) == spellName then
        return i, BOOKTYPE_PET
      end
    end
  end

  return false
end

function GetItemID(item)
  if type(item) == 'number' then return item end

  local itemID = stringMatch(select(2, GetItemInfo(item)) or '', 'Hitem:(%d+):')
  if itemID then
    return tonumber(itemID)
  end

  return false
end

function UnitID(target)
  local guid = UnitGUID(target)
  if guid then return tonumber(guid:sub(6, 10), 16) end
  return false
end
UnitId = UnitID

function table.length(tbl)
  local count = 0
  for _ in pairs(tbl) do
    count = count + 1
  end
  return count
end

function table.contains(tbl, n)
  for _, v in pairs(tbl) do
    if v == n then
      return true
    end
  end
  return false
end

function table.empty(tbl)
  for i, _ in ipairs(tbl) do tbl[i] = nil end
end