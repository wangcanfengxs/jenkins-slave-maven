FROM jenkinsci/jnlp-slave

# install maven

ENV JENKINS_HOME=/home/jenkins
ENV MAVEN_HOME=$JENKINS_HOME/mvn
ENV MAVEN_VERSION=3.3.9

RUN wget http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& tar -zvxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C $JENKINS_HOME \
&& ln -s $JENKINS_HOME/apache-maven-${MAVEN_VERSION} $MAVEN_HOME

ENV PATH=$MAVEN_HOME/bin:$PATH

USER jenkins

WORKDIR $JENKINS_HOME

ENTRYPOINT ["/usr/local/bin/jenkins-slave"]
