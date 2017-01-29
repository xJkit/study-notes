# Introduction To Virtualization

1. Pre-virtualization world:
  * 花大量金錢購買大量實體主機
  * 一台主機只跑一個應用程式
2. Hypervisor-based Virtualization:
  * 一個 Host OS 透過 Hypervisor 管理不同的 Guest OS 作業系統
  * 常見的 Hypervisor Provider:
    * VMWare, Virtual Box (部署在本機)
    * AWS (Amazon), Azure (Microsoft) (部署在雲端主機)
  * 限制：
    * Kernel Resource Duplication (每個 Guest OS 都有自己的記憶體管理方式、驅動程式以及 Daemons)
    * Application Portability Issues (應用程式部署在不同的 Hypervisor 底下有些 bugs)
3. Container-based Virtualization:
  * 沒有 Guest OS, 就只有一個 OS(Host), 透過 Container Engine 包覆不同的 Containers
  * 共享一個 OS Kernel, 藉由不同的 Containers 運作各自的 runtime 環境(App, lib, bin, ...)
  * Runtime Isolation
    * 讓你同時運作不同版本的 Java (JRE 7, JRE 8) 在相同的作業系統上面成為可能，使用 Containers
  * 優點：
    * Cost Efficient
    * Fast Deployment
    * Guaranteed Portability
