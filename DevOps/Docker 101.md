# Introduction to Docker
A application-level virtualization technology.

## Get Started With Docker

1. Introduction to virtualization technologies
2. Docker's Client-Server Architecture
  > 主要三部分： Client, Docker_Host, Registry

  > 你不直接與後兩者接觸，而是使用 Clients 溝通

  * Clients
    * 一般的 CLI
    * Kitematic (GUI 介面)
  * Docker Host:
    * 別名
      * Docker Daemon
      * Docker Engine
      * Docker Server
    * 在一般的 Linux 中：
      * Docker Client, Daemon 與 Containers 運作在相同的作業系統之下 (Natively)
      * Docker Client 甚至可以連結遠端的 Docker Daemon
    * Mac OS 與 Windows:
      * Docker Client 與 其他(Daemon, Containers) 運作在不同作業系統
      * 由於 Daemon 需要 Linux 的 kernel作為支撐，因此透過輕量級的 Linux VM 建立 Docker 環境
      * Client 運作在 Host OS 中(Natively)，而 Daemon 與 Containers 運作在 Linux VM 之中
3. [Docker Installation Guides](https://docs.docker.com/engine/installation/)
4. Docker 中的基本觀念：
  * ``Image``
    1. Read-only templates
    2. Used to create containers
    3. Created with docker build command
    4. You, I and other users can build images
    5. Images 檔案非常大，透過網路傳輸比較麻煩；因此還可以透過不同的 images 組成另外一個 image
    6. DockerHub 上面的都是 Images
  * ``Container``
    1. 相當於 Image(就像 Class) 的 runtime instance 或 object
    2. 輕量、獨立的運行環境，透過需要的 dependencies 與 binaries 來部署 App
  * ``Registry``
    1. 存放 Image 之所在
    2. 可使用你自己(私有)的 Registry, 或是公開的 DockerHub
  * ``Repository``
    1. A collection of docker images
    1. 用來存放相同名稱但不同 tag 的 images
    2. 通常用來放置不同版本的 images
    3. 類似 Github 的概念，一樣有 Stars 數， 且有 Pull 數的統計

## Work with Docker Images

1. Image Layers:
  * 每一個 Image 為上一層 Image 所建立， 為 Image Stack
  * 每一個 Image Layer 分別代表不同的 File System 差異  
  * 最底下的 Image 稱為 Base Layer
  * Image 與 Container 最大的差異:
    * Image Stack 全部 Read-Only
    * Container 會在 Stack 最上層建立一 Writable Layer, 所有更動都會保存在這裡
    * 當你把 Container 刪除時， Writable Layer 就會消失不見，更動的檔案也會消失
    * 當你在 Container 狀態下 commit 建立新的 Image Layer 後， 檔案便會保存，新的 Stack 便會形成
  * 新的 Image Layer 都是透過 Container 狀態下建立堆疊
2. 建立 Docker Image:
  * 方法：
    1. Commit (在 container 狀態下 Commit )
    2. 自幹一個 Docker file
3. Docker file
  * 一個文字文件，包含所有的 ``instructions``
  * 這些指令就是讓 Docker Daemon 在 container 內執行的腳本
  * 每一行 Instruction 都會建立一個新的 Image Layer 並堆疊上去
  * 步驟：
    ```shell
      $ touch Dockerfile # 一定要大寫 D
      $ vi Dockerfile # 編輯 Dockerfile
      $ docker build -t jayz54780:1.00 . # build 一個 image
        # 預設會尋找 Dockerfile 這個名字的檔案, 使用 dot(.) 尋找當下目錄
        # -f [檔名] 指定 Dockerfile 名稱 (預設叫 Dockerfile)
        # -t 指定 name:tag

    ```
  * 注意：你也可以打包但檔案進去，但是要在相同目錄下（因為 Docker Daemon 可以在遠端）
  * Dockerfile Instructions 範例:

    ```
      FROM ubuntu:latest
      RUN apt-get update
      RUN apt-get install -y git
      RUN apt-get install -y vim
    ```

    注意：第一行必須為 ``FROM`` 指定 Base Image,下面都是建構出自己的 Image Layers
4. 良好的 Dockerfile 設計習慣：
  * Chain ``RUN`` Instructions:
    1. 每一個 ``RUN`` 指令都會搭建在一個 container 的 top writable layer 上面並且 commit 一個全新的 image layer
    2. 這個新的 layer 會供下一行 ``RUN`` 指令去使用，因此一個 ``RUN`` 就會產生一個 image layer
    3. 最佳建議是使用 Chain Instructions 去減少 Image Layer 的產生。
    4. 改寫上面的 Dockerfile 範例：

      ```
        FROM ubuntu:latest
        RUN apt-get update && apt-get install -y \
        git \
        vim
      ```

  * Sort multi-line Arguments __Alphanumerically__
    1. 當你需要安裝許多套件時，最好按照字幕排序，才不會搞亂
    2. 上述若要安裝 Python, 應放在:

      ```
        FROM ubuntu:latest
        RUN apt-get update && apt-get install -y \
        git \
        python \
        vim
      ```

  * Docker Cache
    1. 每一次執行 Dockerfile 都會比上一次快，因為 Docker Daemon 使用了 Cache
    2. Cache 是將你某一行指令所產生的 image layer 暫存起來，直到下次發現有相同的 instruction 便直接跳過使用舊的 layer
    3. Issues:
      * RUN apt-get update 所產生的 layer 被 Cache 重複使用，但是可能已經過期了(不是最新的)
      * 上述過程稱為 __Aggresive Caching__
    4. Fixes:
      * Chain Instructions: 使用 ``RUN apt-get update && apt-get install``
      * Specify ``--no-cache`` option:
        ```shell
          $ docker run -t jayz54780/debian . --no-cache=true
        ```
  * 其他好用的 Instructions:
    1. ``CMD``
        1. 這個是當別人從你建立的 image 檔案 run 出一個 container 時會最先執行的指令
        2. 如果你沒有在 Dockerfile 裡頭註明 CMD, 如此一來便會以 base image layer 為主
        3. 注意： CMD instruction 在 build image 不會執行，只有 run container 才會

          ```
            FROM ubuntu:latest
            RUN apt-get update && apt-get install -y \
            git \
            python \
            vim
            CMD ["echo", "hello world"]
          ```

          此例子 CMD 建立時會跳過，知道你 run 一個新的 container 時便會執行 (印出 hello world)。
    2. ``COPY``
      1. 在 build context 過程中將檔案或資料夾拷貝到 docker image 之中保存
      2. 範例：
        ```shell
          $ touch test.txt
          $ vim Dockerfile # 在 Dockerfile 新增 COPY 指令
          $ docker build -t jayz54780/deian .
        ```
        其中 Dockerfile 最後一行加上 ``COPY``:

        ```
          FROM ubuntu:latest
          RUN apt-get update && apt-get install -y \
          git \
          python \
          vim
          COPY test.txt /src/test.txt
        ```

    3.  ``ADD``
      1. 與 ``COPY `` 雷同，加上具有下列功能：
        * 擁有從網路上額外下載資料的能力
        * 擁有解壓縮檔案的能力
      2. 建議：盡量使用 ``COPY``, 除非你知道你的確需要使用 ``ADD``.

5. 上傳到 [DockerHub](https://hub.docker.com)
  * 關聯 Image 與自己的 dockerhub 帳號：
    1. 重新命名 image 檔案名稱
    2. 命名為 ``docker_hub_username_id / repo_name``
  * 範例與常用指令：

    ```shell
      $ docker images # 秀出所有的 images
      $ docker tag 491c0f07cfff jayz54780/debian:1.01 # 將 image_id 映像檔改為自訂的 tag
      $ docker login --username=jayz54780 # 上傳前做個登入
      $ docker push jayz54780/debian:1.01 # 將自訂映像檔上傳到自己的 DockerHub
    ```

  * 注意 tag:
    1. tag 標註版本號沒有嚴格規定
    2. 若你將版本號設為 __latest__，以後的版本號在 ``docker pull`` 時都會拉不到
    3. 盡量避免使用 __latest__ 作為你的版本號，除非你知道你在幹嘛。


## Create Dockerized Web Applications

1. ``Links``
  * Docker Container Links 讓容器之間可以直接溝通，無須暴露 ip 給 Host OS
  * 在 Host 底下有兩個角色：
    1. Source: 資料庫，如 Redis 或 MongoDB
    2. Recipient: 接收資料者，如 docker app
  * 使用方式：
    1. 建立 __Redis__ container:

      ```shell
      $ docker run -d --name redis redis:3.2.0 # 從 redis 這個 base image 啟動 container
      $ docker ps # 查看執行中的容器：
      ```

      ```
      CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
      7ba3887ab858        redis:3.2.0         "docker-entrypoint..."   18 seconds ago      Up 16 seconds       6379/tcp            redis
      ```

      你可以使用 `` docker inspect `` 查看單一 container 的所有資訊。
    2. 建立 __dockerapp__ container:

    ```shell
    $ docker run -d -p 5000:5000 --link redis dockerapp:v0.2
    ```

    其中 ``--link`` 將 dpckerapp 與 redis 連結在一起，讓他們彼此看得到對方，你只需要將 docker app 的 ip 對應到 localhost.
    查看啟動中的容器： ``docker ps``

    ```
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
    35201b7c8347        dockerapp:v0.2      "python app.py"          2 seconds ago       Up 2 seconds        0.0.0.0:5000->5000/tcp   nifty_varahamihira
    7ba3887ab858        redis:3.2.0         "docker-entrypoint..."   3 minutes ago       Up 3 minutes        6379/tcp                 redis
    ```

  * Link 如何運作？
    1. 進入 docker app:

    ```shell
    $ docker exec -it 35201b7c8347 bash
    ```

    進入 dockerapp 容器後，在 ``/etc/hosts`` 中查看所有與本機對應的 host name 與 ip address 的 DNS 表：

    ```shell
    $ more /etc/hosts # 秀出 Host Database

      127.0.0.1	localhost
      ::1	localhost ip6-localhost ip6-loopback
      fe00::0	ip6-localnet
      ff00::0	ip6-mcastprefix
      ff02::1	ip6-allnodes
      ff02::2	ip6-allrouters
      172.17.0.2	redis 7ba3887ab858
      172.17.0.3	35201b7c8347
    ```

    可以發現在 dockerapp 中已登記 ``redis`` 並且 ip 位址為 ``172.17.0.2``. 可以使用 ``ping`` 驗證：

    ```shell
    ping 172.17.0.2
    PING 172.17.0.2 (172.17.0.2): 56 data bytes
    64 bytes from 172.17.0.2: icmp_seq=0 ttl=64 time=0.161 ms
    64 bytes from 172.17.0.2: icmp_seq=1 ttl=64 time=0.165 ms
    64 bytes from 172.17.0.2: icmp_seq=2 ttl=64 time=0.152 ms
    ^C--- 172.17.0.2 ping statistics ---
    3 packets transmitted, 3 packets received, 0% packet loss
    round-trip min/avg/max/stddev = 0.152/0.159/0.165/0.000 ms
    ```
