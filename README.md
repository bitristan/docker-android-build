# 使用docker编译aosp源码
google官方推荐的安卓编译源码为14.04，由于目前的工作环境为macosx环境或者高版本的ubuntu环境，直接在本机编译会有很多问题，不过借助docker这个强大的工具可解决这个烦恼

## 安装docker
google搜索安装方法即可

## docker更换国内镜像源
为了加速docker镜像的拉取，可以设置国内镜像源，例如设置成网易的镜像源方法如下：
* 创建 _/etc/docker_ 目录
```bash
sudo mkdir -p /etc/docker
```
* 在 _/etc/docker_ 目录下创建 _daemon.json_ 文件，写入以下内容
```
{
    "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
```
* 重启docker服务
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## 创建编译镜像
由于aosp源码推荐在ubuntu 14.04版本上编译，所以我们基于14.04来创建镜像。这里准备使用5.1.1版本的源码，所以需要安装jdk7。

构建镜像的细节详见 [Dockerfile](https://github.com/Tinker-S/docker-android-build/blob/master/Dockerfile)。

使用如下命令创建镜像
```bash
docker build -t aosp-build:1.0.0 .
```

查看创建成功的镜像
![images](https://github.com/Tinker-S/docker-android-build/blob/master/pictures/1.png)

## 使用镜像编译源码
1. 下载aosp源码
    推荐去清华镜像站下载[打包好的源码](https://mirrors.tuna.tsinghua.edu.cn/aosp-monthly/)即可，也可以使用repo下载指定版本，具体详见[网站文档](https://mirrors.tuna.tsinghua.edu.cn/help/AOSP/)
2. 假设aosp源码下载路径为 /home/user/aosp，使用aosp-build镜像创建容器，并挂载aosp源码路径
```bash
docker run -itd --name aosp-build -v /home/user/aosp:/home/aosp aosp-build:1.0.0
docker exec -it aosp-build /bin/bash
```
3. 进入 _/home/rom_ 目录，直接编译源码即可
```bash
. build/envsetup.sh
lunch
make -j8
```



