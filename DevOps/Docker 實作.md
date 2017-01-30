# Docker Implementation
* [Docker Hub](https://hub.docker.com/)
* [Awesome-Docker](https://github.com/veggiemonk/awesome-docker)
## Common Usage
image -> container -> modified container -> commit -> new image

```shell
docker push # 上傳本地 image 到 Docker hub
docker pull # 從 Docker hub 抓 image 到本地
docker tag # 將標籤加到 image，入版本號、作者資訊, 通常用在 push 前的處理
docker login # 在終端機登入，通常在 push 前會做的事
docker images # 查看本地所有的 images
docker run # 從 image 建立一個 container.
# -i -t 讓我們在建立 container 同時開啟 interactive mode 進入容器
# -d 讓 container 運行在 detached mode (背景運作), 回傳 container ID
# -p 8888:8080 做網路 port mapping(-p [host:container]), 將容器的 8080 對應到 localhost:8888
# --name [name] 指定 container 建立時擁有自己的專屬名稱 (預設會亂取好笑的名字)
# exit 指令可以離開容器，同時關閉 container 的運作
# --rm 當離開 container 時自動移除而不保存容器
# 注意每次一個 run 都是建立全新的 container (不是原本修改過的那個), 離開時都會保存下來
docker run busybox:1.24 # 從 v1.24 版本的 busybox image 建立一個 container
docker start # 啟動 container
docker stop # 停止 container 運行
docker ps # 查看背景正在執行的 containers
# -a 列出全部的 containers
docker network # 查看網路介面
docker inspect # 查看 low-level 的 container info
# 以 JSON 秀出詳細資訊，包含硬體與網路設定、image ID 或是 Log in path
docker logs [container] # 查看容器的所有日誌資訊
docker history # 秀出所有的 image layers
docker commit # 保存 container 的檔案變更並建立新的 Image
# docker commit [container_ID] [Repo_Name:Tag]
# 範例： docker commit c8b82ee27706 jayz54780/hello-world:1.00
docker build # 從 Dockerfile 建立 image
# -t 指定 name 與 標籤(通常是版本號)
# -f 指定自製 Dockerfile 名稱，不指定使用預設叫做 Dockerfile
```

### FAQ

* Docker 吃掉所有空間?
  * macOS 影像檔和容器預設儲存在：
  ```shell
  ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2
  ```
