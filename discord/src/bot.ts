import * as Discord from "discord.js";

export default function(client: Discord.Client) {
    client.on("ready", () => {
        client.user.setActivity("Jan Dziendziel");
        console.log("Loaded bot.ts");
    });

    client.login(process.env.BOT_TOKEN);
};