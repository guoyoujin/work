# oem production rail images
#
# version:                 1.1

FROM oem_images_base
MAINTAINER zhouwei<zhouw@tongxinyiliao.com>

WORKDIR /home

COPY project/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]
