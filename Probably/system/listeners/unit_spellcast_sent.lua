-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

local function castSent(unitID, spell)
  if unitID == 'player' then
    ProbablyEngine.parser.lastCast = spell
    if ProbablyEngine.module.queue.spellQueue == spell then
      ProbablyEngine.module.queue.spellQueue = nil
    end
  end
end

ProbablyEngine.listener.register('UNIT_SPELLCAST_SENT', castSent)
