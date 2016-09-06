FROM toolshed/requirements
MAINTAINER John Chilton, jmchilton@gmail.com

RUN apt-get -qq update && \
    apt-get install --no-install-recommends -y python-pip samtools curl && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TODO: change tag after a release
ENV TARGET_PATH=/target \
    GALAXY_ROOT=/galaxy \ 
    PULSAR_TAG=master \
    PULSAR_PATH=/opt/pulsar

RUN git clone https://github.com/galaxyproject/pulsar.git /opt/pulsar && \
    cd /opt/pulsar && \
    git checkout "$PULSAR_TAG"

WORKDIR /opt/pulsar

#RUN PULSAR_INSTALL_TARGET="pulsar-app==$PULSAR_TAG" GALAXY_ROOT=$GALAXY_ROOT ./install_test/test_install.bash
CMD cp -r $TARGET_PATH $GALAXY_ROOT && \
    PULSAR_INSTALL_TARGET="pulsar-app" GALAXY_ROOT=$GALAXY_ROOT ./install_test/test_install.bash
