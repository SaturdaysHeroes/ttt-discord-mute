import * as dotenv from "dotenv"; dotenv.config();
import * as Discord from "discord.js";
import {default as StartBot} from "./bot";
import {default as StartServer} from "./server";

// Initialize the Discord clien. 
const client = new Discord.Client(); 

// Initialize the Bot and Server. 
StartBot(client); 
StartServer(client);

process.on("unhandledRejection", err => {
    throw err;
});