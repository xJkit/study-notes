# J's Study Notes
> 個人學習 JavaScript 的心路歷程，以此紀念。

> If you stranger finds something incorrect, a pull request is much appreciated.

> If you stranger has better ideas or tools, just open an issue to speak out loudly; welcome.

---

在驟變的前端世界，不做個筆記留下工程師的青春，就會跟夢一樣輕易流逝。JavaScript 真的是像在演肥皂劇，從以前跑龍套的語言變成今日能挑大樑的勇士，如此動人的情節跟川普在不被看好的亂世中獲勝是一樣的驚天地泣鬼神？

Given synopsis below. Please check more detail on the ``Project Demo``.

# Front End
### React officials
* [react](https://github.com/facebook/react)
* [react-router](https://github.com/ReactTraining/react-router)
* [react-native](https://github.com/facebook/react-native#getting-started)
  > A framework for building native apps with React.

  > 用 React 來寫 iOS 與 Android App.

  > Learn once, write anywhere.

  * [react-native-windows](https://github.com/ReactWindows/react-native-windows)

    > react-native plugin for UWP(Universal Windows Platform)

  * [react-native-macOS](https://github.com/ptmt/react-native-macos)

    > Build macOS desktop apps using React Native and Cocoa.

* [React Developer Tools](https://github.com/facebook/react-devtools)

  > An extension that allows inspection of React component hierarchy in Chrome Developer Tools


### Redux
* [redux](https://github.com/reactjs/redux)

  > Predictable state container for JavaScript apps

* [react-redux](https://github.com/reactjs/react-redux)

  > Official React bindings for Redux

* [react-router-redux](https://github.com/reactjs/react-router-redux)

  > Bindings for react-router and redux

  > 讓 react-router 與 redux store 同步

* [redux devtools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en)

  > Chrome extension for redux app

  > Excellent GUI tool for checking the state in the store of a react app with redux

* [react-chrome-redux](https://github.com/tshaddix/react-chrome-redux)

  > 用 react + redux 寫 Chrome Extensions

* [remote-redux-devtools-on-debugger](https://github.com/jhen0409/remote-redux-devtools-on-debugger/)

    > Redux DevTools 的延伸，用於 React-Native

    > 在 ``npm postinstall`` 之中把 react native 原生的 debugger 換掉

#### Redux Middleware for Async Action Side Effects  

* [redux-thunk](https://github.com/gaearon/redux-thunk) - :star: __3.9K__

  > Redux 原作者所開發，讓 action creators 回傳不只是 action 物件，而是 thunk 函數

  > 使用 thunk middleware for redux，處理 async 的另一種方式

  > 注意： action creator 標準是必須回傳 plain object, 但是使用 thunk middleware 後才允許回傳 function (--> thunk function)

  > redux-thunk 搭配 ES7 ``async/await`` 會非常強大。  ...[範例在此](https://pastebin.com/R4sQK96K)

* [redux-promise](https://github.com/acdlite/redux-promise) - :star: __1.2K__

  > 讓 Action Creators 回傳 Promise

  > 發者也是 React 官方成員之一，但是很久沒更新了...


* [redux-promise-middleware](https://github.com/pburtchaell/redux-promise-middleware) - :star: __0.6K__

  > Redux middleware for resolving and rejecting promises with conditional optimistic updates

  > 作者也是 FB 開發者之一

* [redux-api-middleware](https://github.com/agraboso/redux-api-middleware) - :star: __0.8K__

  > 將整個 SPA 的非同步請求行為集中在 api middleware 共用

  > 透過 Symbol 所產生的 [CALL_API] 來判定是否為非同步 actions

  > 作用： __Redux Standard API-calling Actions__ (RSAAs) ---> __Flux Standard Actions__ (FSAs) -->  next middleware

  > 這個一直都是自幹 api middleware 的方式

* [redux-observable](https://github.com/redux-observable/redux-observable) - :star: __~2K__

  > [官方文檔](https://redux-observable.js.org/) 

  > 以 [RxJS](http://reactivex.io/) 為基礎來開發的 Middleware

  > 精神： RxJS + Redux + React = Amazing

  > 開發者為 RxJS 之一，也是 Netflix 工程師

  > 觀看 [基礎範例](http://jsbin.com/jexomi/edit?js,output)

* [redux-saga](https://github.com/redux-saga/redux-saga) - :star: __~6K__

  > 使用 ES6 generators 讓非同步請求統一放在 saga 中使得更加容易處理與測試

  > 現今最流行處理 async 的方式，但是需要 generators 的知識！

* [Why do we need middleware for async flow in Redux?](http://stackoverflow.com/questions/34570758/why-do-we-need-middleware-for-async-flow-in-redux/34623840#34623840)
  > 非同步網路請求到底是放在 middleware? 還是放在 action creator 裡面？作者在 StackOverflow 有非常好的說明(包含是否適用 redux-thunk 或 redux-saga，有兩者比較的討論串)

  > Action Creator 需要是 "pure function" 嗎？ 作者回答： Redux 官方文件以前說是，但是錯了！他並非一定 pure.

* [RxJS](http://reactivex.io/)

  > Reactive Programming 其實並非 Redux 而是將所有資料流都轉換成 Stream Events

  > ReactiveX is a library for composing asynchronous and event-based programs by using observable sequences.

  > ReactiveX is a combination of the best ideas from the Observer pattern, the Iterator pattern, and functional programming.

* 補充：在 Redux 的 Action 物件的普遍格式
  * [FSA: Flux Standard Action](https://github.com/acdlite/flux-standard-action)
  * [RSAA: Redux Standard Api-calling Action](https://github.com/agraboso/redux-api-middleware#redux-standard-api-calling-actions)


### React-related Libraries

* [ant-design](https://github.com/ant-design/ant-design/)

  > An enterprise-class UI design language and React-based implementation.

  > [Official Site](https://ant.design/)

* [Material-UI](https://github.com/callemall/material-ui)

  > React Components that Implement Google's Material Design

* [react-paginate](https://github.com/AdeleD/react-paginate)

  > demo: https://github.com/AdeleD/react-paginate/blob/master/docs/img/react-paginate.gif

* [react-component/pagination](https://github.com/react-component/pagination)

  > example & docs: http://react-component.github.io/pagination/

* [react-component/slider](https://github.com/react-component/slider)

  > example & docs: http://react-component.github.io/slider/

* [rodal](https://github.com/chenjiahan/rodal)

  > A React modal with animations.
  > * __[project demo](https://github.com/xJkit/react-modal-example)__

* [react-select](https://github.com/JedWatson/react-select)

  > A Select control build with and for React JS

* [react-scroll](https://github.com/fisshy/react-scroll)

  > Directive for basic scrolling and smooth scrolling

* [react-mosaic](https://github.com/palantir/react-mosaic)

  > A React tiling window manager. >> [demo](https://palantir.github.io/react-mosaic/
)

  > 適合做監視器的管理介面視窗，包含拖曳、放大、縮小、排序等功能。

* [classNames](https://github.com/JedWatson/classnames)

  > A simple javascript utility for conditionally joining classNames together

  > 可以把判斷邏輯、Inline CSS 寫在 Component 裡面的函式庫

* [Draft.js](https://facebook.github.io/draft-js/)

  > A framework for building rich text editors in React.

  > 適合拿來當管理介面的寫作 UI 編輯器

* [react-css-modules](https://github.com/gajus/react-css-modules)

  > Seamless mapping of class names to CSS modules inside of React components

  > 寫出 Modular 與 Reusable CSS!

  * 設計哲學來自 [CSS Modules](https://github.com/css-modules/css-modules)，其為一種 __paradigm__

    > 搭配 webpack, css-loader, style-loder. 也可使用 stylus 強化原生 CSS (搭配 stylus-loader)

  * 由於 ``react-css-modules`` 會拖垮效能，另一個輕量級的 alternatives 為使用 [babel-plugin-react-css-modules](https://github.com/gajus/babel-plugin-react-css-modules)

* [PostCSS](https://github.com/postcss/postcss)

  > Transforming styles with JS plugins

  * [autoprefixer](https://github.com/postcss/autoprefixer)

  * [rucksack](https://simplaio.github.io/rucksack/)

   > A little bag of CSS superpowers

### Modern F2E Essential Tools

* [Webpack](https://github.com/webpack/webpack)
  > 前端必備打包工具

  > 延伸閱讀：

    * [知乎－Webpack 配置說明](https://zhuanlan.zhihu.com/p/21346555?refer=jscss)
    * [手把手深入理解 webpack dev middleware 原理與相關 plugins](https://segmentfault.com/a/1190000005614604)
    * [译 Webpack——令人困惑的地方](https://segmentfault.com/a/1190000005089993?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)

* [Babel](https://github.com/babel/babel)
  > Transpiler for JavaScript, and more.

  > 原本只是讓你寫 ES6+ 的轉轉譯工具，但是發展至今已經更強大了...

* [Lodash](https://github.com/lodash/lodash)

  > A modern JavaScript utility library delivering modularity, performance, & extras

  > 非常好用之 Functional Programming 的 JS 輔助工具

* [Sketch](https://www.sketchapp.com/)
  > Professional digital design for Mac

  > 用來做 UI/UX 的 handy tool!

  > Mac only...

* [Flow](https://github.com/facebook/flow)

  > static type checker for JavaScript

* [language-babel](https://github.com/gandm/language-babel)

  > language grammar 超級好用工具 for ATOM

  > 搭配 React, JSX, Babel, ES6, graphQL...

* [Emmet](https://github.com/emmetio/emmet)

  > The essential toolkit for web-developers

* [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en)

  > RESTful API 快速驗證工具

* [ESLint](https://github.com/eslint/eslint)

  > A fully pluggable tool for identifying and reporting on patterns in JavaScript

* [merge conflict](https://github.com/smashwilson/merge-conflicts)

  > Resolve git merge conflicts in Atom

  > 直接在 Atom 的 UI 介面上解決衝突！牛逼！

* [RegexHub](https://projects.lukehaas.me/regexhub/)

  > A collection of useful regex patterns

  > 快速驗證你的 Regular Expressions 好用工具

* [nodemon](https://github.com/remy/nodemon)

  > Monitor for any changes in your node.js application and automatically restart the server

  > Perfect for the development


### HTTP Request Libraries
* [axios](https://github.com/mzabriskie/axios)
  * Promise based HTTP client for the browser and node.js

* [isomorphic-fetch](https://github.com/matthew-andrews/isomorphic-fetch)
  * Isomorphic WHATWG Fetch API, for Node & Browserify
  * 這個讓 fetch 變成 global, 你也可以在瀏覽器中使用 fetch()
  * 這個也是 Promise-based, 但是需要 polyfilles: [es6-promise](https://github.com/stefanpenner/es6-promise)
  * 欲使用 query string, 可搭配 [URLSearchParams](https://developer.mozilla.org/zh-TW/docs/Web/API/URLSearchParams)

* [SuperAgent](https://github.com/visionmedia/superagent)
  * Ajax with less suck - (and node.js HTTP client to match) 

* [Request](https://github.com/request/request)
  * Simplified HTTP request client.

P.S: Web crawler/scraper = ``上述請求工具(node.js) + cheerIO``

### Animations

* [SVG.js](https://github.com/svgdotjs/svg.js)
  * The lightweight library for manipulating and animating SVG

* [Vivus](https://github.com/maxwellito/vivus)
  * JavaScript library to make drawing animation on SVG

* [Fabric](https://github.com/kangax/fabric.js/)
  * Javascript Canvas Library, SVG-to-Canvas (& canvas-to-SVG) Parser 
  * Powerful, simple JS HTML5 canvas library

### Browser Automation

* [PhantomJS](https://github.com/ariya/phantomjs)
  * Scriptable Headless WebKit
  * 用 WebKit（Safari, Chrome） 自動化
  * 一個沒有 UI 的瀏覽器！適合拿來做以下事情：
    1. Headless Web Testing (very fast testing without browsers)
    2. Page Automation (access & manipulate web pages)
    3. Screen Capture (programmatically capture web contents)
    4. Network Monitoring (automate performance analysis, track page loading)

* [SlimerJS](https://github.com/laurentj/slimerjs)
  * 建立在 Firefox 上做自動化

* [CasperJS](https://github.com/casperjs/casperjs)
  * 包裝 SlimerJS + PhantomJS 的自動化整合工具

* [Webdriver](https://github.com/webdriverio/webdriverio/)
  * Browser Automation Tools
  * Webdriver/Selenium JavaScript bindings for Node.js

* [cheerio](https://github.com/cheeriojs/cheerio)
  * Fast, flexible, and lean implementation of core jQuery designed specifically for the server

* 延伸閱讀：
  * [瀏覽器跨領域4種方法：cors/jsonp/proxy/fetch 與fetch api 最佳實踐](https://segmentfault.com/a/1190000006095018)
  * 更多的 Web Crawling / Scraping 的方式請參見： [Awesome Web Scraping](https://github.com/lorien/awesome-web-scraping)

### Unit Testing

> Testing tasks are related to the client-side libraries, please also check them for more information.

> Todos

  * [Mocha]()
  * [Chai]()
  * [Expect]()
  * [Enzyme]()
  * [Jest]()
  * [Karma]()


### Static Site Generators

* [jekyll](https://github.com/jekyll/jekyll) :star: ~30K

  > 用 Ruby 實作的工具

  > 想像是一個非常簡單的， file-based CMS

* [hexo](https://github.com/hexojs/hexo) :star: ~15K

  > 用 node.js 實作的靜態網生成器，作者是台灣人

  > A fast, simple & powerful blog framework, powered by Node.js.

* [Gatsby](https://github.com/gatsbyjs/gatsby) :star: ~9K

  >也是用 node.js 實作，但是是 React + Webpack 超有噱頭。

### Miscellaneous
* [normalizr](https://github.com/paularmstrong/normalizr)

  > Normalizes nested JSON according to a schema

  > * __[project demo](https://github.com/xJkit/normalizr-example)__

* [ELECTRON](https://github.com/electron/electron)

  > 用 JS 寫 Desktop App 太狂了！

  > Desktop Apps [應用在此](http://electron.atom.io/apps/)

* [Three](https://github.com/mrdoob/three.js/)

  > JavaScript 3D library

  > The library provides &lt;canvas&gt;, &lt;svg&gt;, CSS3D and WebGL renderers

* [A-Frame](https://aframe.io/docs/0.5.0/introduction/)

  > Mozilla 基於 Three.js 實作的框架

  > 用於 Web VR

* [Format.js](https://formatjs.io/)

  > Internationalize your web apps on the client & server

  > 多國語系不僅只有文字，更包含量詞、時間與日期等等

  > 相關開源項目：[React-intl](https://github.com/yahoo/react-intl) YAHOO! 開源的 React 組件

  > 參考文獻：[在 React 项目中使用 React-intl 实现多语言支持](https://segmentfault.com/a/1190000005824920)


### References & Articles
* [Awesome React](https://github.com/enaqx/awesome-react)
* [State-of-the-Art JavaScript 2016](https://medium.com/javascript-and-opinions/state-of-the-art-javascript-in-2016-ab67fc68eb0b#.kj8081e20)
* [Front End Top 100](https://www.awesomes.cn/rank?sort=trend)

  > 值得做的很多功課...

---

# Back End

Full Stack JavaScript, thanks to [Node.js](https://nodejs.org/en/).

### Web Service

* [Express](https://github.com/expressjs/express)

  > Fast, unopinionated, minimalist web framework for node.

  > 超古老經典 Node 框架

* [Koa](https://github.com/koajs/koa)

  > 使用 generator 操作的 http framework

* [POD](https://github.com/yyx990803/pod)

  > git push deploy for Node.js

* [PM2](https://github.com/Unitech/pm2)

  > production process manager for Node.js applications with a built-in load balancer

* [SocketIO](https://github.com/socketio/socket.io)

  > Realtime application framework

* [Socket.io-client](https://github.com/socketio/socket.io-client)

	> Realtime application framework (client)

### Database

``RDBMS``

  * [MySQL](https://www.mysql.com/)

  * [MariaDB](https://github.com/MariaDB/server)

    > Originally forked from MySQL with the same team developers.

  * [Posgresql](https://github.com/postgres/postgres)

  * [CouchDB](https://github.com/apache/couchdb)

``NoSQL``

  * NoSQL 主要有四大類：
    1. Key-value, 如 __Redis__
    2. Document-oriented, 如 __mongoDB__
    3. Wide Column Store, 如 __Cassandra__
    4. Graph-oriented, 如 __Neo4J__

  * [Redis](https://github.com/antirez/redis) :star: __21.5k__

    > key-value model, in-memory data structure server

  * [MongoDB](https://github.com/mongodb/mongo) :star: __10.7k__

    > extremely famous document-oriented NoSQL database

  * [Cassandra](https://github.com/apache/cassandra) :star: __3.2k__

    > 最初由 Facebook 開發，用於儲存收件箱等簡單格式資料，集Google BigTable的資料模型與 Amazon Dynamo 的完全分散式架構

    > 使用 Java 開發

  * [Neo4j](https://github.com/neo4j/neo4j) :star: __3.4k__

    > Graph Database

    > 使用 Java 開發

  * [RocksDB](https://github.com/facebook/rocksdb)

    > persistent key-value store for fast storage

    > Facebook 所開發

``Others``

  * [GraphQL](http://graphql.org/)

    > Beautiful static documentation for your API

    > A query language for your API

### API Documentation Tools

  * [Slate](https://github.com/lord/slate)

    > Use Markdown & Ruby

  * [apiDoc](https://github.com/apidoc/apidoc)

    > RESTful web API Documentation Generator.

    > [Demo](http://apidocjs.com/example_basic/)

  * [API Blueprint](https://github.com/apiaryio/api-blueprint)

    > A powerful high-level API design language for web APIs

  * [Flatdoc](https://github.com/rstacruz/flatdoc/)

    > Build sites fast from Markdown

  * [Swagger](https://github.com/swagger-api)

    > simple and powerful interface to your API

    > lots of automation, API tooling, and even client SDK generation and discoverability

    > [Demo](http://petstore.swagger.io/)

  * [RAML](http://raml.org/)

    > built on broadly-used standards such as YAML and JSON and it has many tools

### Miscellaneous

  * [MongoChef](http://3t.io/mongochef/)

    > GUI for MongoDB

  * [Robomongo](https://robomongo.org/)

    > native MongoDB management tool with admin UI

  * [Sequal Pro](https://github.com/sequelpro/sequelpro)

    > MySQL 的 GUI Application

    > Mac only

---

# Security

* [Kali Linux Docker Image](https://www.kali.org/news/official-kali-linux-docker-images/)

  > Install Kali Linux with Docker!

  > [Kali Linux Meta Packages](https://www.kali.org/news/kali-linux-metapackages/)

* Reconnaissance:
  * [Nmap](https://nmap.org/)

    > A very handy network discovery tool.

  * [Dripcap](https://github.com/dripcap/dripcap)

    > Packet Caffeinated Packet Analyzer based on [ELECTRON](https://github.com/electron/electron)

    > documentation:[Berkeley Packet Filter Syntax](http://biot.com/capstats/bpf.html)

  * [Wireshark](https://github.com/wireshark/wireshark)

    > The world’s foremost and widely-used network protocol analyzer.

    > Wireshark filter [documentation](https://www.wireshark.org/docs/man-pages/wireshark-filter.html)

  * [OpenDoor](https://github.com/stanislav-web/OpenDoor)

    > OWASP Directory Access scanner

    > Find all possible ways to login, empty directories and entry points.

* Password Recovery:

  * [John the Ripper](https://github.com/magnumripper/JohnTheRipper)

    > Fast password cracker

  * [Hashcat](https://github.com/hashcat/hashcat)

    > World's fastest and most advanced password recovery utility

* Exploits and Attacks:

  * [Metasploit](https://github.com/rapid7/metasploit-framework)

    > The best penetration testing framework, ever!

  * [LOIC](https://github.com/NewEraCracker/LOIC)

    > DoS Tool for Windows

  * [WifiPhisher](https://github.com/sophron/wifiphisher)

    > Automated victim-customized phishing attacks against Wi-Fi clients

  * [backdoorppt](https://github.com/r00t-3xp10it/backdoorppt)

    > transform your payload.exe into one fake word doc (.ppt)

* Miscellaneous:

  * [Metasploitable 2](https://community.rapid7.com/docs/DOC-1875)

    > The intentionally vulnerable version of Ubuntu Linux VM designed for testing security tools and demonstrating common vulnerabilities.

  * [VulApps](https://github.com/Medicean/VulApps)

    > 快速搭建各种漏洞环境(Various vulnerability environment)

    > 为方便使用，统一采用 __``Dockerfile``__ 形式

* Blogs

  * [深網與暗網指南](http://tutorial.evogtechteam.com/deep-web-dark-web-tutorial/#.WE640KJ975X)

    > 深網：互联网上无法通过普通方法访问到的内容，这些普通的方法包括使用谷歌与百度等搜索引擎。深网内容主要是一些需要某些条件如注册或付费才能访问的内容，也有的是数据库和某些服务。

    > 暗網：暗网简单的解释就是加密网络，它必需使用匿名代理工具才能访问

---

# DevOps

  * [Docker](https://www.docker.com/)

    > 超狂 application-level containers, BJ4.

    > 傳送門：

      * [Get started with docker for Mac](https://docs.docker.com/docker-for-mac/)

### CIsv

  * [Jenkins](https://github.com/jenkinsci/jenkins)  
  * [Travis CI](https://github.com/travis-ci/travis-ci)
  * [Circle CI](https://github.com/circleci)

---

其他包含編輯器、 shell 或是好用的輔助工具在開發的過程都佔有重要的地位，加速專案實作流程和速度，不可不用！

# Miscellaneous

## Online Tools
* [JSON Generator](http://www.json-generator.com/)
  * online JSON generator for fake data

## Editors
* [Atom](https://atom.io/)
  * Github 開發的編輯器
  * 適合前端開發

* [Visual Studio Code](https://code.visualstudio.com/)
  * 微軟開源的輕量編輯器，啟動速度快過 atom.
  * 得我新寵。
  * [快捷鍵 VSCode for Mac](http://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf) 

* [neovim](https://github.com/neovim/neovim)
  * [Official Website](https://neovim.io/)
  * Vim-fork focused on extensibility and usability.

## Command line tools
* [Cygwin](https://www.cygwin.com/)
  * a large collection of GNU and Open Source tools which provide functionality similar to a Linux distribution on Windows.

* [fish](https://fishshell.com/)
  * friendly-interactive shell for the 90s
  * Project tutorial: __[fish-shell-mac](https://github.com/xJkit/fish-shell-mac)__ ,an installation guide for fish on Mac

* [htop](https://github.com/hishamhm/htop)
  * A better top unix-like tool with interactive text-mode

* [ctop](https://github.com/bcicen/ctop)
  * Top-like interface for container metrics

* [yargs](https://github.com/yargs/yargs)
  * 快速開發 command line tools 的好用工具

* [Commander](https://github.com/tj/commander.js)
  * node.js command-line interfaces made easy
  * 使用 ES6 generator 的方式來開發 node.js cli 工具， tj 大大開發的

* [inquire](https://github.com/sboudrias/Inquirer.js)
  * A collection of common interactive command line user interfaces.
  * 使用 Promise 方式來開發 node.js cli 工具

* [cash](https://github.com/dthree/cash)
  * Cross-platform Linux commands in ES6
  * 透過 node.js 讓跨平台（如 Windows） 能夠使用 linux shell 的操作方式
  * Cash is a cross-platform implementation of Unix shell commands written in straight ES6. No native compiling and no external dependencies.

* [Yeoman](https://github.com/yeoman)
  * Yeoman helps you to kickstart new projects, prescribing best practices and tools to help you stay productive
  * 使用 CLI 工具快速產出專案的 Boilerplate.
  * 使用 [generator ecosystem](http://yeoman.io/generators/), 一種 plugin 能快速 scaffold 專案雛形
  * 使用 [yo](https://github.com/yeoman/yo) 執行 generators

## Search Tools

* [ack](https://github.com/petdance/ack2)

  * [官方文檔](https://beyondgrep.com/)
  * 超強搜尋工具，可以搜尋檔案名稱、檔案內容，使用 Perl 實作
  * Blazing fast, better search, for code search,

* [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)

  * 號稱比 ack 還快的搜尋工具...
  * 用 C 實作

# Secondary Languages
*  [Haskell](https://www.haskell.org/)

  > An advanced, purely functional programming language

  > __[project demo](https://github.com/xJkit/Haskell-example)__

* [Go](https://github.com/golang/go)

  > [Official Website](https://golang.org/)

  > High performance compiled language

  > 有人說這是 21 世紀的 C...
