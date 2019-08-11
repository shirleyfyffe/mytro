cd /mytrojan
cat config1.txt > config.json
echo -e "    \"local_port\": $PORT," >> config.json
cat config2.txt >> tmpconfig.json
cat tmpconfig.json > config.json
./trojan
