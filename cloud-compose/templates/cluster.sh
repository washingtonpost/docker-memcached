#!/bin/bash
{% include "cloud.environment.sh" %}
{% include "system.limits_conf.sh" %}
{% include "system.mounts.sh" %}
{% include "docker.config.sh" %}
{% include "docker_compose.run.sh" %}
{% include "system.network_conf.sh" %}
{% include "datadog.memcached.sh" %}
