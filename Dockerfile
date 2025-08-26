FROM mambaorg/micromamba:1.5.8
WORKDIR /usr/local/app

# copy env first to leverage build cache
COPY environment.yml /tmp/environment.yml
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean -a -y

# (optional) make conda available in non-login shells
SHELL ["/bin/bash", "-lc"]

COPY . .