FROM ruby2.2.5-rails4.2.5

WORKDIR /home

RUN yum install -y git wget which vim
RUN rm -rf /etc/pam.d/crond
ADD crond /etc/pam.d/crond

COPY txdiag/ /home
ADD init.sh /home/init.sh

RUN /home/init.sh
RUN rm -rf /home/*