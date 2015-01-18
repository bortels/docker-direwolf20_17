#!/bin/bash

set -e

VERSION="${VERSION//./_}"
ZIPFILE="direwolf20_17-server.zip"

if [[ "${VERSION}" = "LATEST" ]]; then
    VERSION="$(wget -q -O - http://www.feed-the-beast.com/server-download | grep -Po "(direwolf20_17%5E[\d_]+)" | sed 's/direwolf20_17%5E//')"
fi

cd /data
# http://www.creeperrepo.net/FTB2/modpacks%5Edirewolf20_17%5E1_0_3%5Edirewolf20_17-server.zip
if [[ ! -e "${ZIPFILE}" ]]; then
    echo "Downloading modpacks%5Edirewolf20_17%5E${VERSION}%5Edirewolf20_17-server.zip -> ${ZIPFILE} ..."
    wget -c -O "${ZIPFILE}.part" "http://www.creeperrepo.net/FTB2/modpacks%5Edirewolf20_17%5E${VERSION}%5Edirewolf20_17-server.zip"
    mv "${ZIPFILE}"{.part,}
fi

[[ -d config ]] || unzip "${ZIPFILE}"

if [[ ! -e server.properties ]]; then
    cp /tmp/server.properties .
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

sh ./FTBInstall.sh

rm -f eula.txt
echo "eula=true" > eula.txt

java $JVM_OPTS -jar FTBServer-*.jar nogui
