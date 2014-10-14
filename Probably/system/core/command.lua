-- ProbablyEngine Rotations - https://probablyengine.com/
-- Released under modified BSD, see attached LICENSE.

ProbablyEngine.command = {
  commands = 0,
  handlers = { }
}

ProbablyEngine.command.print = function(message)
  print("|cFF"..ProbablyEngine.addonColor.."["..ProbablyEngine.addonName.."]|r " .. message .. "")
end

ProbablyEngine.command.register = function (command, handler)
  local name = 'PE_' .. command
  _G["SLASH_" .. name .. "1"] = '/' .. command
  SlashCmdList[name] = function(message, editbox) handler(message, editbox) end
end

ProbablyEngine.command.register_handler = function(command, handler)
  local command_type = type(command)
  if command_type == "string" then
    ProbablyEngine.command.handlers[command] = handler
  elseif command_type == "table" then
    for _,com in pairs(command) do
      ProbablyEngine.command.handlers[com] = handler
    end
  else
    ProbablyEngine.command.print(pelg('unknown_type') .. ': ' .. command_type)
  end
end

ProbablyEngine.command.register('pe', function(msg, box)
  local command, text = msg:match("^(%S*)%s*(.-)$")
  if ProbablyEngine.command.handlers[command] then
    ProbablyEngine.command.handlers[command](text)
  else
    ProbablyEngine.command.handlers['help']('help')
  end
end)
