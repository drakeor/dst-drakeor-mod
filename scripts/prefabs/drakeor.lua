local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset("ANIM", "anim/drakeor_beard.zip"),
}

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.DRAKEOR = {
	"flint",
	"flint",
	"twigs",
	"twigs",
	"drakeaxe"
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.DRAKEOR
end
local prefabs = FlattenTree(start_inv, true)

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "drakeor_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "drakeor_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

-- Lifted from Willow too
local FIRE_TAGS = { "fire" }
local function sanityfn(inst)--, dt)
    local delta = inst.components.temperature:IsFreezing() and -TUNING.SANITYAURA_LARGE or 0
    local x, y, z = inst.Transform:GetWorldPosition() 
    local max_rad = 12
    local ents = TheSim:FindEntities(x, y, z, max_rad, FIRE_TAGS)
    for i, v in ipairs(ents) do
        if v.components.burnable ~= nil and v.components.burnable:IsBurning() then
            local rad = v.components.burnable:GetLargestLightRadius() or 1
            local sz = TUNING.SANITYAURA_TINY * math.min(max_rad, rad) / max_rad
            local distsq = inst:GetDistanceSqToInst(v) - 9
            -- shift the value so that a distance of 3 is the minimum
            delta = delta + sz / math.max(1, distsq)
        end
    end
    return delta
end

-- TheWorld:PushEvent("ms_nextcycle")

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 

	-- Just like willow, am more heat resistent 
	inst:AddTag("heatresistant")  

	 --bearded (from beard component) added to pristine state for optimization
	 inst:AddTag("bearded")

	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "drakeor.tex" )
end

-------- START BEARD STUFF

local function OnResetBeard(inst)
    inst.AnimState:ClearOverrideSymbol("beard")
end

--tune the beard economy...
local BEARD_DAYS = 3
local BEARD_BITS = 2

local function OnGrowFur(inst, skinname)
	inst.AnimState:OverrideSymbol("beard", "drakeor_beard", "beard_medium")
    inst.components.beard.bits = BEARD_BITS
end


------- END BEARD STUFF

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	-- choose which sounds this character will play
	inst.soundsname = "wilson"
	
	----- START BEARD STUFF
	
    inst:AddComponent("beard")
    inst.components.beard.onreset = OnResetBeard
    inst.components.beard.prize = "dragonfur"
    inst.components.beard.is_skinnable = true
    inst.components.beard:AddCallback(BEARD_DAYS, OnGrowFur)

	-- Very minimal insulation, so it's not OP
	inst.components.beard.insulation_factor = 0.1

	------ END BEARD STUFF

	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Set sanity
	inst.components.sanity:SetMax(TUNING.DRAKEOR_SANITY)
	inst.components.sanity.custom_rate_fn = sanityfn

	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.DRAKEOR_HEALTH)
	inst.components.hunger:SetMax(TUNING.DRAKEOR_HUNGER)
	
	-- Make fire proof
	inst.components.health.fire_damage_scale = TUNING.DRAKEOR_FIRE_DAMAGE

	-- Dragons last longer before overheating
	inst.components.temperature:SetOverheatHurtRate(TUNING.WILSON_HEALTH / TUNING.DRAKEOR_OVERHEAT_KILL_TIME)

	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("drakeor", prefabs, assets, common_postinit, master_postinit, prefabs)
