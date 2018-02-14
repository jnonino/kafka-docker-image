#!/bin/bash

mv $KAFKA_HOME/config/server.properties $KAFKA_HOME/config/default_server.properties
DEFAULT_IF="$(ip route list | awk '/^default/ {print $5}')"
IP_ADDRESS="$(ifconfig | grep -A 1 $DEFAULT_IF | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
NODE_ID=$(echo $IP_ADDRESS | sed 's/[^0-9]*//g' | sed 's/.*\(.........\)/\1/')

if [[ -z "$1" ]]; then
    echo "Using default Zookeeper Host: localhost:2181"
    ZOOKEEPER_HOST=localhost
else
    ZOOKEEPER_HOST=$1
    echo "Using Zookeeper Host: $ZOOKEEPER_HOST"
fi

###############################################################################################
# SERVER PROPERTIES
###############################################################################################

### Server Basics
echo "# Server Basics" >> $KAFKA_HOME/config/server.properties
# The id of the broker. This must be set to a unique integer for each broker.
echo "broker.id=$NODE_ID" >> $KAFKA_HOME/config/server.properties
echo "reserved.broker.max.id=2147483647" >> $KAFKA_HOME/config/server.properties

### Zookeeper
echo "# Zookeeper" >> $KAFKA_HOME/config/server.properties
# Zookeeper connection string (see zookeeper docs for details).
# This is a comma separated host:port pairs, each corresponding to a zk
# server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002".
# You can also append an optional chroot string to the urls to specify the
# root directory for all kafka znodes.
echo "zookeeper.connect=$ZOOKEEPER_HOST" >> $KAFKA_HOME/config/server.properties
# Timeout in ms for connecting to zookeeper
echo "zookeeper.connection.timeout.ms=30000" >> $KAFKA_HOME/config/server.properties

### Socket Server Settings
echo "# Socket Server Settings" >> $KAFKA_HOME/config/server.properties
# The number of threads that the server uses for receiving requests from the network and sending responses to the network
echo "num.network.threads=3" >> $KAFKA_HOME/config/server.properties
# The number of threads that the server uses for processing requests, which may include disk I/O
echo "num.io.threads=8" >> $KAFKA_HOME/config/server.properties
# The send buffer (SO_SNDBUF) used by the socket server
echo "socket.send.buffer.bytes=102400" >> $KAFKA_HOME/config/server.properties
# The receive buffer (SO_RCVBUF) used by the socket server
echo "socket.receive.buffer.bytes=102400" >> $KAFKA_HOME/config/server.properties
# The maximum size of a request that the socket server will accept (protection against OOM)
echo "socket.request.max.bytes=104857600" >> $KAFKA_HOME/config/server.properties

### Log Basics
echo "# Log Basics" >> $KAFKA_HOME/config/server.properties
# A comma seperated list of directories under which to store log files
echo "log.dirs=/tmp/kafka-logs" >> $KAFKA_HOME/config/server.properties
# The default number of log partitions per topic. More partitions allow greater
# parallelism for consumption, but this will also result in more files across
# the brokers.
echo "num.partitions=1" >> $KAFKA_HOME/config/server.properties
# The number of threads per data directory to be used for log recovery at startup and flushing at shutdown.
# This value is recommended to be increased for installations with data dirs located in RAID array.
echo "num.recovery.threads.per.data.dir=1" >> $KAFKA_HOME/config/server.properties

### Internal Topic Settings
echo "# Internal Topic Settings" >> $KAFKA_HOME/config/server.properties
# The replication factor for the group metadata internal topics "__consumer_offsets" and "__transaction_state"
# For anything other than development testing, a value greater than 1 is recommended for to ensure availability such as 3.
echo "offsets.topic.replication.factor=1" >> $KAFKA_HOME/config/server.properties
echo "transaction.state.log.replication.factor=1" >> $KAFKA_HOME/config/server.properties
echo "transaction.state.log.min.isr=1" >> $KAFKA_HOME/config/server.properties

### Log Retention Policy
echo "# Log Retention Policy" >> $KAFKA_HOME/config/server.properties
# The minimum age of a log file to be eligible for deletion due to age
echo "log.retention.hours=168" >> $KAFKA_HOME/config/server.properties
# The maximum size of a log segment file. When this size is reached a new log segment will be created.
echo "log.segment.bytes=1073741824" >> $KAFKA_HOME/config/server.properties
# The interval at which log segments are checked to see if they can be deleted according
# to the retention policies
echo "log.retention.check.interval.ms=300000" >> $KAFKA_HOME/config/server.properties

### Group Coordinator Settings
# The following configuration specifies the time, in milliseconds, that the GroupCoordinator will delay the initial consumer rebalance.
# The rebalance will be further delayed by the value of group.initial.rebalance.delay.ms as new members join the group, up to a maximum of max.poll.interval.ms.
# The default value for this is 3 seconds.
# We override this to 0 here as it makes for a better out-of-the-box experience for development and testing.
# However, in production environments the default value of 3 seconds is more suitable as this will help to avoid unnecessary, and potentially expensive, rebalances during application startup.
echo "group.initial.rebalance.delay.ms=0" >> $KAFKA_HOME/config/server.properties

###############################################################################################
# START KAFKA
###############################################################################################
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties