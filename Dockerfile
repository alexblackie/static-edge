FROM opensuse/leap:15.2

RUN zypper up && zypper in -y nginx && zypper clean

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
