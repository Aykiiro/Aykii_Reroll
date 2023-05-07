util.AddNetworkString("OpenAdminReRoll:LR")
util.AddNetworkString("ChangeRoll:LR")
util.AddNetworkString("ChangeToken:LR")

hook.Add( "PlayerSay", "AdminReRoll:LR", function( ply, text, len )
    if ( string.lower( text ) == LR.Config.AdminCommand ) then
        if ply:IsPlayer() and LR.Config.AdminGroup[ply:GetUserGroup()] then
            net.Start("OpenAdminReRoll:LR")
            net.Send(ply)
        end
    return""
    end
end)

net.Receive("ChangeRoll:LR", function(len, ply)
    if ply:IsPlayer() and LR.Config.AdminGroup[ply:GetUserGroup()] then
        local Value = net.ReadString()
        local PlayerInfo = net.ReadEntity()

        PlayerInfo:ChangeRoll(Value)

        PlayerInfo:LoadWeapon()
    end
end)

net.Receive("ChangeToken:LR", function(len, ply)
    if ply:IsPlayer() and LR.Config.AdminGroup[ply:GetUserGroup()] then

        local Value = net.ReadInt(32)
        local PlayerInfo = net.ReadEntity()

        PlayerInfo:ChangeToken(Value)
    end
end)

concommand.Add( "AddReroll", function( ply, cmd, args )

    if ply == NULL or LR.Config.AdminGroup[ply:GetUserGroup()] then
  
      arg2 = "N/A"
      arg3 = "N/A"
      arg4 = "Erreur"
      c = Color(0, 255, 50)
    
      if args[1] then 
        arg2 = args[1]
      end
    
      if args[2] then 
        local n = tonumber(args[2])
        if isnumber(n) then 
          arg3 = n
        end
      end
    
    if isnumber(arg3) then 
        for k, v in pairs(player.GetAll()) do
            if v:SteamID64() == arg2 then 
    
                v:ChangeToken(arg3)

                arg4 = "Réussite"
            end
        end

    else
        arg4 = "Mauvaise Valeur"
    end 
    
      if !arg2 then arg2 = "N/A" end 
      if !arg3 then arg3 = "N/A" end 
      if !arg4 then arg4 = "N/A" end 
      if arg4 != "Réussite" then c = Color(255, 0, 0) end
    
      ply:PrintMessage( HUD_PRINTCONSOLE, "ID Cible       : "..arg2)
      ply:PrintMessage( HUD_PRINTCONSOLE, "Valeur         : "..arg3)
      ply:PrintMessage( HUD_PRINTCONSOLE, "Récapitulatif  : "..arg4)
  
    end
end)
