FROM rnakato/ubuntu:20.04
LABEL maintainer "Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"

WORKDIR /opt
ENV PYENV_ROOT /opt/pyenv
ENV PATH ${PYENV_ROOT}/bin:$PYENV_ROOT/shims:${PATH}

ENV PATH /opt/bowtie2-2.3.5.1-linux-x86_64:/opt/script:${PATH}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-file \
    apt-utils \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    emacs \
    git \
    unzip \
    vim \
    xorg \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# pyenv
RUN git clone https://github.com/yyuu/pyenv.git /opt/pyenv \
    && pyenv install anaconda3-2019.10 \
    && pyenv rehash \
    && pyenv global anaconda3-2019.10

RUN conda update -y conda \
    && conda install -y pip numpy scipy matplotlib pandas seaborn Theano Flask SymPy IPython nltk pyqtgraph  scikit-learn notebook pep8 pyflakes pytest pytest-pep8 beautifulsoup4 lxml html5lib wheel xlrd h5py cython numexpr statsmodels openpyxl bokeh \
    && conda install -y -c bioconda deeptools kallisto samtools htseq segway \
    && pip install -U macs2 cutadapt pysnooper python-igraph louvain opencv-python opencv-contrib-python pycallgraph nolearn cairocffi autopep8 pystan Biopython pymp-pypi py3-ortools sphinx nbsphinx sphinx-autobuild sphinx_rtd_theme sphinxcontrib-exceltable pyfaidx cudnnenv jupyterthemes japanize-matplotlib jupyter_contrib_nbextensions dask plotly parameterized requests RSeQC PePr umap-learn black pybedtools