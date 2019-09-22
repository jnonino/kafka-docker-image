# Kafka Docker Image

[![](https://img.shields.io/docker/pulls/cnservices/kafka)](https://hub.docker.com/r/cnservices/kafka/)
[![](hhttps://img.shields.io/docker/build/cnservices/kafka)](https://hub.docker.com/r/cnservices/kafka/)
[![](https://img.shields.io/docker/automated/cnservices/kafka)](https://hub.docker.com/r/cnservices/kafka/)
[![](https://img.shields.io/docker/stars/cnservices/kafka)](https://hub.docker.com/r/cnservices/kafka/)
[![](https://img.shields.io/github/license/cn-docker/kafka)](https://github.com/cn-docker/kafka)
[![](https://img.shields.io/github/issues/cn-docker/kafka)](https://github.com/cn-docker/kafka)
[![](https://img.shields.io/github/issues-closed/cn-docker/kafka)](https://github.com/cn-docker/kafka)
[![](https://img.shields.io/github/languages/code-size/cn-docker/kafka)](https://github.com/cn-docker/kafka)
[![](https://img.shields.io/github/repo-size/cn-docker/kafka)](https://github.com/cn-docker/kafka)

This Docker Image creates a Kafka node that can form a kafka Cluster in combination to other kafka nodes.

https://hub.docker.com/r/cnservices/kafka/

You need to have a Zookeeper services running to create a Kafka Cluster, please refer to this Docker Image to start a Zookeeper Server: https://hub.docker.com/r/cnservices/zookeeper/.

## Run this Image

You should have at least one Zookeeper node running in order to start a Kafka server. When you create a Docker container using this image you have the possibility to provide <host:port> of the Zookeeper node or use the defaults, "localhost:2181".

For example:  

    docker run cnservices/kafka

    docker run cnservices/kafka zookeeper.host.org:9999

    docker run cnservices/kafka 10.16.8.29:2181

It is recommended to run an odd number of Kafka brokers, for example:  

    docker run --name kafka1 cnservices/kafka <ZOOKEEPER>
    docker run --name kafka2 cnservices/kafka <ZOOKEEPER>
    docker run --name kafka3 cnservices/kafka <ZOOKEEPER>
