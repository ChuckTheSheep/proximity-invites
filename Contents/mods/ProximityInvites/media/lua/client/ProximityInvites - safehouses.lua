require "ISUI/UserPanel/ISSafehouseAddPlayerUI"

local util = require "ProximityInvites - utility"

local ISSafehouseAddPlayerUI_populateList = ISSafehouseAddPlayerUI.populateList
function ISSafehouseAddPlayerUI:populateList()
    ISSafehouseAddPlayerUI_populateList(self)


    for i=1,self.scoreboard.usernames:size() do

        local username = self.scoreboard.usernames:get(i-1)
        local playerA, playerB = self.player, getPlayerFromUsername(username)
        local item = self.playerList.items[i]

        --if not playerB then print("WARNING: proximityInvite can't find: "..item.username) end
        if not username or not playerB or not util.validPlayerToPlayerDistance(playerA, playerB) then
            if item then
                self.playerList.items[i].tooltip = (item.tooltip and item.tooltip.." " or "") .. getText("IGUI_outOfRange")
            end
        end
    end

end