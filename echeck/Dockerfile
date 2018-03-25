# txpatient production rail images
#
# incloud: ruby2.2.2, rails4.2.1 imagemagic nodejs6.* lts git 
#
# version:                 2.2

FROM txpatient

WORKDIR /home

COPY txpatient/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]
