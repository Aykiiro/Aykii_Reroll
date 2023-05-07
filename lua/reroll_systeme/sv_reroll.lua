util.AddNetworkString("FirstRoll:LR")
util.AddNetworkString("ReRoll:LR")

net.Receive("FirstRoll:LR", function(len, ply)

    ply:FistRoll()
    ply:LoadWeapon()

end)

net.Receive("ReRoll:LR", function(len, ply)
    if ply:GetNWInt("PlayerRoll:LR") != LR.Config.FirstRoll and ply:GetNWInt("PlayerToken:LR") >= 1 then 

    ply:ReRoll()
    ply:LoadWeapon()

    end
end)