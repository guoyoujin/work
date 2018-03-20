# txcrm production rail images
#
# incloud: ruby2.2.5, rails4.2.5, mysql-devel, memcached
#          vim, which, tar, node4.5.0LTS, mysql, 
#
# version:                 1.1

FROM txcrm_base

WORKDIR /home

COPY txcrm/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD database.yml /home/config/database.yml
ADD init.sh /home/init.sh

RUN /home/init.sh

CMD ["entrypoint.sh"]