FROM ubuntu:xenial
LABEL maintainer="Julian Nonino <noninojulian@outlook.com>"

# Install required tools, tar, curl, net-tools, iproute and Java JRE
RUN apt-get update -y && \
    apt-get install -y tar curl net-tools iproute openjdk-8-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Kafka
ENV KAFKA_VERSION 1.0.0
ENV SCALA_VERSION 2.12
RUN curl -O http://www-us.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz && \
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
CMD [ "/usr/local/bin/start.sh" ]