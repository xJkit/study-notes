# JavaScript Memos

### generators
1. generator 初試呼叫時僅回傳`Iterator`, 不會執行。此 Iterator 稱為 `generator object`.
2. 在`generator object` 使用 `next()`方法迭代，並一一取得 Iterator 回傳的數值。
3. 回傳的數值依據 generator function 裡面的 `yield` 右邊的 expression 為主。
4. 基本語法範例：

```JavaScript
function *generator() {
  yield 1;
  yield 2;
  yield 3;
}
const num = generator();
console.log(num.next());
console.log(num.next());
console.log(num.next());
console.log(num.next());
```

以上結果分別印出：
```console
Object {
  "done": false,
  "value": 1
}
Object {
  "done": false,
  "value": 2
}
Object {
  "done": false,
  "value": 3
}
Object {
  "done": true,
  "value": undefined
}
```
5. 注意事項：
  * generator 可使用 `function declaration` 以及 `function expression` 兩種方式宣告。
    * function declaration: （上述範例）
    * function expression:
      ```JavaScript
        const g1 = function *() {
          yield 1;
          yield 2;
          yield 3;
        }
        // 或是 named function expression:
        const g2 = function *generator() {
          yield 1;
          yield 2;
        }
      ```
  * 注意： `generator` 無法搭配 `Arrow Function`!

### Reference
1. [阮一峰 ECMAScript 6 入門](http://es6.ruanyifeng.com/#docs/object#%E5%B1%9E%E6%80%A7%E5%90%8D%E8%A1%A8%E8%BE%BE%E5%BC%8F)

### 補充： function declaration 與 function expression
1. function declaration:
```JavaScript
function bar() {
    return 3;
}
```
2. function expression:
  * __anonymous__ function expression:
  ```JavaScript
  const a = function() {
    return 3;
  }
  ```
  * __arrow function__ with anonymous function expression:
  ```JavaScript
    const a = () => {
      return 3;
    }
  ```
  注意：箭頭函數只能使用 `anonymous` 的 function expression 來宣告。

  * __named__ function expression:
  ```JavaScript
  const a = function bar() {
    return 3;
  }
  // Named Function Express 在 IE<9 一下不能 work!!!
  ```
  * __self invoking__ function expression:
  ```JavaScript
  (function sayHi() {
    console.log('Hi!');
  })();
  ```
