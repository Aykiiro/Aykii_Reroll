function ReRollMenu()


    LR.MenuRoll = vgui.Create("DFrame")
    LR.MenuRoll:SetSize(W(500), H(750))
    LR.MenuRoll:Center()
    LR.MenuRoll:MakePopup()
    LR.MenuRoll:SetDraggable(false)
    LR.MenuRoll:SetTitle("")
    LR.MenuRoll:ShowCloseButton(true)
    function LR.MenuRoll:Paint(w, h)
        draw.RoundedBox(8,0,0,w,h,Color(255,255,255,0))
    end

    local MenuRollBackGround = vgui.Create("DImage", LR.MenuRoll)
    MenuRollBackGround:SetSize(W(500), H(750))
    MenuRollBackGround:SetPos(0, 0)
    MenuRollBackGround:SetMaterial(LR.Materials.Background)

    --

    local PanelMenuRoll = vgui.Create("DPanel", LR.MenuRoll)
    PanelMenuRoll:SetSize(W(500), H(750))
    PanelMenuRoll:SetPos(0, 0)
    PanelMenuRoll:SetText("")
    function PanelMenuRoll:Paint(w, h)
        for k, v in pairs(LR.Config.TableRoll) do
            if LR.Config.TableRoll[k].name == LocalPlayer():GetNWInt("PlayerRoll:LR") then 
                PlayerRollColor = LR.Config.TableRoll[k].color
            end
        end

        draw.RoundedBox(8,0,0,w,h,Color(255,255,255,0))

        draw.SimpleText(LR.Config.SystemeName, "font_lr3", W(250), H(45), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Vous avez :", "font_lr3", W(250), H(150), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(LocalPlayer():GetNWInt("PlayerRoll:LR"), "font_lr1", W(250), H(200), PlayerRollColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Vous avez  :  "..LocalPlayer():GetNWInt("PlayerToken:LR").."  Reroll", "font_lr1", W(250), H(650), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local Close = vgui.Create("DButton", PanelMenuRoll)
    Close:SetSize(50, 50)
    Close:SetPos(445, 5)
    Close:SetText("")
    function Close:Paint(w,h)
        draw.RoundedBox(8,0,0,w,h,Color(255,255,255,0))
    end
    function Close:DoClick()
        LR.MenuRoll:Remove()
    end

    local RollImage = vgui.Create("DImageButton", PanelMenuRoll)
    RollImage:SetSize(W(150), H(150))
    RollImage:SetPos(W(175), H(275))
    RollImage:SetText("")
    function RollImage:Paint(w, h)
        for k, v in pairs(LR.Config.TableRoll) do
            if LR.Config.TableRoll[k].name == LocalPlayer():GetNWInt("PlayerRoll:LR") then 
                PlayerRollImage = LR.Config.TableRoll[k].img
            elseif LR.Config.TableRoll[k].name == LR.Config.FirstRoll then
                PlayerRollImage = "sl_materials/roll/naruto.png"
            end
        end

        RollImage:SetMaterial(PlayerRollImage)
    end
    function RollImage:DoClick()
        notification.AddLegacy( "Vous êtes : "..LocalPlayer():GetNWInt("PlayerRoll:LR"), NOTIFY_GENERIC, 2 )
    end

    local ButtonRoll = vgui.Create("DButton", PanelMenuRoll)
    ButtonRoll:SetSize(W(250), H(75))
    ButtonRoll:SetPos(W(125), H(500))
    ButtonRoll:SetText("")
    function ButtonRoll:Paint(w, h)
        draw.RoundedBox(32,0,0,w,h,Color(10,10,10,225))

        if LocalPlayer():GetNWInt("PlayerRoll:LR") == LR.Config.FirstRoll then

            if ButtonRoll:IsHovered() then 
                draw.SimpleText("Roll", "font_lr2", W(125), H(37.5), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Roll", "font_lr2", W(125), H(37.5), Color( 200, 200, 200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

        else
            if ButtonRoll:IsHovered() then 
                draw.SimpleText("ReRoll", "font_lr2", W(125), H(37.5), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("ReRoll", "font_lr2", W(125), H(37.5), Color( 200, 200, 200, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end
    function ButtonRoll:DoClick()
        if LocalPlayer():GetNWInt("PlayerRoll:LR") == LR.Config.FirstRoll then

            net.Start("FirstRoll:LR")
            net.SendToServer()

        elseif LocalPlayer():GetNWInt("PlayerRoll:LR") != LR.Config.FirstRoll and LocalPlayer():GetNWInt("PlayerToken:LR") >= 1 then 

            net.Start("ReRoll:LR")
            net.SendToServer()

            notification.AddLegacy( "Vous venez d'utiliser 1 Reroll", NOTIFY_GENERIC, 5 )

        else 

            notification.AddLegacy( "Vous n'avez pas assez de ReRoll", NOTIFY_ERROR, 5 )

        end
    end
end
