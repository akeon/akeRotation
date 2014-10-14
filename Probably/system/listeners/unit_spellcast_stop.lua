-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

local function castStop(unitID)
  if unitID == 'player' then
    ProbablyEngine.module.player.casting = false
  elseif unitID == 'pet' then
    ProbablyEngine.module.pet.casting = false
  end
end

ProbablyEngine.listener.register('UNIT_SPELLCAST_STOP', castStop)
