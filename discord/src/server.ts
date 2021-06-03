import express from "express";
import {Request, Response} from "express";
import bodyParser from "body-parser";

export default function(client) {
    const app = express();
    app.use(bodyParser.json());

    app.listen(process.env.APP_PORT_HTTP, () => {
        console.log("Loaded bot.ts");
    });
};