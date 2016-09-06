FROM toolshed/requirements
MAINTAINER John Chilton, jmchilton@gmail.com

RUN apt-get -qq update && \
    apt-get install --no-install-recommends -y python-pip samtools curl && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TARGET_PATH=/target \
    PLANEMO_VIRTUALENV=/planemo_venv \
    PLANEMO_PIP_VERSION=0.30.2 \
    REPOSITORY=/opt/galaxy/tools \
    GALAXY_ROOT=/galaxy

RUN virtualenv "$PLANEMO_VIRTUALENV" && \
    . "$PLANEMO_VIRTUALENV/bin/activate" && \
    pip install planemo==$PLANEMO_PIP_VERSION

RUN . "$PLANEMO_VIRTUALENV/bin/activate" && \
    planemo conda_init

ADD tools.env /tools.env

CMD . /tools.env && \
    mkdir -p $REPOSITORY/.. && \
    git clone $GITHUB_REPO $REPOSITORY && \
    cp -r $TARGET_PATH $GALAXY_ROOT && \ 
    . "$PLANEMO_VIRTUALENV/bin/activate" && \
    planemo test --conda_dependency_resolution --conda_auto_init --conda_auto_install --galaxy_root "$GALAXY_ROOT" "$REPOSITORY"/"$REPO_TOOLS"
