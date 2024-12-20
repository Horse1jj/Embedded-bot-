local discord = require("discord")
local utils = require("utils")
local commands = require("commands")
local json = require("json")

local config = utils.loadConfig("config.json")

local client = discord.Client(config.token)

client:on("ready", function()
    print("Bot is online as " .. client.user.username)
    commands.registerSlashCommands(client) -- Register slash commands
end)

client:on("interactionCreate", function(interaction)
    if interaction.type == "APPLICATION_COMMAND" then
        local commandName = interaction.data.name
        if commands[commandName] then
            commands[commandName](interaction, config)
        else
            interaction:reply("Unknown command!")
        end
    end
end)

client:run()
