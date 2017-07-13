# 使用 nightmare 作為瀏覽器自動化測試工具，當爬蟲也是可以。

> 專案位置: [hello-integration-test](git@github.com:xJkit/hello-integration-test.git)

先不廢話，直接貼 sample code, 展示去 Google 搜尋、點擊並撈取結果頁面的連結：

```javascript
const Nightmare = require('nightmare');
const nightmare = Nightmare({ show: true }); // options
// options.show = true 表示會秀出 electron 頁面讓你知道發生了什麼事情

nightmare
  .goto('https://google.com')
  .type('#lst-ib', 'github nightmare')
  .click('input[type=submit]')
  .wait('div._NId') // 等待指定的 DOM 元素 ready, 這很重要。
  /********** *********
  以上為 node 執行環境，以下為瀏覽器執行環境
  `evaluate(fn[, ...arg])` 相當於在瀏覽器 console 中執行 JavaScript 程式碼，有關 `variable lifting`, 函數 scope 問題請參考文獻 'Variable Lifting and .evaluate()'
  ********** *********/
  .evaluate(() => {
    const links = Array.from(document.querySelectorAll('div._NId h3.r a'));
    return links.map(link => link.href);
  })
  .end()
  .then(result => console.log(result))
  .catch(err => console.error('failed: ', err));

```

## 注意事項總整理

* Nightmare 使用 `pure JavaScript`, 別指望在這裡使用 jQuery.
* 使用 `.wait(selector)` 而不要 `.wait(ms)`. 你應該等待指定的 DOM ready 而不是幾秒之後。
* 使用 `.screenshot([path][, clip])` 截圖能幫助你 debug，了解你是在什麼步驟發生錯誤。建議可以在每一個 step 做一次，完成測試後再刪除他們。
* 注意 `.evaluate()` 是在開啟 Electron 後執行的 scope 之中，因此定義在它之外的 global variable 會 undefined, 必須從 fn 代入才行。 fn 存在的目的是要吃到 nodejs 執行時變數的 function scope.

`.evaluate()` 解釋：
  ```text
  The code in evaluate will be executed in the window opened by nightmarejs. So basically, it’s like you open a new tab on your browser, you type the website address and you paste the content of evaluate function inside the console. That’s why pure javascript works
  ```

## References

* [nightmare GitHub](https://github.com/segmentio/nightmare)
* [nightmare Examples](https://github.com/rosshinkley/nightmare-examples)
* [Variable Lifting and .evaluate()](https://github.com/rosshinkley/nightmare-examples/blob/master/docs/common-pitfalls/variable-lifting.md#variable-lifting-and-evaluate)
* [Asynchronous operations and loops](https://github.com/rosshinkley/nightmare-examples/blob/master/docs/common-pitfalls/async-operations-loops.md)
* 部落格文章：
  * [I had nightmare because of Nightmare (.js)](https://blog.vanila.io/i-had-nightmare-because-of-nightmare-js-4d07ccddcfc1) - 描述 nightmare 注意的小技巧
  * [An Overview of JavaScript Testing in 2017](https://medium.com/powtoon-engineering/a-complete-guide-to-testing-javascript-in-2017-a217b4cd5a2a)
  * [Nightmare of End-to-End Testing: 透過 Mocha 將 nightmare 整合測試環境](http://dsheiko.com/weblog/nightmare-of-end-to-end-testing)
  * [UI Testing with Nightmare](https://segment.com/blog/ui-testing-with-nightmare/)
  * [yield 和 yield*，也有一點點的 co](http://taobaofed.org/blog/2015/11/19/yield-and-delegating-yield/)
