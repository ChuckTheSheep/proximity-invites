--[[
---Back burner in case needed

if isServer() then
    local function onClientCommand(_module, _command, _player, _data)
        if _module ~= "proximityInvites" then return end
        if _command == "update" then

            local playerData = {}
            local players = getOnlinePlayers()
            for i=0, players:size()-1 do
                ---@type IsoPlayer
                local player = players:get(i)
                local playerUsername, x, y = player:getUsername(), player:getX(), player:getY()
                playerData[playerUsername] = {x=x,y=y}
            end

            sendServerCommand(_player, _module, _command, playerData)
        end
    end
    Events.OnClientCommand.Add(onClientCommand)--what the server gets from the client
end

if isClient() then
    --local proximityUtil = require "ProximityInvites - utility"
    local function onServerCommand(_module, _command, _data)
        if _module ~= "proximityInvites" then return end
        if _command == "update" then
            sendClientCommand(getPlayer(), _module, _command, {})
            --proximityUtil.receiveUpdate(_data[1])
        end
    end
    Events.OnServerCommand.Add(onServerCommand)--what clients gets from the server
end
-]]