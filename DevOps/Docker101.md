# Introduction to Docker
1. Get started with docker

### Get Started With Docker
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
