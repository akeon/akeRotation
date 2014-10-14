-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

if ProbablyEngine.hardcore_debug == true then
  SetCVar('scriptProfile', 0) -- enable profiling
  ProbablyEngine.timer.register("profiling", function()
    UpdateAddOnCPUUsage()
    UpdateAddOnMemoryUsage()
    ProbablyEngine.cpu = GetAddOnCPUUsage(ProbablyEngine.addonName)
    ProbablyEngine.mem = GetAddOnMemoryUsage(ProbablyEngine.addonName)
    print(ProbablyEngine.cpu)
    print(ProbablyEngine.mem)
  end, 1000)
end
