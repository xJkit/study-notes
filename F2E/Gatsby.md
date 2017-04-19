# Gatsby 筆記

[Gatsby](https://github.com/gatsbyjs/gatsby) 是一個靜態網頁生成工具，使用 ``React`` + ``Webpack`` 實作，讓使用者可以透過 ``markdown``, ``html`` 或是 ``jsx`` 語法來撰寫部落格或客制畫面（想當然爾， CSS!）。

Gatsby 所產生的專案架構如下：
* ``config.toml`` - gatsby 的 全域設定檔, 可以透過 ``imort`` 或 ``require`` 'config'
  - ``noProductionJavascript`` - 不產出 ``bundle.js``
* ``html.js`` - 整個網站的 root component
* ``/pages`` - 所有的頁面放在這裡都會被轉成 html, 除了底線開始的檔案名稱
  * ``_template`` - 在 ``/pages`` 底下，同一個資料夾層級並以底線開頭的都是其他頁面的樣板
  * 404: 使用檔名 ``404.js`` 或 ``404.html`` 當作找不到該路徑下的錯誤頁面

--- 以下為 optionals

* ``gatsby-browser.js`` - 去 hook 核心 application events
  * onRouteUpdate
  * modifyRoutes
  * shouldUpdateScroll
  * wrapRootComponent
* ``gatsby-node.js`` - 去 hook events (during build, development)
* ``gatsby-ssr.js`` - 去 hook events (during server-side rendering)

---

### [樣版引擎](https://github.com/gatsbyjs/gatsby#frontmatter-and-metadata)
樣板引擎可以使用 ``markdown``, ``html`` 或 ``.js(x)`` 四種。 Gatsby 使用 [front-formatter](https://github.com/jxson/front-matter) 抓取表頭檔並 render 到 React Component 裡面。三種格式寫法如下：

1. Markdown:
  ```md
    ---
    title: This is the title of 
    ---
  ```

### [使用自定義的 Webpack loaders](https://github.com/gatsbyjs/gatsby#how-to-use-your-own-webpack-loaders)

### [使用自定義的 Webpack plugins](https://github.com/gatsbyjs/gatsby#how-to-use-your-own-webpack-plugins)

### [使用自定義 CSS](https://github.com/gatsbyjs/gatsby#inline-css)

Gatsby 基於效能考量，選擇最優雅的 inline-css 直接嵌入 head （在 ``html.js`` 裡面）。對於我們的其它頁面，建議的方式為 ``CSS Modules``

* 新增任意 xxx 檔案名稱，副檔名為 xxx``.module.(css|sass|scss)``
* 在 ``xxx.js`` 中匯入：
  ```js
    import './xxx.module.css'
  ```

### [使用自定義 Babel loaders](https://github.com/gatsbyjs/gatsby#configuring-babel)

Gatsby 原生有自己加裝了一些 Babel loader, 如果覺得不夠或有其他特殊需求，可參考。

### 延伸 Markdown 語法

原生 Gatsby 僅支援基本 md 語法，其原理透過 [markdown-it](https://github.com/markdown-it/markdown-it)。若要新增語法功能（如數學公式），參考 [markdown-it-plugin](https://www.npmjs.com/browse/keyword/markdown-it-plugin)

### [網站部署](https://github.com/gatsbyjs/gatsby#deploying-to-github-pages-and-other-hosts-where-your-sites-links-need-prefixes)

### FAQ

* 無法安裝 Gatsby --> 需要先安裝 python V2
* 新增頁面沒有顯示 --> Webpack hot reload 不支援檔案新增，必須重新啟動
* 路由前後必須有 slash
  * Bad: ``http://localhost:8000/foo``
  * Good: ``http://localhost:8000/foo/``
