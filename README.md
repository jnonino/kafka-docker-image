# Kafka Docker Image

## Run this Image

You should have at least one Zookeeper node running in order to start a Kafka server. When you create a Docker container using this image you have the possibility to provide <host:port> of the Zookeeper node or use the defaults, "localhost:2181".

For example:  

    docker run jnonino/kafka-docker-image

    docker run jnonino/kafka-docker-image zookeeper.host.org:9999

    docker run jnonino/kafka-docker-image 10.16.8.29:2181
