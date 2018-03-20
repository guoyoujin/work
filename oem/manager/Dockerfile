# oem_manager production rail images
#
# version:                 1.2

FROM manager_base

WORKDIR /home

COPY txmanager/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]