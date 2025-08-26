FROM mambaorg/micromamba:1.5.8

# Use the recommended pattern: copy env first (cache-friendly) and own it
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml

# Create the env (not "install into base"); clean afterwards
RUN micromamba env create -y -f /tmp/environment.yml && \
    micromamba clean -a -y

# Make the env active for subsequent RUN/CMD without needing 'conda activate'
ENV MAMBA_DOCKERFILE_ACTIVATE=1
SHELL ["/bin/bash", "-lc"]
ENV PATH=/opt/conda/envs/s5p/bin:$PATH

WORKDIR /usr/local/app
COPY . .