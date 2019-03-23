ARG jre_image_version=8-jre
FROM openjdk:8-jre

ARG flux_version=8-0-13
ENV flux_version=$flux_version

LABEL flux/flux-base \
      author=jerry.bowman@gmail.com

#ENV SYSTEM_PACKAGES="software-properties-common apt-transport-https ca-certificates"
ENV UTIL_PACKAGES="man unzip vim"
#  apt-get install -y $SYSTEM_PACKAGES && \

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

# chown -hR user:user /home/user
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
