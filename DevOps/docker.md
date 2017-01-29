# Docker
website:

## Installation Guide

## Docker Hub

## Common Usage
image -> container -> modified container -> commit -> new image

```shell
docker push # 上傳本地 image 到 Docker hub
docker pull # 從 Docker hub 抓 image 到本地
docker tag # 將標籤加到 image，入版本號、作者資訊
docker run -it # 從 image 建立一個 container
docker start # 啟動 container
docker stop # 停止 container 運行
docker network # 查看網路介面
```

## Related Apps

* Kitematic

### FAQ

* Docker 吃掉所有空間?
  * macOS 影像檔和容器預設儲存在：
  ```shell
  ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2
  ```
