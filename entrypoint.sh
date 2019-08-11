cd /mytrojan
cat config1.txt > tmpconfig.json
echo -e "    \"local_port\": $PORT," >> tmpconfig.json
cat config2.txt >> tmpconfig.json
cat tmpconfig.json > config.json
./trojan
