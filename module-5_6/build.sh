#!/bin/sh
# Sam Dirr | CSD430 | Modules 5.3 and 6.3 | November 22, 2026
# Purpose: Compile the included Java source for deployment on Tomcat.
# Source: Generated with assistance from OpenAI ChatGPT (https://chatgpt.com/).
set -eu
cd "$(dirname "$0")"
mkdir -p WEB-INF/classes
javac --release 17 -d WEB-INF/classes WEB-INF/src/movies/*.java
printf '%s\n' 'Java source compiled successfully.'
