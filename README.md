# Kafka Docker Image

## Run this Image

You should have at least one Zookeeper node running in order to start a Kafka server. When you create a Docker container using this image you have the possibility to provide host and port of the Zookeeper node or use the defaults, "localhost" and "2181", respectively.

    docker run kafka

    docker run kafka zookeeper.host.org 9999

    docker run kafka 10.16.8.29 3030

