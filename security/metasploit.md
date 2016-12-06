# Metasploit

啟動前必須先連上資料庫，可透過 ``ps -aux`` 來確認

```shell
$ service postgresql start
$ msfdb init
```

啟動 msf concole

```shell
$ msfconsole
```
在 msfconsole 中先確認是否成功連上資料庫
```shell
$ db_status
```

# Reference
* [Metasploit Fundamentals](https://www.offensive-security.com/metasploit-unleashed/using-databases/)

* [Metasploit for Beginners](MetaSploit tutorial for beginners)

* [msfconsole core command](https://www.offensive-security.com/metasploit-unleashed/msfconsole-commands/)
