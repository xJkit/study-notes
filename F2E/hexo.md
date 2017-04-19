# Hexo notes

Hexo 是一個快速、簡單且強大的網誌框架。Hexo 使用 Markdown（或其他渲染引擎）解析您的文章，並在幾秒鐘內，透過漂亮的主題產生靜態檔案。

* [Hexo 官方文件](https://hexo.io/zh-tw/docs/)

1. 快速安裝：
  ```sh
    npm i -g hexo-cli
    hexo init blog
    cd blog
    npm i
    hexo server #  Hexo is running at http://localhost:4000/.
  ```
基本需求：
  * node.js
  * git
  * (Mac User) 需要安裝 XCode > Preference > Download > Command line tools > Install

2. 專案架構：
  * [_config.yml](https://hexo.io/zh-tw/docs/configuration.html) - 網站配置
  * package.json - 應用程式資料，已預先安裝：
    * EJS
    * Stylus
    * Markdown
  * [scaffolds](https://hexo.io/zh-tw/docs/writing.html#鷹架（Scaffold）) - 當您建立新文章時，Hexo 會根據 scaffold 來建立檔案
  * [scripts](https://hexo.io/zh-tw/docs/plugins.html#腳本（Scripts）) - 放在這裡的 JS 會被自動執行，供你擴充
  * source - 放置原始檔案，開頭 ``_``(底線) 以及 ``.``(隱藏) 會被忽略。除了預設 ``_posts`` 資料夾， md 與 html 會預處理並轉到 ``public``, 其他檔案會直接 copy 過去。
    *_draft
    *_posts
  * [themes](https://hexo.io/zh-tw/docs/themes.html) - 放置主題的資料夾