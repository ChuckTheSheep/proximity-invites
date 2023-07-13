require "ISUI/UserPanel/ISFactionAddPlayerUI"

local util = require "ProximityInvites - utility"

local ISFactionAddPlayerUI_populateList = ISFactionAddPlayerUI.populateList
function ISFactionAddPlayerUI:populateList()
    ISFactionAddPlayerUI_populateList(self)
    if self.changeOwnership then return end
    for i=1, self.playerList:size() do
        local item = self.playerList.items[i]
        local playerA, playerB = self.player, getPlayerFromUsername(item.username)

        if not playerB then print("WARNING: proximityInvite can't find: "..item.username) end

        if item and item.username and playerA and playerB and (not util.validPlayerToPlayerDistance(playerA, playerB) ) then
            item.tooltip = (item.tooltip and item.tooltip.." " or "") .. getText("IGUI_outOfRange")
        end
    end
end