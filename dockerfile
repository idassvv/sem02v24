FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git
RUN useradd -G sudo -m -d /home/idassvv -s /bin/bash -p "$(openssl passwd -1 1234)" idassvv
 USER idassvv
WORKDIR /home/idassvv
RUN mkdir hacking \
&& cd hacking \
&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \
&& cd ..
RUN git config --global user.email "ida.svendby@online.no" \
&& git config --global user.name "Ida svendby" \
&& git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
&& mkdir -p github.com/idassvv
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux- x86_64.tar.gz \
| tar xvz -C /usr/local
USER idassvv
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/idassvv/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
