FROM centos:7

RUN yum -y groupinstall 'Development Tools'

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba && \
    micromamba create -y -p /usr/local/lmod conda-forge::lmod && \
    ln -s /usr/local/lmod/etc/conda/activate.d/lmod-activate.sh /etc/profile.d/lmod.sh && \
    micromamba clean -y -a

RUN yum -y install python3-devel && \
    python3 -m pip install -U pip && \
    python3 -m pip install easybuild && \
    python3 -m pip cache purge

RUN yum -y install sudo && \
    useradd easybuild && \
    echo 'easybuild ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/easybuild

RUN yum clean all

USER easybuild
ENV EASYBUILD_INSTALLPATH=/app
ENV EASYBUILD_PREFIX=/scratch
WORKDIR /app
WORKDIR /scratch
WORKDIR /home/easybuild
