--media/lua/client/
require "ISUI/UserPanel/ISSafehouseAddPlayerUI"

local util = require "ProximityInvites - utility"


function ISSafehouseAddPlayerUI:onClick(button)
    if button.internal == "CANCEL" then
        self:setVisible(false)
        self:removeFromUIManager()
        ISSafehouseAddPlayerUI.instance = nil
    end
    if button.internal == "ADDPLAYER" then
        if not self.changeOwnership then
            if util.validPlayerToPlayerDistance(self.player, getPlayerFromUsername(self.selectedPlayer)) then
                local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_FactionUI_InvitationSent",self.selectedPlayer), false, nil, nil)
                modal:initialise()
                modal:addToUIManager()
                sendSafehouseInvite(self.safehouse, self.player, self.selectedPlayer)
            end
        else
            self.safehouse:setOwner(self.selectedPlayer)
            self.safehouse:syncSafehouse()
            if self.player:getX() >= self.safehouse:getX() - 1 and self. player:getX() < self.safehouse:getX2() + 1 and self.player:getY() >= self.safehouse:getY() - 1 and self.player:getY() < self.safehouse:getY2() + 1 then
                self.safehouse:kickOutOfSafehouse(self.player)
            end
            self.safehouseUI:populateList()
            self:setVisible(false)
            self:removeFromUIManager()
            ISSafehouseAddPlayerUI.instance = nil
        end
    end
end

--IGUI_outOfRange
function ISSafehouseAddPlayerUI:populateList()
    self.playerList:clear()
    if not self.scoreboard then return end
    for i=1,self.scoreboard.usernames:size() do
        local username = self.scoreboard.usernames:get(i-1)
        local displayName = self.scoreboard.displayNames:get(i-1)
        if self.safehouse:getOwner() ~= username then
            local newPlayer = {}
            newPlayer.username = username
            local alreadySafe = self.safehouse:alreadyHaveSafehouse(username)
            if alreadySafe and alreadySafe ~= self.safehouse then
                if alreadySafe:getTitle() ~= "Safehouse" then
                    newPlayer.tooltip = getText("IGUI_SafehouseUI_AlreadyHaveSafehouse", "(" .. alreadySafe:getTitle() .. ")")
                else
                    newPlayer.tooltip = getText("IGUI_SafehouseUI_AlreadyHaveSafehouse" , "")
                end
            end

            if not util.validPlayerToPlayerDistance(self.player, getPlayerFromUsername(username)) then
                if newPlayer.tooltip then newPlayer.tooltip = newPlayer.tooltip.." " end
                newPlayer.tooltip = newPlayer.tooltip..getText("IGUI_outOfRange")
            end

            local item = self.playerList:addItem(displayName, newPlayer)
            if newPlayer.tooltip then
                item.tooltip = newPlayer.tooltip
            end
        end
    end
end