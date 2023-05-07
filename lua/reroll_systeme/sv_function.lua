local ply = FindMetaTable("Player")

function GetRandomRoll()
  
    local iMax = 0

    for roll, _ in pairs(LR.Config.TableRoll) do
      iMax = iMax + LR.Config.TableRoll[roll].percent
    end
  
    local iMultiplier = 100 / iMax
    local tParts = {}
    for roll, _ in pairs(LR.Config.TableRoll) do
    
      local iPerc = LR.Config.TableRoll[roll].percent * iMultiplier
      for i = 1, math.Round(iPerc) do
        table.insert(tParts, LR.Config.TableRoll[roll].name)
      end
  
    end
  
    return tParts[ math.random(1, 100) ]
end

function ply:FistRoll()

    local SteamID64 = self:SteamID64()

    local Roll = GetRandomRoll()

    local loadData = file.Read("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json")
        
    if loadData then 
        RollTable = util.JSONToTable( loadData )
    end

    local RollTable = {
      Roll = Roll,
      Token = RollTable.Token,
    }

    local saveData = util.TableToJSON(RollTable)
    file.Write("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json", saveData)

    self:SetNWInt("PlayerRoll:LR", Roll)
end

function ply:ReRoll()

  local SteamID64 = self:SteamID64()

  local ReRoll = GetRandomRoll()

  local loadData = file.Read("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json")
      
  if loadData then 
      RollTable = util.JSONToTable( loadData )
  end

  local TokenRemaning = RollTable.Token - 1

  local RollTable = { 
    Roll = ReRoll,
    Token = TokenRemaning,
  }

  local saveData = util.TableToJSON(RollTable)
  file.Write("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json", saveData)

  self:SetNWInt("PlayerRoll:LR", ReRoll)
  self:SetNWInt("PlayerToken:LR", TokenRemaning)
end

function ply:LoadWeapon()

  local SteamID64 = self:SteamID64()

  local loadData = file.Read("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json")
      
  if loadData then 
      RollTable = util.JSONToTable( loadData )
  end

  for k, v in pairs(LR.Config.TableRoll) do
    
    if self:GetNWInt("PlayerRoll:LR") != LR.Config.TableRoll[k].name then
      self:StripWeapon(LR.Config.TableRoll[k].swep)
    end

    if self:GetNWInt("PlayerRoll:LR") == LR.Config.TableRoll[k].name then

      self:Give(LR.Config.TableRoll[k].swep)
    end

    if self:GetNWInt("PlayerRoll:LR") == LR.Config.FirstRoll then return end 

  end
end

function ply:ChangeToken( n )

    local SteamID64 = self:SteamID64()

    local loadData = file.Read("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json")
        
    if loadData then 
        RollTable = util.JSONToTable( loadData )
    end

    local TokenRemaning = (RollTable.Token and RollTable.Token or 0) + n

    local RollTable = { 
      Roll = RollTable.Roll,
      Token = TokenRemaning,
    }

    local saveData = util.TableToJSON(RollTable)
    file.Write("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json", saveData)

    self:SetNWInt("PlayerToken:LR", TokenRemaning)

end

function ply:ChangeRoll( n )

  local SteamID64 = self:SteamID64()

  local Roll = n

  local loadData = file.Read("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json")
      
  if loadData then 
      RollTable = util.JSONToTable( loadData )
  end

  local RollTable = { 
    Roll = Roll,
    Token = RollTable.Token,
  }

  local saveData = util.TableToJSON(RollTable)
  file.Write("lr_reroll/roll/"..SteamID64.."/"..SteamID64..".json", saveData)

  self:SetNWInt("PlayerRoll:LR", Roll)

end