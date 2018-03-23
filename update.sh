#!/bin/bash

cd "${0%/*}"
git remote add upstream https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion.git
git fetch upstream
git pull -X theirs upstream master
sed -i -e 's/amd64/armhf/g' Dockerfile
if [[ "$(head -1 README.md)" != armhf* ]]; then
	echo -e 'armhf port of [jrcs/letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion): [keksnase/letsencrypt-nginx-proxy-companion-armhf](https://hub.docker.com/r/keksnase/letsencrypt-nginx-proxy-companion-armhf/)\n' | cat - README.md > temp && mv temp README.md
fi
docker build -t keksnase/letsencrypt-nginx-proxy-companion-armhf .
docker push keksnase/letsencrypt-nginx-proxy-companion-armhf
git commit -am "automated update"
git push origin master
