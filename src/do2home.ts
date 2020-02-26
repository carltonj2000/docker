import path from "path";
import fs from "fs";

const fileIn = "../docker-compose-do.yml";
const fileOut = "../docker-compose-home.yml";

const doCfg = "nginx-do.conf";
const homeCfg = "nginx-home.conf";

(async () => {
  const inData = fs.readFileSync(path.join(__dirname, fileIn)).toString();
  const inLines = inData.split("\n");
  const outLines = inLines
    .filter(l => !l.includes("restart"))
    .filter(l => !l.includes("443"))
    .filter(l => !l.includes("ssl"))
    .map(l => l.replace(doCfg, homeCfg));
  const outData = outLines.join("\n");
  const debug = false;
  if (debug) console.log(outData);
  fs.writeFileSync(path.join(__dirname, fileOut), outData);
})().catch(e => console.log(e));
