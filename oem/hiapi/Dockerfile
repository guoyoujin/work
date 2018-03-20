# oem_hiapi production rail images
#
# version:                 1.2

FROM hiapi_base

WORKDIR /home

COPY txhiapi/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]