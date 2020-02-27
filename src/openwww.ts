import { exec } from "child_process";

const sites = [
  "carltonathome",
  "carltonwin8",
  "tinaandcarlton",
  "appsfortracking",
  "apps4tracking",
  "carltonjoseph",
  "sophieandchampagne",
  "home-root"
];
// need to implement the following
//  http://stackoverflow.com http://wikipedia.org

(async () => {
  sites.map(site => exec(`open -a "Google Chrome" http://${site}.local`));
})().catch(e => console.log(e));
