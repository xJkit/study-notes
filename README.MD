# J's Study Notes
> 個人學習 JavaScript 的心路歷程，以此紀念。

> If you stranger finds something incorrect, a pull request is much appreciated.

> If you stranger has a better ideas or tools, just open an issue to speak out loudly; welcome.

---

在驟變的前端世界，不做個筆記留下工程師的青春，就會跟夢一樣輕易流逝。JavaScript 真的是像在演肥皂劇，從以前跑龍套的語言變成今日能挑大樑的勇士，如此動人的情節跟川普在不被看好的亂世中獲勝是一樣的驚天地泣鬼神？

Given synopsis below. please check more detail on the ``Project Demo``.

# Front End
### React official
* [react](https://github.com/facebook/react)
* [react-router](https://github.com/ReactTraining/react-router)
* [redux](https://github.com/reactjs/redux)

  > Predictable state container for JavaScript apps

### React-related Libraries

* [ant-design](https://github.com/ant-design/ant-design/)

  > An enterprise-class UI design language and React-based implementation.

  > [Official Site](https://ant.design/)

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

* [classNames](https://github.com/JedWatson/classnames)

  > A simple javascript utility for conditionally joining classNames together

  > 可以把判斷邏輯、Inline CSS 寫在 Component 裡面的函式庫

* [Draft.js](https://facebook.github.io/draft-js/)

  > A framework for building rich text editors in React.

  > 適合拿來當管理介面的寫作 UI 編輯器

### Modern F2E Essential Tools

  * [Webpack](https://github.com/webpack/webpack)
    > 前端必備打包工具

    > 延伸閱讀：

      * [知乎－Webpack 配置說明](https://zhuanlan.zhihu.com/p/21346555?refer=jscss)
      * [手把手深入理解 webpack dev middleware 原理與相關 plugins](https://segmentfault.com/a/1190000005614604)
      * [译 Webpack——令人困惑的地方](https://segmentfault.com/a/1190000005089993?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io)

### Async Request
* [axios](https://github.com/mzabriskie/axios)

  > Promise based HTTP client for the browser and node.js

* [isomorphic-fetch](https://github.com/matthew-andrews/isomorphic-fetch)

  > Isomorphic WHATWG Fetch API, for Node & Browserify

  > 這個讓 fetch 變成 global, 你也可以在瀏覽器中使用 fetch()

  > 這個也是 Promise-based, 但是需要 polyfilles: [es6-promise](https://github.com/stefanpenner/es6-promise)

  > 欲使用 query string, 可搭配 [URLSearchParams](https://developer.mozilla.org/zh-TW/docs/Web/API/URLSearchParams)

* 延伸閱讀：
  * [瀏覽器跨領域4種方法：cors/jsonp/proxy/fetch 與fetch api 最佳實踐](https://segmentfault.com/a/1190000006095018)

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

### Debug Tools & Helpers
*  [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en)

  > RESTful API 快速驗證工具

*  [Redux DevTools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en)

  > Chrome extension for redux app

  > Excellent GUI tool for checking the state in the store of a react app with redux

*  [eslint](https://github.com/eslint/eslint)

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


### References & Articles
* [Awesome React](https://github.com/enaqx/awesome-react)
* [State-of-the-Art JavaScript 2016](https://medium.com/javascript-and-opinions/state-of-the-art-javascript-in-2016-ab67fc68eb0b#.kj8081e20)

---

# Back End

要善用 Full Stack JavaScript 不可或缺的後端功能。感謝 [Node](https://nodejs.org/en/), 讚嘆 [Node](https://nodejs.org/en/).

  * [express](https://github.com/expressjs/express)
    > Fast, unopinionated, minimalist web framework for node.

    > 超古老經典 Node 框架

  * [request](https://github.com/request/request)
    > Simplified HTTP request client.

    > 方便讓我繞過瀏覽器的 Ajax Same Origin Policy

### Miscellaneous

---

資訊安全是我另一個感興趣的領域。偶爾關注國內外的 CTF ，但是實力粗淺只有乾瞪眼的份。不論如何，看到好用的開源工具或腳本，先筆記。

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

其他包含編輯器、 shell 或是好用的輔助工具在開發的過程都佔有重要的地位，加速專案實作流程和速度，不可不用！

# Miscellaneous
* [Cygwin](https://www.cygwin.com/)

  > a large collection of GNU and Open Source tools which provide functionality similar to a Linux distribution on Windows.

* [fish](https://fishshell.com/)

  > friendly-interactive shell for the 90s

  > * Project tutorial: __[fish-shell-mac](https://github.com/xJkit/fish-shell-mac)__ ,an installation guide for fish on Mac

* [ATOM](https://atom.io/)

  > a hackable text editor for the 21st century.

  > suitable for the front end development

* [JSON Generator](http://www.json-generator.com/)

  > online JSON generator for fake data

* [docker](https://www.docker.com/)

  > 超狂 application-level containers, BJ4.

  > 傳送門：

    * [Get started with docker for Mac](https://docs.docker.com/docker-for-mac/)

# Secondary Languages
*  [Haskell](https://www.haskell.org/)

  > An advanced, purely functional programming language

  > __[project demo](https://github.com/xJkit/Haskell-example)__
