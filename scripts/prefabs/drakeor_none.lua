local assets =
{
	Asset( "ANIM", "anim/drakeor.zip" ),
	Asset( "ANIM", "anim/ghost_drakeor_build.zip" ),
}

local skins =
{
	normal_skin = "drakeor",
	ghost_skin = "ghost_drakeor_build",
}

return CreatePrefabSkin("drakeor_none",
{
	base_prefab = "drakeor",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"DRAKEOR", "CHARACTER", "BASE"},
	build_name_override = "drakeor",
	rarity = "Character",
})