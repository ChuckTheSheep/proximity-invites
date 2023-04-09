require "ISUI/UserPanel/ISFactionAddPlayerUI"

local util = require "ProximityInvites - utility"

local ISFactionAddPlayerUI_populateList = ISFactionAddPlayerUI.populateList
function ISFactionAddPlayerUI:populateList()
    ISFactionAddPlayerUI_populateList(self)
    if self.changeOwnership then return end
    for i=1, self.playerList:size() do
        local item = self.playerList.items[i]
        if item and item.username and (not util.validPlayerToPlayerDistance(self.player, getPlayerFromUsername(item.username))) then
            item.tooltip = (item.tooltip and item.tooltip.." " or "") .. getText("IGUI_outOfRange")
        end
    end
end