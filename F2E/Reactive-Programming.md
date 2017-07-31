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

## RxJS Introduction

### 基本觀念

* Observable `可觀察的物件`
  * 代表未來即將產生的事件資料
* Observer `觀察者物件`
  * 用來接受觀察結果的物件
  * 擁有三個 callbacks 函數
  * (next, error, complete)
* Subscription `訂閱物件`
  * 上面都是 stream$ 的邏輯，真正必須 subscribe 才會執行
  * 代表正在執行 Observable 的執行個體
  ```js
    // Observable.subscribe(Observer)
    var subs$ = click$.subscribe(x => console.log(x));
  ```
  * `subs$`的存在是可以取消這個執行實體：
  ```js
    subs$.unsubscribe();
  ```
* Operators `運算子`
  * stream$ ---> `operator` ---> strean*
  * 全部都是 pure functions
  * 處理一系列事件的資料集合
  * 常見 map, filter, flatMap, switchMap, ...
* Subject `主體物件`
  * 如同 eventEmitter 用來廣播收到的事件資料給多個 Observer
* Schedulers
  * control concurrency

### 彈珠圖 (Marbles Diagram)

![Imgur](http://i.imgur.com/7LrTzGu.png)
  * 上方 stream$ 為 Observable, 下方為 Observer
  * Observable 經過一連串的 Operator 後經過訂閱變成 Observer 所看見
  ```js
    const subs$ = clicks$
      .filter(x => x.clientX > 100)
      .take(2)
      .subscribe(x => console.log(x));
    // 停止訂閱
    subs$.unsubscribe();
  ```

### 常用運算子 (Operator)
* `Creation` 類別， 創造 Observable:
  * create
  * empty
  * of
  * fromEvent
  * from
  * fromPromise
  * interval
  * never

* `Transform` 類別，轉換/運算 Observable:
  * buffer
  * concatMap
  * groupBy
  * map
  * switchMap
  * window
  * pluck
  * margeMap

* `Filtering 類別，刪減 Observable:
  * debounce
  * distinct
  * distinctUntilChanged
  * filter
  * first
  * ignoreElements
  * skip
  * take
  * throttle

* `Combination` 類別，多個 Observables ---組合--> Observable
  * combineAll
  * combineLatest
  * concat
  * concatAll
  * forkJoin
  * merge
  * mergeAll
  * startWith

* `Multicasting` 類別，廣播訊息，將 Observable 廣播給多位 Observers
  * cache
  * publish

* `Error handling` 類別，Observable 被觀察發生例外之時，常用 http request
  * catch
  * retry (可以重新訂閱)
  * retryWhen

* `Utility` 工具類
  * do
  * delay
  * delayWhen
  * materialize
  * toArray
  * toPromise

* `Conditional & Boolean` 類
  * defaultEmpty
  * find
  * findIndex

* `Mathematical & Aggregate` 類，用於匯總
  * count
  * max
  * min
  * reduce