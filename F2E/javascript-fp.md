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
