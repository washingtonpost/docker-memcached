#!/bin/bash
set -e

# first check if we're passing flags, if so
# prepend with memcached
if [ "${1:0:1}" = '-' ]; then
	set -- memcached "$@"
  exec "$@"
else
  MEM_TOTAL=`cat /proc/meminfo | grep MemTotal | sed "s/MemTotal:\s*//" | sed "s/ kB//"`
  # convert to MB's and leave 1GB for the OS
  CACHE_SIZE=$(expr $MEM_TOTAL / 1024 - 2048)
  MAX_CONNS=$(sysctl -n net.netfilter.nf_conntrack_max)
  CORE_COUNT=$(nproc)
  echo "MEM_TOTAL: ${MEM_TOTAL} KB"
  echo "CACHE_SIZE: ${CACHE_SIZE} MB"
  echo "MAX_CONNS: ${MAX_CONNS}"
  echo "CORE_COUNT: ${CORE_COUNT}"
  
  exec memcached -m $CACHE_SIZE -t $CORE_COUNT -c $MAX_CONNS $MEMCACHED_EXTRA_OPTIONS
fi

