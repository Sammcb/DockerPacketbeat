while true; do
	packetbeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.enabled=true && break
	sleep 5
done
packetbeat -e
