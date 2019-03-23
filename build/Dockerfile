ARG jre_image_version=8-jre
FROM openjdk:$jre_image_version

ARG flux_version=8-0-13
ENV flux_version=$flux_version

LABEL flux-version=$flux_version \
      author=jerry.bowman@gmail.com

ENV UTIL_PACKAGES="man unzip vim"

# Install prereqs and setup apt 
RUN \
    apt-get update && \
    apt-get install -y $UTIL_PACKAGES && \
    apt-get autoremove -y  && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN \
    useradd --shell /bin/bash -u 1001 -o -c "" -m user && \
    mkdir -p /home/user

USER user
WORKDIR /home/user
ENV HOME=/home/user

COPY flux-$flux_version.zip .
COPY postgresql-42.2.5.jar .

RUN \
    mkdir -p .flux && \
    unzip -qq flux-$flux_version.zip && \
    mv flux-$flux_version flux && \
    rm flux-$flux_version.zip && \
    mv postgresql-42.2.5.jar flux/lib && \
    cd flux && \
    ./configure.sh && \
    cd ..

COPY entrypoint.sh ./entrypoint.sh
ENTRYPOINT ["/home/user/entrypoint.sh"]
