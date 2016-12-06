FROM centos:7
MAINTAINER Alex Kamalov, <akamalov@gmail.com> 

ENV JAVA_VERSION 8u112
ENV BUILD_VERSION b15
ENV JAVA_SHA256SUM=3197aa60a852b0410ceb8d2790405a7eef74622b2d2369121dd8d5d8e5388205

# You can get Java Checksums from here: https://www.oracle.com/webfolder/s/digest/8u112checksum.html 

# Update and Upgrade system
RUN yum -y upgrade && \
 yum -y install unzip wget curl jq coreutils

# Download Latest Java
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm 

# Run SHA256 Checksum

RUN echo "${JAVA_SHA256SUM}  /tmp/jdk-8-linux-x64.rpm" | sha256sum -c 

RUN yum -y install /tmp/jdk-8-linux-x64.rpm && \
 alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000 && \
 alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000 && \
 alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest

RUN yum clean all
