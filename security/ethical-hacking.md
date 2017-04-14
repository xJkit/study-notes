# Ethical Hacking 101

## Preparation

  * Virtual Machine Hypervisor (VMWare/Virtual Box)
  * Kali Linux
  * Windows 10
  * Metasploitable

## Network Pentesting
網路攻擊發生的四種情形：
  * Pre-Connection
    * 攻擊發生在連上網路之前
    * 通常是透過 Wi-Fi 連線時先動手腳
  * Gainning Access
    * Break Wi-Fi keys(WEP/WPA/WPA2)
  * Post-Connection
    * 攻擊發生在連上網路之後
    * cookies, sessions, ...
  * Detection & Security

### Network Basics
  * ``Router``: 所有連上網路的裝置都沒有 '直接' 接觸 Internet, 都是 '間接'的：透過 ``Router``。
    * 因此，只要 Router 掛點，所有的裝置都無法上網。
    * Router 被感染，上網裝置的資料就容易取得。
  * ``MAC`` 位址：
    * 所有網路介面卡都有製造商賦予的 MAC 位址，用來判斷不同裝置以讓封包傳遞順利進行。
    * 每一個封包(packet) 都有 ``source MAC`` 以及 ``destination MAC`` 位址。
    * 操作方法：
      ```sh
        > iwconfig # Linux 無線網路設定工具, 僅使用 Kali 連接無限介面卡時存在
        > ifconfig # Linux 網路介面卡設定工具
        > ifconfig [interface] [up|down] 啟動或停用介面
        > macchanger --random [interface] # 使用 mac changer 工具隨機改變介面 MAC 位址
      ```
  * 無線網路模式：
    * MAC 位址用於判定封包的正確留流向，但是區域網路中其實每個人都接受得到所有不同 MAC 的封包。
    * 無線網路模式：
      * ``Managed``: 只接受傳給與自己 MAC 相同位址的封包
      * ``Monitor``: 接受所有接收到的封包(此模式將失去正常連線上網能力)
    * 使用用具： ``airmon-ng``


## Gaining Access

## Post Exploitation

  * Gathering Information
    * 使用工具： ``netdiscover``
      ```sh
        > apt-get install netdiscover
      ```
      * 可以發現同網段的連線裝置、 ip 與 MAC 位址
    * 使用工具： ``autoscan``
      * GUI 工具：[AutoScan](http://autoscan-network.com/)
    * 使用工具： ``Nmap`` or ``Zenmap``

## Web Application Pentesting

## Security & Mitigation

