FROM rnakato/ubuntu:18.04
LABEL original from continuumio/anaconda3 modified by "Ryuichiro Nakato <rnakato@iam.u-tokyo.ac.jp>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing \
    && apt-get install -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    dpkg \
    git \
    grep \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    mercurial \
    sed \
    subversion \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh -O ~/anaconda.sh \
    && /bin/bash ~/anaconda.sh -b -p /opt/conda \
    && rm ~/anaconda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc

RUN TINI_VERSION=$(curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:') \
    && curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb \
    && dpkg -i tini.deb \
    && rm tini.deb

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]