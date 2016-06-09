# datadog.memcached.sh 
cat <<- 'EOF' > /etc/dd-agent/conf.d/mcache.yaml
init_config:

instances:
  - url: localhost  # url used to connect to the memcached instance
    #port: 11211 # If this line is not present, port will default to 11211
EOF
# datadog.start
sh -c "sed 's/api_key:.*/api_key: {{DATADOG_API_KEY}}/' /etc/dd-agent/datadog.conf.example > /etc/dd-agent/datadog.conf"
echo 'bind_host: 0.0.0.0' >> /etc/dd-agent/datadog.conf
service datadog-agent restart
