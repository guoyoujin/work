# oem_diagnose production rail images
#
# version:                 1.2

FROM diagnose_base

WORKDIR /home

COPY txdiagnose/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]