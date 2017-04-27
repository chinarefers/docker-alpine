FROM alpine:3.5
# Dockername  wangxiaolei/alpine:3.5
# 1.替换清华大学源
# 2.安装OpenJDK并设置系统变量
# 3.安装bash
# 4.默认UTF-8
# 4.Dockerfile使用方法： docker build -t wangxiaolei/alpine:3.5 .
# 5.镜像使用方法：docker run -it --rm wangxiaolei/alpine:3.5 bash 

ENV LANG C.UTF-8

MAINTAINER wangxiaolei(王小雷) “http://blog.csdn.net/dream_an https://github.com/wxiaolei”
ARG GPG_KEY=40935508C4A60BFA228526FB38C14CBE28E97588

RUN echo  "https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.5/community/"  > /etc/apk/repositories
RUN echo  "https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.5/main/"  >> /etc/apk/repositories

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u121
ENV JAVA_ALPINE_VERSION 8.121.13-r0

RUN set -x \
	&& apk add --no-cache \
						bash \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

