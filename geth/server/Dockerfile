FROM ubuntu 
MAINTAINER zhouwei <xiaomao361@163.com>

RUN apt-get update 
RUN apt -y install software-properties-common 
RUN add-apt-repository -y ppa:ethereum/ethereum 
RUN apt-get -y install tzdata
RUN apt-get update 
RUN apt install -y ethereum 
RUN rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV TZ="Asia/Shanghai"

ADD geth /home/geth
ADD entrypoint.sh /usr/bin/entrypoint.sh

EXPOSE 8545 30303

CMD ["entrypoint.sh"]
