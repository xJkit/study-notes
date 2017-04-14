# Reactive Programming 閱讀筆記
> 資料來源：[The introduction to Reactive Programming you've been missing](https://gist.github.com/staltz/868e7e9bc2a7b8c1f754#reactive-programming-is-programming-with-asynchronous-data-streams)

1. 什麼是 Reactive Programming?
  * 官腔說法：
    * [維基百科](https://en.wikipedia.org/wiki/Reactive_programming)
    * [Stackoverflow](http://stackoverflow.com/questions/1028250/what-is-functional-reactive-programming)
    * [M$ Rx terminology](https://rx.codeplex.com/)
  * RP = programming w/ `asynchronous data streams`
    * 網頁上的 click, hover 等等都是 event stream
    * RP 就是上述的強化版本：任何東西都 stream 化
  * Stream 是什麼？
    * 任何東西都可為 Stream: variables, user inputs, properties, caches, data structures...
    * 一般般的 Stream 太廉價且隨處可見,不好利用
    * RP 讓這些 Stream 更有利用的價值
  * RP = 一個 Functional Programming 的工具箱
    * 可以拿來 combine, create, filter, map 這些 streams
    * 在 FP 下，一個 stream 在經過 F(x) 後可以變成另外一個 stream 並且給另外一個 G(x) 使用。
