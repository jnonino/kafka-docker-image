FROM ubuntu
LABEL maintainer="Julian Nonino <noninojulian@gmail.com>"

# Install required tools, tar, curl, net-tools, iproute2 and Java JRE
RUN apt-get update -y && \
    apt-get install -y tar curl net-tools iproute2 openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Kafka
ENV KAFKA_VERSION 2.2.0
ENV SCALA_VERSION 2.12

RUN curl -O http://apache.mirror.anlx.net/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz && \
    tar -xvf kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz && \
    rm -rf kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz && \
    mv kafka_$SCALA_VERSION-$KAFKA_VERSION kafka && \
    mv kafka /opt
ENV KAFKA_HOME /opt/kafka
ENV PATH $KAFKA_HOME/bin:$KAFKA_HOME/lib:$PATH
WORKDIR /opt/kafka

# Expose port
EXPOSE 9092

COPY start.sh /usr/local/bin
ENTRYPOINT [ "/usr/local/bin/start.sh" ]
