# JavaScript Memos

## Class

`class` and `extends`:

```js
class Car {
  constructor({ wheels }) {
    this.type = 'car';
    this.wheels = wheels;
  }

  drive() {
    return 'I am driving';
  }
}

class Honda extends Car {
  constructor(options) {
    super(options); // parent class constructor is called, for sure!
    this.model = options.model;
  }
}

const car = new Car({ wheels: 4 });
console.log(car.type); //car
console.log(car.drive()); //I am driving
console.log(car.wheels) //4

const honda = new Honda({ wheels: 6, model: 'accord' });
console.log(honda.wheels); //6
console.log(honda.type); //car
console.log(honda.model) //accord
```

## Generators

1. generator 初試呼叫時僅回傳`Iterator`, 不會執行。此 Iterator 稱為 `generator object`.
1. 在`generator object` 使用 `next()`方法迭代，並一一取得 Iterator 回傳值。
1. .next() 回傳物件，具有 value(回傳值) 與 done(布林) 兩個屬性；回傳值依據 `yield` 右邊的 expression 為主。而 ``yield`` 為下次 next() 帶值的入口。
1. 基本語法範例：

```js
function *generator() {
  yield 1;
  yield 2;
  yield 3;
}
const num = generator(); // 產生 Generator Iterator

console.log(num); // Generator iterator / Generator object / Generator prototype
console.log(num.next());
console.log(num.next());
console.log(num.next());
console.log(num.next());
```

以上結果分別印出：

```sh
GeneratorFunctionPrototype {
  "_invoke": [Function invoke]
}
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

* 注意事項：
  * ``next()`` 呼叫最後一個 ``yield`` 時尚未結束， ``done`` 屬性依然是 **false**, value 依然有值。最後一次以後保持回傳值 ``undefined`` 與 true. (有 return 就不會 undefined)
  * ``next()`` 第一次呼叫時代入任何值將被丟棄，因為沒有任何 yield 當作媒介，只會回傳 yield 右邊的敘述。
  * Generator 初始化時應注意：
    * 從 Generator 初始化一個 Iterator 寫法要注意不是建立物件：
      ```js
      const a = new generator(); // 錯誤
      const b = generator(); // 正確
      ```
    * 從 Generator 初始化一個 Iterator 時可以帶入參數：
      ```js
        function *gen(x) {
          const num1 = 1 + yield (x + 1);
          return num1;
        }
      ```
  * Generator 宣告： 可使用 `function declaration` 以及 `function expression` 兩種方式
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

* 特殊用法：
  * 搭配 ``for...of`` 迴圈
    * 直接抓 Generator 的 value 並迭代 Iterator 裡所有的 yields.
    * Generator 裡面的 ``return`` 值會被忽略。
    ```js
      function *foo() {
        yield 1;
        yield 2;
        yield 3;
        yield 4;
        yield 5;
        return 6;
      }

      for (var v of foo()) {
          console.log( v );
      }
      // 1 2 3 4 5
      // v 將停留在 5, 而不是 6
    ```

  * 在 Generator 中使用無窮迴圈：
    ```js
      function *foo() {
        let i = 0;
        while (true) {
          yield i += 1;
        }
      }

      const f = foo(); // 產生 Iterator

      console.log(f.next().value); // 1
      console.log(f.next().value); // 2
      console.log(f.next().value); // 3
      console.log(f.next().value); // 4
      //...
    ```

### Reference
* [Iterators and Generators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Iterators_and_Generators) by MDN
* [ECMAScript 6 入門](http://es6.ruanyifeng.com/#docs/object#%E5%B1%9E%E6%80%A7%E5%90%8D%E8%A1%A8%E8%BE%BE%E5%BC%8F) by 阮一峰
* [The Basics of ES6 Generators](https://davidwalsh.name/es6-generators) by Kyle Simpson
* [Redux Saga](https://redux-saga.github.io/redux-saga/docs/ExternalResources.html)

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
