local proximityInvites = {}

function proximityInvites.validPlayerToPlayerDistance(playerA, playerB)
    local distanceCap = SandboxVars.ProximityInvites.range or 10
    if (distanceCap == -1) or (playerA:DistTo(playerB) <= SandboxVars.ProximityInvites.range) then return true end
    return false
end

return proximityInvites