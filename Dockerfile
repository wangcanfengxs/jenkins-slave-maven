FROM jenkinsci/jnlp-slave

#install maven

USER root

ARG JENKINS_HOME=/home/jenkins
ARG MAVEN_VERSION=3.3.9

# install maven

RUN wget http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} /usr/local && \
    rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    ln -s /usr/local/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn && \
    ln -s /usr/local/apache-maven-${MAVEN_VERSION} /usr/local/maven
    
ADD ./settings.xml /usr/local/maven/conf

USER jenkins

WORKDIR $JENKINS_HOME

ADD ./settings.xml $JENKINS_HOME

ENTRYPOINT ["/usr/local/bin/jenkins-slave"]

