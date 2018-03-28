# txdiag production rail images
#
# incloud: ruby2.2.5, rails4.2.5 imagemagic nodejs6-lts git 
#
# version:                 3.0

FROM txdiag

WORKDIR /home

COPY txdiag/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]
