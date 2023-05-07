AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel(LR.Config.Model)
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self.isRunning = false
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then 
        phys:Wake()
    end
end

util.AddNetworkString("OpenMenuReRoll:LR")

function ENT:Use( activator )
    if activator:IsPlayer() and activator:Alive() then

        net.Start("OpenMenuReRoll:LR")
        net.Send(activator)

    end
end


