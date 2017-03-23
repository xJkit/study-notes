# Webpack 2 學習筆記

1. Web page 兩大形式：
  * Server Side Templating
   * 伺服器渲染完整 HTML page
   * 少量 JavaScript
  * Single Page Application
    * 大量 JavaScript 渲染畫面
    * 和 Server 以 RESTful 或 GraphQL 傳值

2. Webpack 解決痛點：
  * 大量模組化的 js 有讀區順序的問題，不需確保 loading order 並且有彼此相依
  * 讀取一個網頁而有多個 requests 外連 js scripts 對於行動裝置來說會降低網頁效能

3. JavaScript 模組化系統三大方式：
  * Common.js - 使用 require, module.exports (npm 實作)
  * AMD - 使用 require, define
  * ES2015(ES6) - 使用 import, export