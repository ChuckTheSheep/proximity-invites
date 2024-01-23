require "ISUI/UserPanel/ISSafehouseAddPlayerUI"

local util = require "ProximityInvites - utility"

local ISSafehouseAddPlayerUI_populateList = ISSafehouseAddPlayerUI.populateList
function ISSafehouseAddPlayerUI:populateList()
    ISSafehouseAddPlayerUI_populateList(self)
    for i=1, self.playerList:size() do
        local item = self.playerList.items[i]
        local playerA, playerB = self.player, getPlayerFromUsername(item.username)

        --if not playerB then print("WARNING: proximityInvite can't find: "..item.username) end
        if not item or not item.username or not playerB or (not util.validPlayerToPlayerDistance(playerA, playerB) ) then
            item.tooltip = (item.tooltip and item.tooltip.." " or "") .. getText("IGUI_outOfRange")
        end
    end
end