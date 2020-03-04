import { exec } from "child_process";

const sites = [
  "carltonathome",
  "carltonwin8",
  "tinaandcarlton",
  "appsfortracking",
  "apps4tracking",
  "carltonjoseph",
  "sophieandchampagne"
];

const siteCfg = {
  local: { transport: "http" },
  com: { transport: "https" }
};

const useLocal = false;
const baseUrl = useLocal ? "local" : "com";
const { transport } = siteCfg[baseUrl];

(async () => {
  const cmd = site =>
    `open -a "Google Chrome" ${transport}://${site}.${baseUrl}`;
  sites.map(site => {
    const c = cmd(site);
    console.log(c);
    exec(c);
  });
})().catch(e => console.log(e));
