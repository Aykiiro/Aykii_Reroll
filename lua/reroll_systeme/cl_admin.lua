net.Receive("OpenAdminReRoll:LR", function()

    LR.AdminPanel = vgui.Create("DFrame")
    LR.AdminPanel:SetSize(W(500), H(700))
    LR.AdminPanel:Center()
    LR.AdminPanel:SetTitle("")
    LR.AdminPanel:MakePopup()
    LR.AdminPanel:SetDraggable(false)
    LR.AdminPanel:ShowCloseButton(true)
    function LR.AdminPanel:Paint(w,h)
        draw.RoundedBox(8,0,0,w,h,Color(40,40,40,255))
        draw.SimpleText("Staff  -  Reroll", "font_lr3", W(250), H(30), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end


    local PlayerList = vgui.Create("DComboBox", LR.AdminPanel)
    PlayerList:SetSize(W(300), H(50))
    PlayerList:SetPos(W(100), H(150))
    PlayerList:SetSortItems(true)
    PlayerList:SetValue("Choisir :")
    PlayerList:SetFont("font_lr1")
    for k, v in pairs(player.GetAll()) do
        PlayerList:AddChoice(v:GetName())
    end
    function PlayerList:Paint(w, h)
        draw.RoundedBox(8,0,0,w,h,Color(0,0,0,0) )

        if PlayerList:IsHovered() then
            self:SetTextColor(Color(255, 255, 255, 255) )
        else
            self:SetTextColor(Color(200, 200, 200, 255) )
        end
    end 
    function PlayerList:OnSelect(index, value, data)

        if IsValid(LR.InfoPanel) then LR.InfoPanel:Remove() end 

        for k, v in pairs(player.GetAll()) do
            if v:GetName() == value then 

                PlayerInfo = v

            end
        end

        LR.InfoPanel = vgui.Create("DPanel", LR.AdminPanel)
        LR.InfoPanel:SetSize(W(500), H(500))
        LR.InfoPanel:SetPos(0, H(200))
        LR.InfoPanel:SetText("")
        function LR.InfoPanel:Paint(w,h)
            draw.RoundedBox(8,0,0,w,h,Color(0,0,0,0) )
            draw.SimpleText("Roll  :  "..PlayerInfo:GetNWInt("PlayerRoll:LR") , "font_lr2", W(250), H(100), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Token  :  "..PlayerInfo:GetNWInt("PlayerToken:LR") , "font_lr2", W(250), H(300), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        local ButtonRoll = vgui.Create("DButton", LR.InfoPanel)
        ButtonRoll:SetSize(W(250), H(75))
        ButtonRoll:SetPos(W(125), H(150))
        ButtonRoll:SetText("")
        function ButtonRoll:Paint(w,h)
            draw.RoundedBox(32,0,0,w,h,Color(0,0,0,100))

            if ButtonRoll:IsHovered() then 
                draw.SimpleText("Modifier", "font_lr1", W(125), H(37.5), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Modifier", "font_lr1", W(125), H(37.5), Color( 200, 200, 200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
        function ButtonRoll:DoClick()

            if IsValid(LR.ChoiceRollPanel) then LR.ChoiceRollPanel:Remove() end
            if IsValid(LR.ChoiceTokenPanel) then LR.ChoiceTokenPanel:Remove() end
 
            LR.ChoiceRollPanel = vgui.Create("DPanel", LR.InfoPanel)
            LR.ChoiceRollPanel:SetSize(W(400), H(300))
            LR.ChoiceRollPanel:Center()
            function LR.ChoiceRollPanel:Paint(w,h)
                draw.RoundedBox(8, 0, 0, w, h, Color(35,35,35,255))
                draw.SimpleText("Quelle  roll", "font_lr1", W(200), H(30), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText("voulez  vous  modifier ?", "font_lr1", W(200), H(60), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            local Close = vgui.Create("DImageButton", LR.ChoiceRollPanel)
            Close:SetSize(W(32), H(32))
            Close:SetPos(W(363), H(5))
            Close:SetMaterial(LR.Materials.close)
            function Close:DoClick()
                LR.ChoiceRollPanel:Remove()
            end
    
            local RollList = vgui.Create("DComboBox", LR.ChoiceRollPanel)
            RollList:SetSize(W(200), H(50))
            RollList:SetPos(W(100), H(125))
            RollList:SetSortItems(true)
            RollList:SetValue("Choisir :")
            RollList:SetFont("font_lr1")
            for k, v in pairs(LR.Config.TableRoll) do
                RollList:AddChoice(LR.Config.TableRoll[k].name)
            end
            function RollList:Paint(w, h)
                draw.RoundedBox(8,0,0,w,h,Color(0,0,0,0) )
        
                if RollList:IsHovered() then
                    self:SetTextColor(Color(255, 255, 255, 255) )
                else
                    self:SetTextColor(Color(200, 200, 200, 255) )
                end
            end 
    
            local ValidButtonRoll = vgui.Create("DButton", LR.ChoiceRollPanel)
            ValidButtonRoll:SetSize(W(200), H(50))
            ValidButtonRoll:SetPos(W(100), H(200))
            ValidButtonRoll:SetText("")
            function ValidButtonRoll:Paint(w,h)
                if ValidButtonRoll:IsHovered() then
                    draw.RoundedBox(8, 0, 0, w, h, Color(15,15,15,255))
                    draw.SimpleText("Ajouter !", "font_lr1", W(100), H(25), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                else
                    draw.RoundedBox(8, 0, 0, w, h, Color(55,55,55,255))
                    draw.SimpleText("Ajouter !", "font_lr1", W(100), H(25), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
            function ValidButtonRoll:DoClick()
                if RollList:GetValue() == "Choisir :" then return notification.AddLegacy( "Choisisez une valeur", NOTIFY_ERROR, 2 ) end 
    
                net.Start("ChangeRoll:LR")
                net.WriteString(RollList:GetValue())
                net.WriteEntity(PlayerInfo)
                net.SendToServer()

                notification.AddLegacy( "Vous venez de change la nature de : "..PlayerInfo:Name().." par "..RollList:GetValue(), NOTIFY_GENERIC, 5 )

                LR.ChoiceRollPanel:Remove()

            end
        end

        local ButtonToken = vgui.Create("DButton", LR.InfoPanel)
        ButtonToken:SetSize(W(250), H(75))
        ButtonToken:SetPos(W(125), H(350))
        ButtonToken:SetText("")
        function ButtonToken:Paint(w,h)
            draw.RoundedBox(32,0,0,w,h,Color(0,0,0,100))

            if ButtonToken:IsHovered() then 
                draw.SimpleText("Modifier", "font_lr1", W(125), H(37.5), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Modifier", "font_lr1", W(125), H(37.5), Color( 200, 200, 200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
        function ButtonToken:DoClick()

            if IsValid(LR.ChoiceRollPanel) then LR.ChoiceRollPanel:Remove() end
            if IsValid(LR.ChoiceTokenPanel) then LR.ChoiceTokenPanel:Remove() end

            LR.ChoiceTokenPanel = vgui.Create("DPanel", LR.InfoPanel)
            LR.ChoiceTokenPanel:SetSize(W(400), H(300))
            LR.ChoiceTokenPanel:Center()
            function LR.ChoiceTokenPanel:Paint(w,h)
                draw.RoundedBox(8, 0, 0, w, h, Color(35,35,35,255))
                draw.SimpleText("Combien  voulez", "font_lr1", W(200), H(30), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText("vous  rajouter  de  token ?", "font_lr1", W(200), H(60), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            local Close = vgui.Create("DImageButton", LR.ChoiceTokenPanel)
            Close:SetSize(W(32), H(32))
            Close:SetPos(W(363), H(5))
            Close:SetMaterial(LR.Materials.close)
            function Close:DoClick()
                LR.ChoiceTokenPanel:Remove()
            end
    
            local DTextEntry = vgui.Create("DTextEntry", LR.ChoiceTokenPanel)
            DTextEntry:SetSize(W(225), H(35))
            DTextEntry:SetPos(W(87.5), H(125))
            DTextEntry:SetMultiline(false)
            DTextEntry:SetEditable(true)
            DTextEntry:SetPaintBackground(true)
            DTextEntry:SetFont("font_lr1")
            DTextEntry:SetDrawLanguageID(false)
            DTextEntry:SetNumeric(true)
            DTextEntry:SetValue(1)
            DTextEntry:SetTextColor(Color(255,255,255,255))
            function DTextEntry:Paint(w, h)
                surface.SetDrawColor(0, 0, 0, 100)
                surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
                self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
            end
    
            local ValidButtonToken = vgui.Create("DButton", LR.ChoiceTokenPanel)
            ValidButtonToken:SetSize(W(200), H(50))
            ValidButtonToken:SetPos(W(100), H(200))
            ValidButtonToken:SetText("")
            function ValidButtonToken:Paint(w,h)
                if ValidButtonToken:IsHovered() then
                    draw.RoundedBox(8, 0, 0, w, h, Color(15,15,15,255))
                    draw.SimpleText("Ajouter !", "font_lr1", W(100), H(25), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                else
                    draw.RoundedBox(8, 0, 0, w, h, Color(55,55,55,255))
                    draw.SimpleText("Ajouter !", "font_lr1", W(100), H(25), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
            function ValidButtonToken:DoClick()
                
                net.Start("ChangeToken:LR")
                net.WriteInt(DTextEntry:GetValue(), 32)
                net.WriteEntity(PlayerInfo)
                net.SendToServer()

                notification.AddLegacy( "Vous venez d'ajouter  : "..DTextEntry:GetValue().." token à "..PlayerInfo:Name(), NOTIFY_GENERIC, 5 )

                LR.ChoiceTokenPanel:Remove()

            end
        end
    end
end)