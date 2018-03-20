# txhiapi production rail images
#
# version:                 2.1

FROM oem

WORKDIR /home

COPY txolcrmapi/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh

CMD ["entrypoint.sh"]