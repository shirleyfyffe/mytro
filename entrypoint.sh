cd /mytrojan
cat config1.txt > config.json
echo -e "    \"local_port\": 1080," >> config.json
cat config2.txt >> config.json
./trojan
