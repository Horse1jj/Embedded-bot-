local utils = require("utils")

local commands = {}

-- Register Slash Commands
function commands.registerSlashCommands(client)
    client:createCommand({
        name = "embed",
        description = "Create an embed message",
        options = {
            { name = "title", type = 3, description = "Title of the embed", required = true },
            { name = "description", type = 3, description = "Description of the embed", required = true },
            { name = "color", type = 3, description = "Hex color for the embed", required = false },
            { name = "footer", type = 3, description = "Footer text", required = false }
        }
    })

    client:createCommand({
        name = "timedmessage",
        description = "Schedule a timed message",
        options = {
            { name = "channel", type = 7, description = "Channel to send the message", required = true },
            { name = "message", type = 3, description = "Message content or embed", required = true },
            { name = "interval", type = 4, description = "Interval in seconds", required = true }
        }
    })

    client:createCommand({
        name = "help",
        description = "Show help information"
    })

    client:createCommand({
        name = "hexcode",
        description = "Help with hex codes"
    })

    client:createCommand({
        name = "faq",
        description = "Get FAQ embedded message"
    })
end

-- Command Logic
commands["embed"] = function(interaction, config)
    local title = interaction.data.options[1].value
    local description = interaction.data.options[2].value
    local color = interaction.data.options[3] and interaction.data.options[3].value or config.embed_color
    local footer = interaction.data.options[4] and interaction.data.options[4].value or "Embed Footer"

    local embed = utils.createEmbed(title, description, color, footer)
    interaction:reply({ embeds = { embed } })
end

commands["timedmessage"] = function(interaction, config)
    local channelId = interaction.data.options[1].value
    local message = interaction.data.options[2].value
    local interval = interaction.data.options[3].value

    utils.scheduleTimedMessage(interaction.client, channelId, message, interval)
    interaction:reply("Timed message scheduled!")
end

commands["help"] = function(interaction)
    local embed = utils.createEmbed("Help Menu", "Here are the available commands:\n\n- `/embed`\n- `/timedmessage`\n- `/help`\n- `/hexcode`\n- `/faq`")
    interaction:reply({ embeds = { embed } })
end

commands["hexcode"] = function(interaction)
    local embed = utils.createEmbed("Hex Code Help", "Use hex codes to specify colors. Example: `#3498db` for blue.\n\n[Color Picker](https://htmlcolorcodes.com/)")
    interaction:reply({ embeds = { embed } })
end

commands["faq"] = function(interaction)
    local embed = utils.createEmbed("FAQ", "Frequently Asked Questions:\n\n1. How do I use the bot?\n2. How do I schedule messages?")
    interaction:reply({ embeds = { embed } })
end

return commands
