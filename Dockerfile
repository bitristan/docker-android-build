FROM ubuntu:14.04

# 更新阿里源
COPY source.list /etc/apt/source.list
RUN apt-get update

# 配置系统语言环境和时区
RUN apt-get install language-pack-zh-hant language-pack-zh-hans
RUN echo 'export LANG=zh_CN.UTF-8' >> /etc/profile
RUN echo 'export LANGUAGE=zh_CN:zh' >> /etc/profile
RUN source /etc/profile
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

# 添加64位系统对32位支持
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0

# 安装源码所需编译工具
RUN apt-get install gcc-multilib g++-multilib build-essential
RUN apt-get install libesd0-dev libsdl1.2-dev libwxgtk2.8-dev libswitch-perl 
RUN apt-get install libssl1.0.0 libssl-dev lib32readline-gplv2-dev libncurses5-dev

# 配置java环境（这里使用openjdk-7）
# 注：Android5.x - Android 6.0编译需要用jdk7，Android7.0及其以上需要用jdk8
RUN apt-get install openjdk-7-jdk
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64' >> /etc/profile
RUN echo 'export CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' >> /etc/profile
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile
RUN source /etc/profile

