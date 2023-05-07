LR.Config.FirstRoll = "Aucun Roll"                                  -- Roll de base (Ne plus toucher après la première configuration)
LR.Config.FirstToken = 1                                            -- Nombre de Token au démarage

LR.Config.SystemeName = "Systeme  de  Reroll"                       -- Nom du système 

LR.Config.AdminCommand = "!adminroll"                               -- Commande du menu d'administration

LR.Config.Model = "models/shiki/poupe_gedo.mdl"         -- Model de l'entités pour ouvrir le menu

LR.Config.AdminGroup = {

    ["superadmin"] = true,                                          -- Groupe accepter pour ouvrir le menu d'administration
    ["admin"] = false,

}

LR.Config.TableRoll = {

    [1] = {
        name = "Katon",                                             -- Nom du ROLL
        img = "sl_materials/roll/katon.png",                        -- Image du ROLL
        swep = "base_katon",                                    -- Arme du ROLL
        color = Color(255, 0, 0),                                   -- Couleur du ROLL
        percent = 90                                               -- Pourcentage d'obtention 
    },

    [2] = {
        name = "Suiton",
        img = "sl_materials/roll/suiton.png",
        swep = "base_suiton",
        color = Color(0, 0, 255),
        percent = 90
    },

[3] = {
        name = "Futon",
        img = "sl_materials/roll/futon.png",
        swep = "base_futon",
        color = Color(0, 0, 255),
        percent = 90
    },

[4] = {
        name = "Doton",
        img = "sl_materials/roll/doton.png",
        swep = "base_doton",
        color = Color(0, 0, 255),
        percent = 90
    },
[5] = {
        name = "Raiton",
        img = "sl_materials/roll/raiton.png",
        swep = "base_raiton",
        color = Color(0, 0, 255),
        percent = 90
    },
[6] = {
        name = "Jinton",
        img = "sl_materials/roll/jinton.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },
[7] = {
        name = "Jiton",
        img = "sl_materials/roll/jiton.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },
[8] = {
        name = "Bakuton",
        img = "sl_materials/roll/bakuton.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },
[9] = {
        name = "Ranton",
        img = "sl_materials/roll/ranton.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },

[10] = {
        name = "Shakuton",
        img = "sl_materials/roll/shakuton.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },

[11] = {
        name = "Yoton",
        img = "sl_materials/roll/bakuton.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },

[13] = {
        name = "Futton",
        img = "sl_materials/roll/futton.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },

[14] = {
        name = "Mokuton",
        img = "sl_materials/roll/futon.png",
        swep = "",
        color = Color(0, 0, 255),
        percent = 10
    },

}

-- Commande pour ajouter des TOKEN via la console : "AddReroll STEAMID64 REROLL" (Example: "AddReroll 76561198343905593 100")

-- (Développeur) Get le ROLL d'un joueur : ply:GetNWInt("PlayerRoll:LR")
-- (Développeur) Get les TOKENS d'un joueur : ply:GetNWInt("PlayerToken:LR")