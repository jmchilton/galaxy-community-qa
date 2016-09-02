FROM toolshed/requirements
MAINTAINER John Chilton, jmchilton@gmail.com

RUN apt-get -qq update && \
    apt-get install --no-install-recommends -y postgresql-client python-pip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV GALAXY_USER_EMAIL=admin@galaxy.org \
    GALAXY_USER=admin \
    GALAXY_USER_PASSWD=240761c77ed4682c26283e158a7ddf32 \
    GALAXY_CONFIG_OVERRIDE_ADMIN_USERS=admin@galaxy.org \
    GALAXY_CONFIG_OVERRIDE_ALLOW_USER_DATASET_PURGE=true \
    GALAXY_CONFIG_OVERRIDE_ALLOW_LIBRARY_PATH_PASTE=true \
    GALAXY_CONFIG_OVERRIDE_ENABLE_BETA_WORKFLOW_MODULES=true \
    GALAXY_CONFIG_OVERRIDE_ALLOW_USER_DELETION=true \
    GALAXY_CONFIG_OVERRIDE_DATABASE_CONNECTION=postgresql://postgres@postgres/galaxy \
    GALAXY_CONFIG_OVERRIDE_MASTER_API_KEY=94a548bea347a35e457a804bf75bec53 \
    GALAXY_VIRTUAL_ENV=/galaxy_env \
    GALAXY_ROOT=/galaxy \
    BIOBLEND_ROOT=/bioblend \
    BIOBLEND_GIT_URL=https://github.com/galaxyproject/bioblend.git \
    BIOBLEND_VIRTUAL_ENV=/bioblend-venv \ 
    BIOBLEND_GALAXY_URL=http://localhost:8080

# bioblend with support for testing 16.07 ~0.8.0
ENV BIOBLEND_COMMIT=49927589f0af7669ce27086dd2a27cf2026111de

RUN virtualenv "$BIOBLEND_VIRTUAL_ENV" && \
    . "$BIOBLEND_VIRTUAL_ENV/bin/activate" && pip install tox mock pbr

RUN git clone "$BIOBLEND_GIT_URL" "$BIOBLEND_ROOT"
WORKDIR $BIOBLEND_ROOT
RUN git checkout "$BIOBLEND_COMMIT"
RUN . "$BIOBLEND_VIRTUAL_ENV/bin/activate" && tox --notest -e py27

ADD run_tests.bash /run_tests.bash
