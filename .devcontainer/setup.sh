#!/bin/sh
set -e

echo "[g2ray] Downloading Xray latest..."
curl -sL "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip" -o /tmp/xray.zip
unzip -q /tmp/xray.zip xray -d /tmp
install -m 755 /tmp/xray /usr/local/bin/xray
rm /tmp/xray.zip

echo "[g2ray] Downloading GeoIP and GeoSite..."
curl -sL "https://github.com/v2fly/geoip/releases/latest/download/geoip.dat" -o /usr/local/bin/geoip.dat
curl -sL "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" -o /usr/local/bin/geosite.dat

echo "[g2ray] Done."