# txpay production rail images
#
# version:                 1.1

FROM txpay_base

WORKDIR /home

COPY txpay/ /home
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD init.sh /home/init.sh

RUN /home/init.sh

CMD ["entrypoint.sh"]