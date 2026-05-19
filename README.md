sudo pkill -f xray
sleep 2
sudo /usr/local/bin/xray run -c /etc/xray/g2ray.json &
sleep 3
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:443


gh codespace ports visibility 443:public -c $CODESPACE_NAME