import path from "path";
import fs from "fs";

const sites = [
  "tinaandcarlton",
  "carltonjoseph",
];

const srcDir = "./redirects";
const dstDir = "./mnt/volume_sfo2_02/cj/";

(async () => {
  sites.map(site => {
    const src = path.join(srcDir, site);
    const dst = path.join(dstDir, site);
    fs.copyFileSync(src,dst);
  });
})().catch(e => console.log(e));
