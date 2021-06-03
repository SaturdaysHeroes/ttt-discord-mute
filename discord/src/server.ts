import * as Discord from "discord.js";
import express from "express";
import {Request, Response} from "express";

export default function(client) {
    const app = express();

    app.listen(process.env.SERVER_PORT, () => {
        console.log("Loaded server.ts");
    });

    app.post("/mute", (req: Request, res: Response) => {
        let userId = req.query.user; 
        
        if (!userId) {
            res.send("Missing User");
            return;
        };

        let guild = client.guilds.cache.get(process.env.BOT_GUILD);
        guild.members.fetch({user: userId})
            .then(async (member: Discord.GuildMember) => {
                member.voice.setMute(true);
                res.sendStatus(200);
            })
            .catch(err => {
                console.log(`[ERROR] ${err}`);
                res.sendStatus(400)
            })
    });

    app.post("/unmute", (req: Request, res: Response) => {
        let userId = req.query.user; 
        
        if (!userId) {
            res.send("Missing User");
            return;
        };

        let guild = client.guilds.cache.get(process.env.BOT_GUILD);
        guild.members.fetch({user: userId})
            .then(async (member: Discord.GuildMember) => {
                member.voice.setMute(false);
                res.sendStatus(200);
            })
            .catch(err => {
                console.log(`[ERROR] ${err}`);
                res.sendStatus(400);
            })
    });
};