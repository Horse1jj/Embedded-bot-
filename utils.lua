local json = require("json")
local timer = require("timer")

local utils = {}

-- Load Config
function utils.loadConfig(file)
    local f = io.open(file, "r")
    if not f then error("Failed to load " .. file) end
    local content = f:read("*a")
    f:close()
    return json.decode(content)
end

function utils.createEmbed(title, description, color, footer)
    local embed = discord.Embed()
    embed:setTitle(title)
    embed:setDescription(description)
    embed:setColor(color or 0x3498db)
    if footer then embed:setFooter(footer) end
    return embed
end

function utils.scheduleTimedMessage(client, channelId, message, interval)
    timer.setInterval(interval * 1000, function()
        local channel = client:getChannel(channelId)
        if channel then
            channel:send(message)
        else
            print("Failed to find channel: " .. channelId)
        end
    end)
end

return utils
