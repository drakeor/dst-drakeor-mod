-- This information tells other players more about the mod
name = "Drakeor the Dragon"
description = [[
    Adds the Drakeor character to Don't Starve Together

    - Character isn't balanced by default (Slightly OP)
    - Starts with the Drake Axe, an axe and pickaxe
    - Slowly regains sanity around fires
    - Completely fireproof
    - Takes 75% less overheat damage
    - Fur can be shaved off with a razor once overgrown

    View more at https://drakeor.com/
]]
author = "Caprica and Drakeor"
version = "1.1.1" -- This is the version of the template. Change it to your own number.

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Character mods are required by all clients
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
"character",
}

--configuration_options = {}
configuration_options =
{
    {
        name = "drakeor_stat_alloc",
        label = "Stat Allocation (Health / Hunger / Sanity)",
        options =
        {
			{description = "Balanced",              data = 1, hover = "150 health / 150 hunger / 150 sanity"}, 
			{description = "Health + Hunger Focus", data = 2, hover = "170 health / 170 hunger / 110 sanity"}, 
            {description = "Health + Sanity Focus", data = 3, hover = "170 health / 110 hunger / 170 sanity"}, 
            {description = "Hunger + Sanity Focus", data = 4, hover = "110 health / 170 hunger / 170 sanity"}, 
            {description = "Major Health Focus",    data = 5, hover = "210 health / 120 hunger / 120 sanity"}, 
            {description = "Major Hunger Focus",    data = 6, hover = "120 health / 210 hunger / 120 sanity"}, 
            {description = "Major Sanity Focus",    data = 7, hover = "120 health / 120 hunger / 210 sanity"}, 
        },
        default = 1,
    }
}