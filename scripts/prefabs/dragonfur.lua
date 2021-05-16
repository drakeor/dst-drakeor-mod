local assets=
{ 
    Asset("ANIM", "anim/dragonfur.zip"),

    Asset("ATLAS", "images/inventoryimages/dragonfur.xml"),
    Asset("IMAGE", "images/inventoryimages/dragonfur.tex"),
}

local prefabs = 
{

}

-- DebugSpawn("dragonfur")

local function fn(colour)

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("dragonfur")
    anim:SetBuild("dragonfur")
    anim:PlayAnimation("idle")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "dragonfur"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dragonfur.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
    MakeHauntableLaunch(inst)

    return inst
end

return  Prefab("common/inventory/dragonfur", fn, assets, prefabs)