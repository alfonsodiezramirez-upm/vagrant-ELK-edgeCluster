curl -O https://artifacts.elastic.co/downloads/kibana/kibana-8.5.2-linux-x86_64.tar.gz
curl https://artifacts.elastic.co/downloads/kibana/kibana-8.5.2-linux-x86_64.tar.gz.sha512 | shasum -a 512 -c - 
tar -xzf kibana-8.5.2-linux-x86_64.tar.gz
mv kibana-8.5.2 kibana
cd kibana/
token=$(cat /sharedData/token)
echo "server.host: \"192.168.22.12\"">./config/kibana.yml
echo "server.port: 5601">>./config/kibana.yml
echo "elasticsearch.hosts: \"https://192.168.22.11:9200\"">>./config/kibana.yml
echo "elasticsearch.serviceAccountToken: \"$token\"">>./config/kibana.yml
echo "elasticsearch.ssl.verificationMode: \"none\"">>./config/kibana.yml
./bin/kibana &