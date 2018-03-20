# oem_meeting production rail images
#
# version:                 1.2

FROM meeting_base

WORKDIR /home

COPY txmeeting/ /home
ADD database.yml /home/config/database.yml
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]
