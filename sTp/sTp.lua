
-- Define the function for displaying floating text "Press E" next to markers
local function ShowText(text, coords)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z + 1.0)
    local dist = #(GetGameplayCamCoord() - coords)
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.0, 0.35 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

local tpPoints = {
    {coords = vector3(-1843.1, -341.71, 48.45), label = "Appuyez sur E pour accéder au toit", target = 2}, -- Coordonnées du premier point de téléportation
    {coords = vector3(-1835.52, -339.09, 57.16), label = "Appuyez sur E pour descendre à l'accueil", target = 1}, -- Coordonnées du deuxième point de téléportation
    {coords = vector3(-1872.49, -307.15, 57.16), label = "Appuyez sur E pour monter dans les bureaux 8eme étage", target = 4}, -- Coordonnées du troisième point de téléportation
    {coords = vector3(-1829.24, -336.65, 83.06), label = "Appuyez sur E pour descendre vers l'étage 2", target = 3}, -- Coordonnées du quatrième point de téléportation
    {coords = vector3(-1845.58, -350.94, 48.43), label = "Appuyez sur E pour aller au garage -2", target = 6}, -- Coordonnées du cinquième point de téléportation
    {coords = vector3(-1846.07, -342.27, 40.25), label = "Appuyez sur E pour aller à l'accueil", target = 5} -- Coordonnées du sixième point de téléportation
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, tpPoint in ipairs(tpPoints) do
            DrawMarker(1, tpPoint.coords.x, tpPoint.coords.y, tpPoint.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 200, false, true, 2, false, false, false, false)
            if Vdist(GetEntityCoords(PlayerPedId()), tpPoint.coords) < 2.0 then
                ShowText(tpPoint.label, tpPoint.coords)
                if IsControlJustPressed(1, 38) then
                    local targetMarker = tpPoints[tpPoint.target]
                    if targetMarker then
                        Citizen.Wait(500)
                        SetEntityCoords(PlayerPedId(), targetMarker.coords.x, targetMarker.coords.y, targetMarker.coords.z, false, false, false, false)
                    end
                end
            end
        end
    end
end)
