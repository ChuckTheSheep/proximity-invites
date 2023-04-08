--media/lua/client/
require "ISUI/UserPanel/ISFactionAddPlayerUI"

local util = require "ProximityInvites - utility"

function ISFactionAddPlayerUI:onClick(button)
    if button.internal == "CANCEL" then
        self:setVisible(false)
        self:removeFromUIManager()
    end
    if button.internal == "ADDPLAYER" then
        if not self.changeOwnership then
            if util.validPlayerToPlayerDistance(self.player, getPlayerFromUsername(self.selectedPlayer)) then
                local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_FactionUI_InvitationSent",self.selectedPlayer), false, nil, nil)
                modal:initialise()
                modal:addToUIManager()
                sendFactionInvite(self.faction, self.player, self.selectedPlayer)
            end
        else
            self.faction:setOwner(self.selectedPlayer)
            self.factionUI.isOwner = false
            self.factionUI:populateList()
            self.factionUI:updateButtons()
            self:setVisible(false)
            self:removeFromUIManager()
            self.faction:syncFaction()
        end
    end
end


--IGUI_outOfRange
function ISFactionAddPlayerUI:populateList()
    self.playerList:clear()
    self.addPlayer.enable = false
    if not self.scoreboard then return end
    for i=1,self.scoreboard.usernames:size() do
        local username = self.scoreboard.usernames:get(i-1)
        local displayName = self.scoreboard.displayNames:get(i-1)
        local doIt = false
        if self.changeOwnership then
            doIt = not self.faction:isOwner(username)
        else
            doIt = username ~= self.player:getUsername() and not self.faction:isMember(username)
        end
        if doIt then
            local newPlayer = {}
            newPlayer.name = username
            if self.changeOwnership then
                local alreadyFaction = self.faction:isMember(username)
                if not alreadyFaction then
                    newPlayer.tooltip = getText("IGUI_FactionUI_NoMember")
                end
            else
                local alreadyFaction = Faction.isAlreadyInFaction(username)
                if alreadyFaction then
                    newPlayer.tooltip = getText("IGUI_FactionUI_AlreadyHaveFaction")
                end
            end

            if not util.validPlayerToPlayerDistance(self.player, getPlayerFromUsername(username)) then
                newPlayer.tooltip = (newPlayer.tooltip and newPlayer.tooltip.." " or "") ..getText("IGUI_outOfRange")
            end

            local index = self.playerList:addItem(displayName, newPlayer)
            if newPlayer.tooltip then
                if self.playerList.items[i] then
                    self.playerList.items[i].tooltip = newPlayer.tooltip
                end
            end
        end
    end
end