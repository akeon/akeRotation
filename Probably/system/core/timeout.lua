-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

local debug = ProbablyEngine.debug
local time = time

ProbablyEngine.timeout = {}
local timeout = ProbablyEngine.timeout

local timeouts = {}

local function onUpdate(self, elapsed)
  for name, struct in pairs(timeouts) do
    if time() >= (struct.start + struct.timeout) then
      struct.callback()
      timeouts[name] = nil
    end
  end
end

local frame = CreateFrame('Frame')
frame:SetScript('OnUpdate', onUpdate);

function timeout.set(_name, _callback, _timeout)
  debug.print('Timeout Started: ' .. tostring(_name))
  if not tonumber(_timeout) then
    ProbablyEngine.print('Timer Error: ' .. tostring(_name) .. ' has no time period.')
    return
  end

  timeouts[_name] = {
    callback = _callback,
    timeout = _timeout,
    start = time()
  }
end

function timeout.check(_name)
  if timeouts[_name] ~= nil then
    return (time() - timeouts[_name].start)
  end
  return false
end
