#!/bin/sh
cd /Users/tuhu/Projects/chinaembassy-dk-survillance
Rscript R/embassy-surveillance-CN.R
Rscript R/embassy-surveillance-EN.R
git add README.md
git add EN/README.md
git commit -m update
git push