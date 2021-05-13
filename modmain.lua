PrefabFiles = {
	"drakeor",
	"drakeor_none",
    "drakeaxe"
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/drakeor.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/drakeor.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/drakeor.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/drakeor.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/drakeor_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/drakeor_silho.xml" ),

    Asset( "IMAGE", "bigportraits/drakeor.tex" ),
    Asset( "ATLAS", "bigportraits/drakeor.xml" ),
	
	Asset( "IMAGE", "images/map_icons/drakeor.tex" ),
	Asset( "ATLAS", "images/map_icons/drakeor.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_drakeor.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_drakeor.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_drakeor.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_drakeor.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_drakeor.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_drakeor.xml" ),
	
	Asset( "IMAGE", "images/names_drakeor.tex" ),
    Asset( "ATLAS", "images/names_drakeor.xml" ),
	
	Asset( "IMAGE", "images/names_gold_drakeor.tex" ),
    Asset( "ATLAS", "images/names_gold_drakeor.xml" ),
}

-- Caprica has the stormdragon property
AddPrefabPostInit("caprica", function(inst)
    inst:AddTag("dragon")
end)

-- TUNING

TUNING = GLOBAL.TUNING

TUNING.DRAKEAXE =
{
    TOOL_DURABILITY= 250,
    AXE_EFFECTIVENESS = 1.5,
    PICKAXE_EFFECTIVENESS = 1.5,
    AXE_CONSUMPTION = 1,
    PICKAXE_CONSUMPTION = 3,
    DAMAGE = 26,
    ATTACKWEAR = 1,
    SHADOW_WEAR = 1,
}


-- Weapon Lines
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local NAMES = GLOBAL.STRINGS.NAMES
local RECIPE_DESC = GLOBAL.STRINGS.RECIPE_DESC
local DESC = GLOBAL.STRINGS.CHARACTERS

NAMES.DRAKEAXE = "Drake Axe"
RECIPE_DESC.DRAKEAXE = "Hard enough to shatter stones"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DRAKEAXE = "An axe hard enough to shatter stones"

AddMinimapAtlas("images/map_icons/drakeor.xml")


-- The character select screen lines
STRINGS.CHARACTER_TITLES.drakeor = "The 'Innocent' One"
STRINGS.CHARACTER_NAMES.drakeor = "Drakeor"
STRINGS.CHARACTER_DESCRIPTIONS.drakeor = "*Carries a handy pick/axe\n*Likes fire\n*Sheds every few days"
STRINGS.CHARACTER_QUOTES.drakeor = "\"Yay! Fire!\""
STRINGS.CHARACTER_SURVIVABILITY.drakeor = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.DRAKEOR = require "speech_drakeor"

-- The character's name as appears in-game 
STRINGS.NAMES.DRAKEOR = "Drakeor"
STRINGS.SKIN_NAMES.drakeor_none = "Drakeor"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("drakeor", "MALE", skin_modes)
