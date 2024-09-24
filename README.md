# How to execute
docker build -t braindocker .
docker run --network host -p 22:22 -p 1991:1991 braindocker
