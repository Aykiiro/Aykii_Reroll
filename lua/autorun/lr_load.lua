LR = LR or {}
LR.Config = LR.Config or {}

-- Loader -- 

include("config_lr_reroll.lua")
AddCSLuaFile("config_lr_reroll.lua")

local rootDir = "reroll_systeme"

local function AddFile(File, dir)
    local fileSide = string.lower(string.Left(File , 3))

    if SERVER and fileSide == "sv_" then
        include(dir..File)
    elseif fileSide == "sh_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
        end
        include(dir..File)
    elseif fileSide == "cl_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
        elseif CLIENT then
            include(dir..File)
        end
    end
end

local function IncludeDir(dir)
    dir = dir .. "/"
    local File, Directory = file.Find(dir.."*", "LUA")

    for k, v in ipairs(File) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, dir)
        end
    end
    
    for k, v in ipairs(Directory) do
        IncludeDir(dir..v)
    end

end
IncludeDir(rootDir)

-- Responsive --

function W(pixels, base)
    base = base or 1920
    return ScrW()/(base/pixels)
end


function H(pixels, base)
    base = base or 1080
    return ScrH()/(base/pixels)
end

-- fonts --

if CLIENT then 

    surface.CreateFont("font_lr", {
        font = "Ninja Naruto",
        size = W(20),
        weight = 200,
        antialias = true
    })

    surface.CreateFont("font_lr1", {
        font = "Ninja Naruto",
        size = W(25),
        weight = 200,
        antialias = true
    })

    surface.CreateFont( "font_lr2", {
        font = "Ninja Naruto",
        size = W(30),
        weight = 200,
    } )

    surface.CreateFont( "font_lr3", {
        font = "Ninja Naruto",
        size = W(35),
        weight = 200,
    } )
    
    surface.CreateFont( "font_lr4", {
        font = "Ninja Naruto",
        size = W(40),
        weight = 70,
    } )

    surface.CreateFont( "font_lr5", {
        font = "Ninja Naruto",
        size = W(50),
        weight = 70,
    } )
    
    
    surface.CreateFont( "font_lr6", {
        font = "Ninja Naruto",
        size = W(60),
        weight = 200,
    } )
    
    surface.CreateFont( "font_lr7", {
        font = "Ninja Naruto",
        size = W(75),
        weight = 200,
    } )

end

-- Materials --

LR.Materials = {

    Background = Material("sl_materials/ui/lr_background.png", "noclamp smooth"),
    close = Material("sl_materials/ui/lr_close.png", "noclamp smooth"),

}


-- Message -- 

MsgC(Color(90,228,255),             "[#-------------------------------------------------------------#]\n")
MsgC(Color(90,228,255),             "[#-        Système de REROLL crée par Liquid_stk#7729         -#]\n")
MsgC(Color(90,228,255),             "[#-------------------------------------------------------------#]\n")
