# Kafka Docker Image

[![](https://img.shields.io/docker/pulls/jnonino/kafka)](https://hub.docker.com/r/jnonino/kafka/)
[![](hhttps://img.shields.io/docker/build/jnonino/kafka)](https://hub.docker.com/r/jnonino/kafka/)
[![](https://img.shields.io/docker/automated/jnonino/kafka)](https://hub.docker.com/r/jnonino/kafka/)
[![](https://img.shields.io/docker/stars/jnonino/kafka)](https://hub.docker.com/r/jnonino/kafka/)
[![](https://img.shields.io/github/license/jnonino/kafka-docker-image)](https://github.com/jnonino/kafka-docker-image)
[![](https://img.shields.io/github/issues/jnonino/kafka-docker-image)](https://github.com/jnonino/kafka-docker-image)
[![](https://img.shields.io/github/issues-closed/jnonino/kafka-docker-image)](https://github.com/jnonino/kafka-docker-image)
[![](https://img.shields.io/github/languages/code-size/jnonino/kafka-docker-image)](https://github.com/jnonino/kafka-docker-image)
[![](https://img.shields.io/github/repo-size/jnonino/kafka-docker-image)](https://github.com/jnonino/kafka-docker-image)

This Docker Image creates a Kafka node that can form a kafka Cluster in combination to other kafka nodes.

https://hub.docker.com/r/jnonino/kafka-docker-image/

You need to have a Zookeeper services running to create a Kafka Cluster, please refer to this Docker Image to start a Zookeeper Server: https://hub.docker.com/r/jnonino/zookeeper-docker-image/.

## Run this Image

You should have at least one Zookeeper node running in order to start a Kafka server. When you create a Docker container using this image you have the possibility to provide <host:port> of the Zookeeper node or use the defaults, "localhost:2181".

For example:  

    docker run jnonino/kafka-docker-image

    docker run jnonino/kafka-docker-image zookeeper.host.org:9999

    docker run jnonino/kafka-docker-image 10.16.8.29:2181

It is recommended to run an odd number of Kafka brokers, for example:  

    docker run --name kafka1 jnonino/kafka-docker-image <ZOOKEEPER>
    docker run --name kafka2 jnonino/kafka-docker-image <ZOOKEEPER>
    docker run --name kafka3 jnonino/kafka-docker-image <ZOOKEEPER>
