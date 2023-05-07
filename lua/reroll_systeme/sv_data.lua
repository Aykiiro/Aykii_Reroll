hook.Add( "PlayerInitialSpawn", "LoadRoll:LR", function( ply )
    if ply:IsValid() then 

        local SteamID64 = tostring(ply:SteamID64())


        if not file.Exists( "lr_reroll", "DATA" ) then
            file.CreateDir( "lr_reroll" )
        end

        if not file.Exists( "lr_reroll/roll", "DATA" ) then
            file.CreateDir( "lr_reroll/roll" )
        end

        if not file.Exists( "lr_reroll/roll/"..SteamID64, "DATA" ) then
            file.CreateDir( "lr_reroll/roll/"..SteamID64 )

            local loadData = file.Read("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json")
        
            if loadData then 
                RollTable = util.JSONToTable( loadData )
            end

            local RollTable = {
                Roll = LR.Config.FirstRoll,
                Token = LR.Config.FirstToken
            }

            local saveData = util.TableToJSON(RollTable)
            file.Write("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json", saveData)
        end

        local loadData = file.Read("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json")

        if loadData then 
            RollTable = util.JSONToTable( loadData )
        end

        ply:SetNWInt("PlayerRoll:LR", RollTable.Roll)
        ply:SetNWInt("PlayerToken:LR", RollTable.Token)

    end
end)

hook.Add("PlayerSpawn", "LoadWeaponSpawn:LR", function(ply)
    timer.Simple(2, function()
        ply:LoadWeapon()
    end)
end)

hook.Add("OnPlayerChangedTeam", "LoadWeaponJob:LR", function(ply)
    timer.Simple(2, function()
        ply:LoadWeapon()
    end)
end)