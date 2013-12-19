#
# Weechat configuration
#
# docker run -i -t -p 0.0.0.0:8000:8000 -p 0.0.0.0:8001:8001 creack/weechat
#
FROM		ubuntu:12.10
MAINTAINER	Guillaume J. Charmes <guillaume@charmes.net>

# Install add-apt-repository
RUN		apt-get -qq install -y software-properties-common
# Add nodejs ppa
RUN		add-apt-repository ppa:nesthib/weechat-stable
#RUN		add-apt-repository ppa:nesthib/weechat
RUN		apt-get -qq update

RUN		apt-get install -y weechat perl

RUN		adduser creack
USER		creack
RUN		mkdir -p /home/creack/.weechat/perl/autoload && chown -R creack:creack /home/creack
ENV		HOME  /home/creack

# Support UTF8
ENV		LANG	C.UTF-8
ENV		TERM	screen-256color

ENTRYPOINT	weechat-curses

EXPOSE		8000
EXPOSE		8001

RUN		ln -s /home/creack/.weechat/perl/buffers.pl /home/creack/.weechat/perl/autoload/buffers.pl
ADD		irc.conf /home/creack/.weechat/
ADD		weechat.conf /home/creack/.weechat/
ADD		relay.conf /home/creack/.weechat/
ADD		buffers.pl /home/creack/.weechat/perl/

# FIXME: Add a chan monitor Limechat style
