FROM    centos:centos7

MAINTAINER psteiner <psteiner@redhat.com>, ishuverma <iverma@redhat.com>

# Update the system and Install necessary RPMs
RUN yum -y install java-1.7.0-openjdk-devel unzip wget telnet git

# Make sure required environments are set
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk
ENV HOME /home/demo-user
ENV MAVEN_HOME /opt/apache-maven-3.3.9

# Set root password
RUN echo "root:change12_me" | /usr/sbin/chpasswd

# download and install maven
RUN wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip && \
    unzip apache-maven-3.3.9-bin.zip && \
    mv apache-maven-3.3.9/ /opt/ && \
    ln -s /opt/apache-maven-3.3.9/bin/mvn /usr/bin/mvn && \
    rm apache-maven-3.3.9-bin.zip


# Create user to run processed
RUN useradd -m -d /home/demo-user -p demo-user demo-user

# Switch to new user
USER demo-user

# create a few needed directories
RUN mkdir $HOME/tmp && \
    mkdir $HOME/.m2

# transfer maven configuration file
ADD config/settings.xml $HOME/.m2/

# as ADD always uses root as user, we have to give
# the file back to 'demo-user'
USER root
RUN chown -R demo-user $HOME/.m2/*
USER demo-user

# lets create a volume to mount the external maven repo
VOLUME /maven_repo

# make $HOME/tmp the active directory
WORKDIR $HOME/tmp

# Build command -> docker build --rm -t demo-user/base .
# run command -> docker run -d demo-user/base
# run command ->  docker run -i -t -v /home/demo-user/.m2/repository/:/maven_repo  demo-user/base /bin/bash
