# Progressive Web Apps in React

PWA ＝ Web + App (Web 擁有 native app 的使用體驗)

一個網站是否 PWA 的 top-level 條件為

* 安全網路連線

* 「加入主畫面」功能跳窗
* 主畫面 Web App 點選後擁有 app-like 的啟動畫面："Splash screen"
* 在惡劣的網路環境下可以正常運作
* 以手機端最高使用體驗為目標設計
* 頁面載入速度極快, 網站被優化到不行
* 網址列符合主題顏色

## 安全的網路連線

* Goolge 防止 App 在使用者之間做資料竄改，一律使用 `https` 連線
* Ref: [Google Will Soon Shame All Websites That Are Unencrypted](https://motherboard.vice.com/en_us/article/xygdxq/google-will-soon-shame-all-websites-that-are-unencrypted-chrome-https)
* 可使用 `Let's Encrypt` 或 `Cloudflare` 解決 SSL 的問題（而且還免費）
* 部署環境選擇： `Google App Engine`, `Github Pages`, `Zeit.co`
* 其他提升安全連線的 tips:
  1. 全面使用 `https://`
  1. 使用 `HTTP Strict Transport Security`(HSTS) headers(強迫瀏覽器只接受 https)

## 擁有加入主畫面功能

* Favicons, App name displayed, orientations, and more.
* 新增 [Web Application Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)
  * 在 Chrome 開發工具中: `Application` 可查看 *Manifest* 以及 *Service Workers*
  * Ref: 教學頻道-[Web App Manifest](https://www.youtube.com/watch?v=yQhFmPExcbs&index=11&list=PLNYkxOF6rcIB3ci6nwNyLYNU6RDOU3YyL)

## Web App 在主畫面啟動時擁有 「原生App」 體驗的登入畫面: `Splash Screen`

Chrome 47 後根據 `Manifest.json` 支援渲染啟動畫面，使體驗更接近原生 App 來自(background_color, name, icons).

* Firefox(Android), Opera(Android) 與 Chrome(Android) 支援 Manifest.json
* iOS 請看這裡：[Configuring Web Applications](https://developer.apple.com/library/content/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html)

## 以手機端使用體驗為終極目的

* HTML 網頁必須擁有 viewport meta 標籤：

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

以手機端為目標不代表 Desktop 可以不受重視；相反地，必須根據不同大小的 viewport 來優化視覺，以及跨瀏覽器相容性。

## 頁面載入速度極快, 網站被優化到不行

手機端擁有更佳的讀取速度可以證明：

* 70% longer sessions
* 兩倍以上行動廣告營收(mobile add revenue)
* 實際案例：
  1. [Flipkart 透過 PWA 讓網站停留時間倍增三倍](https://developers.google.com/web/showcase/2016/flipkart)
  1. GQ 擁有 80% 流量成長
  1. Trainline 獲得額外 11M 的年營收
  1. Instagram 更高的 33% impressions

### 網站讀取流程的節骨眼如下：

![imgUrl](http://i.imgur.com/yUbYs9M.png)

1. First Contentful Paint:
1. First Meaningful paint: 頁面主要內容被看見的時間
1. Speed Index: 視覺組件渲染完成
1. Estimated Input Latency: 主線程完成並可以處理使用者輸入
1. Time To Interactive(TTI): App 可以正常使用


## Tools

* [Lighthouse](https://github.com/GoogleChrome/lighthouse)
  * 執行 Audit 並列出 check list， 評估一個網站的 PWA 化程度
  * 工具安裝
    1. Chrome Canary - Audit 內建
    1. node cli 使用 npm -g 安裝
    1. [Chrome Extension](https://chrome.google.com/webstore/detail/lighthouse/blipmdconlkpinefehnmjammfjpmpbjk)
    1. [Light house get started](https://developers.google.com/web/tools/lighthouse/)
* [WebPageTest 網站](https://www.webpagetest.org/)
* 免費的 SSL 供應商
  * [Let's Encrypt](https://letsencrypt.org/)
  * [CloudFlare](https://www.cloudflare.com/)

## References

* [Awesome PWA](https://github.com/hemanth/awesome-pwa)
* [PWA Rocks!](https://pwa.rocks)
* [Progressive Web Apps with React.js: Part I — Introduction](https://medium.com/@addyosmani/progressive-web-apps-with-react-js-part-i-introduction-50679aef2b12)
* [Google Developers for Web](https://developers.google.com/web/progressive-web-apps/)
* [Realfavicongenerator.net](http://realfavicongenerator.net/)
* PWA metrics:
  * [YouTube Video](https://www.youtube.com/watch?v=IxXGMesq_8s)
  * [Slide](https://docs.google.com/presentation/d/1AnZOscwm3kMPRkPfjS4V2VUzuNCFWh6cpK72eKCpviU/edit#slide=id.p)
* [iOS doesn’t support Progressive Web Apps, so what?](https://cloudfour.com/thinks/ios-doesnt-support-progressive-web-apps-so-what/)

------

## Fundamentals of Progressive Web Apps (from [Udacity](https://classroom.udacity.com/courses/ud811))

以往普遍認為 Web app 比不上 Native app, 不失為三個原因敗筆：

* Reliability
* Speed
* User/Customer engagement (黏著性)

因此，很難使用 Web App 去做為大型的商業 case. 以前也許是對的，但是隨著兩件事改變了這一切：

1. 大部分的人只有在剛拿到手機當下不久買了大部分的 Apps (後續很少購買 + 持續更新很麻煩) --> 造成付費 App 曝光率低
1. 大部分的人安裝少許的 App 每一天只會被點開一次，甚至幾乎沒有 --> 被常用的 Facebook, Line 搶走

因此，讓 Native App 難與出頭天。然而，人們卻不斷使用 Web 瀏覽資料！隨著新技術將 native app 的優點帶到 Web App, 這個進化型 Web App 成為 `Progressive Web App`.

> Progressive Web App = best of web + best of apps = Reliable + Fast + Engaging experiences

Progressive Web Apps 優點：

* Reliable!!! (???)
  * Regular Updates (no need app store)
* Fast!
  * load quickly, even on poor, intermittent networks, even no network at all!
* Engaging
  * send relevant push notifications to users
  * Show on home screen, load with full screen like a native app

## Progressive Web App 技術總覽

* Service Workers
  * Client side proxy
  * 透過 Register -> 可以決定指定的 event 名稱來喚醒 Service Worker
  * 注意： SW 只能作用在 https 加密網路，但是 localhost 除外。
* Manifest.json
  * 加入在 Home 上的描述檔
  * 點開時有 splash screen, 啟動後沒有瀏覽器網址，就像一個 native app!
* App Shell Model
  * 一個網站最小單位的 HTML, CSS, JavaScript 以及部分圖片暫存在本地，讓你能快速啟動並正常工作
  * a bundle of code, a core components necessary to get off the ground
  * 注意：不包含任何 data
* Storage
  * cookie
    * 一般由 server 端產生，有時效限制。
    * 只能存字串, 一樣是 key-value pair
    * 大約 4KB 限制
    * 套在每一個 http 標頭裡，增加網路傳輸效能負擔
    * 很多用戶禁止使用 cookies...
    * 時機：小量非關鍵資料
  * localStorage
    * 簡單易用，瀏覽器都支援
    * 資料永久保存，除非手動清除
    * 不與 cookie 一樣戴在 header，不參與 server 端通信
    * 缺點： 同步、效能差、not transactional(只適合 prototyping)、key-value 字串儲存(存物件依賴 JSON.stringify <--> JSON.parse)
    * 時機：適合小數量資料
  * sessionStorage
    * 與 localStorage 相似，差異在資料保存的時間點
    * 當前 session 資料有效，關閉頁面將被清除。
  * cacheStorage
    * 在瀏覽器叫做 "caches"
    * 用來儲存 http response objects
    * 被定義在 service worker 規範當中，現已被 service worker 取代
  * IndexedDB
    * W3C 中 HTML5 標準新出现的瀏覽器裡内置的資料庫(很像 NoSQL的方式)
    * 優點： Fast, Complex Data, Async, Transactional
    * 缺點： API 很醜，透過第三方 library 會好用很多
    * 時機：適合大數量資料
  * Web SQL
    * 像是瀏覽器的關聯資料庫
    * W3C 已經不再支援此技術。

### Service Worker

> A JavaScript realm execution context with its own event loop & node document dependency.

白話文：

1. Service Worker 就是一個 JS file, 由瀏覽器在背景執行
1. event 所驅動, 可由瀏覽器本身或是 web page 產生
1. 不需要開啟網站才能執行(由於是背景執行) --> 所以可進行推播！(就算你沒打開 FB 也會受到通知) --> 通知比 native app 好用很多啦...

Service Worker 運作原理：

![imgUrl](http://i.imgur.com/qULY7Gj.png)

Service Worker 在 Online/Offline 的運作方式：

![imgUrl](http://i.imgur.com/SmctEEC.png)

> 注意：Service Workers 權力很大，包含 intercept network requests, modify, redirect, 甚至 fabricate! 因此僅允許 HTTPS 連線才能使用（localhost 除外）

### Manifest.json