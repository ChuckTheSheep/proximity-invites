--media/lua/client/
require "ISUI/UserPanel/ISSafehouseAddPlayerUI"

local util = require "ProximityInvites - utility"

local ISSafehouseAddPlayerUI_populateList = ISSafehouseAddPlayerUI.populateList
function ISSafehouseAddPlayerUI:populateList()
    ISSafehouseAddPlayerUI_populateList(self)
    for i=1, self.playerList:size() do
        local item = self.playerList.items[i]
        local playerA, playerB = self.player, getPlayerFromUsername(item.username)
        if item and item.username and playerA and playerB and (not util.validPlayerToPlayerDistance(playerA, playerB) ) then
            item.tooltip = (item.tooltip and item.tooltip.." " or "") .. getText("IGUI_outOfRange")
        end
    end
end