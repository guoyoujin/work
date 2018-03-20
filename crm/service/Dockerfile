# txhiapi production rail images
#
# version:                 2.1

FROM txservice_base

WORKDIR /home

COPY txservice/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh

CMD ["entrypoint.sh"]