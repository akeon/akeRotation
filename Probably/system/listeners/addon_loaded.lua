-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

local pelg = ProbablyEngine.locale.get
local build = ProbablyEngine.build
local stringFormat = string.format

ProbablyEngine.listener.register("ADDON_LOADED", function(...)

  local addon = ...

  if addon ~= ProbablyEngine.addonName then return end

  -- load all our config data
  ProbablyEngine.config.load(ProbablyEngine_ConfigData)

  -- load our previous button states
  ProbablyEngine.buttons.loadStates()

  -- Turbo
  ProbablyEngine.config.read('pe_turbo', false)

  -- Dynamic Cycle
  ProbablyEngine.config.read('pe_dynamic', false)

  ProbablyEngine.version = 'Development Release'
  if build then
    ProbablyEngine.version = string.format('%s v%d (%s)', pelg('build'), build.version, build.commit)
  end
end)
