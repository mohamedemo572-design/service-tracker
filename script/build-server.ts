import { build } from "esbuild";
import { mkdirSync, existsSync } from "fs";

if (!existsSync("dist")) mkdirSync("dist", { recursive: true });

await build({
  entryPoints: ["server/index.ts"],
  bundle: true,
  platform: "node",
  format: "cjs",
  outfile: "dist/index.cjs",
  packages: "external",
});

console.log("Server build complete!");
