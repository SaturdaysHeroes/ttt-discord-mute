DiscordMute = DiscordMute || {}
DiscordMute.Config = DiscordMute.Config || {}

-- Discord Bot endpoint. 
DiscordMute.Config.Endpoint = "http://localhost:6000"

-- List of Steam IDs associated with Discord ID.
DiscordMute.Config.Players = {
    ["steamid"] = "discordid"
}

function DiscordMute:HTTP(strURL, strMethod, tblHeaders, strBody, funcSuccess)
    local tblData = {
        url = strURL,
        method = string.lower(strMethod),
        headers = tblHeaders,
        body = strBody,
        type = "application/json",
        success = funcSuccess
    }

    HTTP(tblData) 
end 

function DiscordMute:Mute(pPlayer)
    if !IsValid(pPlayer) then return end 
    if !self.Config.Players[pPlayer:SteamID64()] then return end 

    self:HTTP(self.Config.Endpoint.."/mute?user="..self.Config.Players[pPlayer:SteamID64()], "POST", {}, "")
end 

function DiscordMute:Unmute(pPlayer)
    if !IsValid(pPlayer) then return end 
    if !self.Config.Players[pPlayer:SteamID64()] then return end 

    self:HTTP(self.Config.Endpoint.."/unmute?user="..self.Config.Players[pPlayer:SteamID64()], "POST", {}, "")
end 

function DiscordMute.TTTEndRound()
    for i, v in ipairs(player.GetAll()) do 
        if !IsValid(v) then return end 

        DiscordMute:Unmute(v)
    end 
end 
hook.Add("TTTEndRound", "DiscordMute.TTTEndRound", DiscordMute.TTTEndRound)

function DiscordMute.PlayerDeath(pPlayer)
    if !IsValid(pPlayer) then return end

    DiscordMute:Mute(pPlayer)
end 
hook.Add("PlayerDeath", "DiscordMute.PlayerDeath", DiscordMute.PlayerDeath)

function DiscordMute.PlayerDisconnected(pPlayer)
    if !IsValid(pPlayer) then return end 

    DiscordMute:Unmute(pPlayer)
end 
hook.Add("PlayerDisconnected", "DiscordMute.PlayerDisconnected", DiscordMute.PlayerDisconnected)