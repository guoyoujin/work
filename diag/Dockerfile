# txpatient production rail images
#
# incloud: ruby2.2.2, rails4.2.1 imagemagic nodejs6.* lts git 
#
# version:                 2.2

FROM txdiag

WORKDIR /home

RUN rm -rf /etc/pam.d/crond
ADD crond /etc/pam.d/crond

COPY txdiag/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh
CMD ["entrypoint.sh"]
