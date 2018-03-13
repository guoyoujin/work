# txcrm production rail images
#
# incloud: ruby2.2.2, rails4.2.1 imagemagic nodejs6.* lts git 
#
# version:                 2.1

FROM txpatient
MAINTAINER zhouwei<zhouw@tongxinyiliao.com>

WORKDIR /home

COPY txpatient/ /home
ADD enterpoint.sh /usr/bin/enterpoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["enterpoint.sh"]
