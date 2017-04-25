# Functional JavaScript 筆記

* 通用程式開發原則
  * DRY (Don't Repeat Yourself) 不重複
  * YAGNI (ya ain't gonna need it) 你不會需要他
  * Loose Coupling, High Cohesion (低耦合，高聚合)
  * Principle of Least Surprise (最少意外原則)
  * Single Responsibility (單一責任原則)



## Reference 
  * [JavaScript Functional Programming 指南](https://jigsawye.gitbooks.io/mostly-adequate-guide/content/) by Franklin Risby (中譯)

## 1. First-class Function

## 2. Pure Function
  * 定義： 相同的輸入，永遠得到相同的輸出，而且沒有任何顯著的副作用。(output only depend on input)
  * 定義：就是數學上的``函數``。以數學來說， ``一對一``, ``多對一``就是純函數； ``一對多``就不是。
  * ``splice``, ``map``, ``filter`` 是 pure functions, 然而 ``splice``, ``push``, ``shift`` 都是嚼爛呼叫它的陣列，有很明顯的副作用，而且被永遠改變。
  * pure function 做到``完全自給自足``，不依賴外部系統狀態，降低系統複雜度：
  ```js
    // impure
      var minimum = 21;

      var checkAge = function(age) {
        return age >= minimum;
      };
      // 非常糟糕，輸入值之外的東西可能影響輸出


      // pure
      var checkAge = function(age) {
        var minimum = 21;
        return age >= minimum;
      };
      // 完全自給自足， output depends on input
  ```

### Side Effect
  > ``Side Effects`` 為系統計算結果的過程中，與外部世界的交互作用，或系統狀態的一種改變，也就是``計算結果以外的事``。...這是滋生 bug 的溫床。

Examples for ``Side Effects``:
  * 更改檔案系統
  * 在資料庫寫入紀錄
  * 發送一個 http request
  * 可變資料 (mutable data)
  * console log
  * 取得使用者的輸入
  * DOM 查詢
  * 存取系統狀態
  * ...(只要與 function 外部環境發生交互作用者)

並非一定禁止 Side Effects, 而是要儘量讓他在**可控制的範圍內發生**，例如使用 functor 與 monad.

### Side Effect 的優點：
* Cache: 由於相同輸入永遠得到相同輸出，因此可將紀錄快取起來加速。
  ```js
    const squareNumber = memoize(function(x) {
    return x * x;
    });

    squareNumber(4);
    //=> 16

    squareNumber(4); // 回傳輸入為 4 的快取結果
    //=> 16

    squareNumber(5);
    //=> 25

    squareNumber(5); // 回傳輸入為 5 的快取結果
    //=> 25
  ```
* Portable/ Self-documenting 可移植性、本身及文件
舉個例子：
```js
  //pure
  var signUp = function(Db, Email, attrs) {
    return function() {
      var user = saveUser(Db, attrs);
      welcomeUser(Email, user);
    };
  };

  var saveUser = function(Db, attrs) {
      ...
  };

  var welcomeUser = function(Email, user) {
      ...
  };
```
純函數對於依賴相當誠實，因此能方便知道他的目的。透過強制的``注入依賴``或是當參數傳遞，讓 app 更加靈活。

* Testable 可測試性

  * 對於 pure function, 不需要 ``mock`` 一個不真實的付款閘道，或是測試前的 setup，測試之後都要 assert.

  * 僅需要 ``給定 input > assert 輸出``。

* Reasonable 合理性
pure function 最大好處： referential transparency(透明性)，意思是 ``如果一段程式碼可以替換成它執行後所得到的結果，而且是在不改變整個程式行為的前提下替換的，那麼我們可以說這段程式碼是引用透明的。``

* 並行程式碼
並行執行任何 pure function. 因為 pure function 根本不需要存取共享記憶體；根據定義，也不會因為 side effects 而進入競爭狀態（race condition.

## 3. Curry (柯里化)
Curry 的定義有多方說法：
* Currying is the technique of translating the evaluation of a function that takes multiple arguments (or a tuple of arguments) into evaluating a sequence of functions, each with a single argument. Currying is related to, but not the same as, partial application. by [wiki](https://en.wikipedia.org/wiki/Currying)
* 是把接受多個參數的函數變換成接受一個單一參數（最初函數的第一個參數）的函數，並且返回接受餘下的參數而且返回結果的新函數的技術 by [維基百科](https://zh.wikipedia.org/wiki/%E6%9F%AF%E9%87%8C%E5%8C%96)

* 基本範例：
  ```js
    const add = x => y => x + y;
    const incre = add(1);
    console.log(incre(2)); // 3
  ```
  上述第一行程式碼在 JavaScript ES5 寫法如下：
  ```js
    var add = function (x) {
      return function (y) {
        return x + y;
      }
    }
  ```


## 4. Compose 
Compose 被用來堆高積木，在數學觀念上，就是``合成函數``的意思： **f(g(x))** 代表 input (x) --> g --> f --> 輸出。合成函數 Compose 實作如下：
  ```js
    // ES 6
    const compose = (f,g) => x => f(g(x)); 
    // ES5
    var compose = function (f, g) {
      return function (x) {
        return f(g(x));
      }
    }
  ```
* Compose 用來結合多個自選的 functions 來變成一個全新的 function.
* Compose 定義 g 會比 f 先執行：建立一個由右至左的資料流，遠比標準合成函數（巢狀呼叫）更有可讀性。
* x 就是合成函數 Compose 的管道參數，也就是 input.

一個實際運用的範例： strings -> toUpperCase -> explaim -> 輸出
  ```js
    const toUpperCase = x => x.toUpperCase();
    const exclaim = x => x.concat('!');
    // shout composes toUpperCase & exclaim
    const shout = compose(exclaim, toUpperCase);
    console.log(shout('What the fuck?')); // WHAT THE FUCK?!
  ```
Compose 建立一個右至左的資料流，而不是巢狀的由內到外，稱為``left direction`` 更能貼近數學上的意義；其實 Compose 就是來自數學，而且遵守以下定律：
* 結合律（associativity）
```js
// 在 compose 中分組一點都不重要
var associative = compose(f, compose(g, h)) == compose(compose(f, g), h);
// true
```
由於 Compose 在結合律下相等，因此 Compose 分組並不重要。結論是， Compose 裡面無需 Compose, 只要確定資料流由右至左，我們只需要一個 Compose：
  ```js
    const compose = (f, g, h, i, j) => x => f(g(h(i(j(x)))));
    const ans = compose(3); // x = 3
  ```
寫出一個參數數量可變的 ``Compose(...f)`` 讓他安全可靠有靈活性。

Compose 讓子分組可以不需要，或者說可以任意拆解 ...f 便自行分組：
```js
  const loudLastUpper = compose(exclaim, toUpperCase, head, reverse);

  // 或
  const last = compose(head, reverse);
  const loudLastUpper = compose(exclaim, toUpperCase, last);

  // 或
  const last = compose(head, reverse);
  const angry = compose(exclaim, toUpperCase);
  const loudLastUpper = compose(angry, last);

  // 更多變種⋯
```
...一個以自己喜歡的方式玩樂高積木的態度。最佳的分組方式，就是 讓 ``re-use`` 最大化。