local DisableDarkRPNameChatCommand = false

concommand.Add("c_rpname", function(ply, cmd, args)
    if not ply.ForcedNameChange and (not ply.DarkRPVars or (ply.DarkRPVars.rpname and ply.DarkRPVars.rpname ~= ply:SteamName() and ply.DarkRPVars.rpname ~= "NULL")) then
        return
    end
end)

hook.Add("PlayerAuthed", "RPNameChecking", function(ply)
    timer.Simple(9, function() 
        if not IsValid(ply) then return end
        if ply.DarkRPVars and (not ply.DarkRPVars.rpname or ply.DarkRPVars.rpname == ply:SteamName() or ply.DarkRPVars.rpname == "NULL") then
            net.Start("openRPNameMenu")
            net.Send(ply)
        end
    end) 
end)

if DisableDarkRPNameChatCommand then
    timer.Simple(0, function() DarkRP.removeChatCommand("rpname") end)
end
