# oem_hims production rail images
#
# version:                 1.2

FROM hims_base

WORKDIR /home

COPY txhims/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]