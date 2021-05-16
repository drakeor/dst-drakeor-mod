local assets=
{ 
    Asset("ANIM", "anim/drakeaxe.zip"),
    Asset("ANIM", "anim/swap_drakeaxe.zip"), 

    Asset("ATLAS", "images/inventoryimages/drakeaxe.xml"),
    Asset("IMAGE", "images/inventoryimages/drakeaxe.tex"),
}

local prefabs = 
{

}


local function OnEquip(inst, owner) 
    --owner.AnimState:OverrideSymbol("swap_object", "swap_wands", "purplestaff")
    owner.AnimState:OverrideSymbol("swap_object", "swap_drakeaxe", "symbol0")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function OnAttack(inst, attacker, target)

	inst.components.weapon.attackwear = target ~= nil 
        and target:IsValid() 
		and (target:HasTag("shadow") or target:HasTag("shadowminion") or target:HasTag("shadowchesspiece") or target:HasTag("stalker") or target:HasTag("stalkerminion"))
		and TUNING.DRAKEAXE.SHADOW_WEAR
		or TUNING.DRAKEAXE.ATTACKWEAR
end


-- DebugSpawn("DRAKEAXE")

local function fn(colour)

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("drakeaxe")
    anim:SetBuild("drakeaxe")
    anim:PlayAnimation("idle")

    inst:AddTag("weapon")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- Can be used (ineffectively) as a weapon
    inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.DRAKEAXE.DAMAGE)
	inst.components.weapon:SetOnAttack(OnAttack)

    -- Can be used as an axe or a pickaxe
    inst:AddComponent("tool") 
    inst.components.tool:SetAction(ACTIONS.CHOP, TUNING.DRAKEAXE.AXE_EFFECTIVENESS)
    inst.components.tool:SetAction(ACTIONS.MINE, TUNING.DRAKEAXE.PICKAXE_EFFECTIVENESS)

    -- Finite uses
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.DRAKEAXE.TOOL_DURABILITY)
    inst.components.finiteuses:SetUses(TUNING.DRAKEAXE.TOOL_DURABILITY)
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, TUNING.DRAKEAXE.AXE_CONSUMPTION)
    inst.components.finiteuses:SetConsumption(ACTIONS.MINE, TUNING.DRAKEAXE.PICKAXE_CONSUMPTION)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "drakeaxe"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/drakeaxe.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )

    MakeHauntableLaunch(inst)

    return inst
end

return  Prefab("common/inventory/drakeaxe", fn, assets, prefabs)