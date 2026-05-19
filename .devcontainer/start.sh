#!/bin/bash
# Check if xray exists, download if not
if [ ! -f /usr/local/bin/xray ]; then
  echo "[g2ray] Xray not found, downloading..."
  curl -sL "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip" -o /tmp/xray.zip
  unzip -q /tmp/xray.zip xray -d /tmp
  sudo install -m 755 /tmp/xray /usr/local/bin/xray
fi

if [ ! -f /usr/local/bin/geoip.dat ]; then
  echo "[g2ray] Downloading geo files..."
  sudo curl -sL "https://github.com/v2fly/geoip/releases/latest/download/geoip.dat" -o /usr/local/bin/geoip.dat
  sudo curl -sL "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" -o /usr/local/bin/geosite.dat
fi

tmux kill-session -t g2ray 2>/dev/null || true
tmux new-session -d -s g2ray
tmux send-keys -t g2ray "sudo /usr/local/bin/xray run -c /etc/xray/g2ray.json &>/tmp/xray.log" Enter
sleep 2

gh codespace ports visibility 443:public -c $CODESPACE_NAME 2>/dev/null || true

SELF_URL="https://${CODESPACE_NAME}-443.app.github.dev"
tmux new-window -t g2ray -n keepalive
tmux send-keys -t g2ray:keepalive "while true; do curl -sk --max-time 10 '${SELF_URL}/' -o /dev/null; sleep 180; done" Enter
echo "[g2ray] Keepalive فعال است — هر 180 ثانیه self-ping"
echo "[g2ray] سرور داخل tmux اجرا شد"
echo "[g2ray] برای دیدن log: tmux attach -t g2ray"