# Flow Type Checker 筆記

A type checker that makes your JavaScript to be static-typed ... and `Swift` alike.

## 基本環境假設

* IDE 安裝 flow 的 lint 外掛
  * VSCode
    * [Flow Language Support](https://marketplace.visualstudio.com/items?itemName=flowtype.flow-for-vscode)
  * Sublime Text
  * Atom
* 專案安裝 `npm` (yarn) + `babel`
  * 安裝 `flow-bin`, flow 的主程式
  ```sh
  npm install --save-dev flow-bin
  yarn add --dev flow-bin
  # 兩者擇一使用
  ```
  * 安裝 `babel` compiler
    1. `babel-cli` 為 babel 核心, 讓你把 babel 指令寫在 npm scripts 執行
    1. `babel-preset-flow` 為 babel 把 flow 程式碼 -> JavaScript 的工具
    ```sh
    npm install --save-dev babel-cli babel-preset-flow
    ```
    1. 新增 `.babelrc` 並設定 `presets`：
    ```json
    {
      "presets": ["flow"]
    }
    ```

> 關於 Babel 為 transpiler 或 compiler 的爭議請看 [這一篇 StackOverflow](http://stackoverflow.com/questions/43968748/is-babel-a-compiler-or-transpiler)

* 初始化 `flow`
  1. 使用 `flow` 新增 `.flowconfig`
    ```sh
    flow init
    ```
  1. 啟動／停止 `flow` server 背景執行 check 任務
    ```sh
    flow status
    # 直接打 flow 會預設執行此 flow status
    # flow 的背景任務執行緒只會有一支，重複打指令也是相同的一支
    flow stop
    # 停止 flow 背景任務
    ```
  * 讓你的 code 變成靜態性別程式碼：在你的程式碼上面打上註解
    ```javascript
    // @flow
    ```

## 使用 Flow

Flow 的使用依照專案開發有多種不同的搭配方式

* 使用 npm scripts + `babel-cli`
  * 在 scripts 中透過 babel 編譯 flow, 將所有語法拔除後吐出真正的 JavaScript
* 使用 Webpack 打包

## Flow 的資料型態(Type Annotations)

資料型態在 Flow 的角色非常重要，因為你就是要使用 "Type" 所以才來使用 Flow 阿，不然搞笑？ Flow 所支援的資料型態如下：

### [基礎資料型態(Primitive Type)](https://flow.org/en/docs/types/primitives/)

* boolean
  * 接受 `true` 或 `false`
  * 使用 `0` 必須轉型，例如 `Boolean(0)` 或 `!!0`
  * Boolean 與 boolean 不同，前者為 constructor, 後者為 literal value
* number
  * 接受整數 `87` 或小數 `3.14`
  * 接受 `NaN` 與 `Infinity`
    > `NaN` 為 falsy, 但 `Infinity` 為 truthy，兩者皆為 number 型態
* string
  * 接受 "this is string"
  * 其他型態必須手動轉型,使用以下函數：
    * `String()`
    * `toString()` -> number 不可使用
    * `JSON.stringify()`
    > 原生 JavaScript 發生自動轉型情況為 "a" + 42,此類字串必須手動轉型(explicit)
* null
  * 就是 `null`
* void
  * JavaScript 中的 `undefined` 在 Flow 中被定義為 `void`
* Symbols (尚未支援, WIP)

* 傳值基本兩種型態：
  * `literal` value
  ```js
  true; // boolean
  5978; // number
  "jay"; // string
  null;
  undefined; // (在 flow 中定義為 void)
  ```
  * `constructed wrapper object` value
  ```js
  new Boolean(false);
  new Number(5978);
  new String("jay");
  new Symbol("jay 123");
  ```
> wrapper object 非常少用

* `Optionals`
  * 在 Flow 中定義 `可有可無` 的資料型態，使用 (`?`)宣告，方式和條件都不盡相同，有下列三種：
    1. Maybe Types
    1. Optional Object Properties
    1. Optional functional parameters
  * `Maybe Types`:
    * 用於 function arguments (actual parameters)
    * `?` 定義在`變數之前`： `?type`
    ```js
    function method(value: ?string) { //... }
    ```
    * `?type` 可為 `type` | `void` | `()` 不代入 | `null`
  * `Optional Object Properties`
    * 用於 Object literal 物件
    * `?` 定義在 `變數之後`： `propertyName?`
    ```js
      {
        propertyName?: string
      }
    ```
    * `propertyName?: type`: 可為 `type` | `void` | `{}` 不代入 | ~~`null`~~ (不可為 `null`)
  * `Optional function parameters`
    * 用於 function parameters (formal parameters)
    * `?` 定義在 `變數之後`： `param?`
    ```js
    function method(param?: string) { //... }
    ```
    * `param?: type` 可為 `type` | `void` | `{}` 不代入 | ~~`null`~~ (不可為 `null`)
    * function parameters 也可以使用預設值的寫法：
    ```js
    function method(param: string = "default") {//...}
    ```
> `Maybe Type` (param: ?type) 跟 `Optional function parameter` (param?: type) 只有在 `null` 跟 `寫法` 的差別而已


### `任何的資料型態`

* any
  * 可以代入任何數值，檢查都會過
* mixed
  * 可以代入任何數值
  * 需要 `refinement` 檢查才會過

`mixed` 允許你丟任何數值，但最大的差別就是需要 `refinement`, 也就是增加 `typeof === type` 判斷：

```js
function returnByType(data: mixed) {
  if (typeof data === 'string') { // ...}
}
```

> 使用 `any` 是危險的，因為會 **Bypass** Flow 的檢查機制。建議全部換成 `mixed`.

### `複合資料型態`

* Array
* Object
* Function
* Class
* Generics

## 其他資料型態與 Refinement

以下為一些資料型態的 `Refinement` 做補充。

### Literal Types

直接定義資料型態的 `數值`

```js
const getTwo = function getTwo(value: 2) { //... }
getTwo(2) // works
getTwo(3) // error
getTwo("2") // error
```

常用的情況，當傳入的數值為可預測的幾種情形，類似 Swift 中的 `enum`, 在 Flow 稱為 `Union Types`：

```js
function getData(response: "SUCCESS" | "FAILURE" | "REQUEST") {
  switch (response) {
    case "REQUEST": return "get data is pending...";
    case "SUCCESS": return "get data successfully";
    case "FAILURE": return "get data failed!";
    default: return "erorr occured";
  }
}
```

### Maybe Types

Maybe Type 讓你的型態 `?type` 可為 `type` 或 `null` 或 `undefined`. 但是使用時必須先 check 才能做運算：

```js
const getMaybeNumber(num: ?number): number {
  if (num !== null && num !== 'undefined') {
    //...
  }
}
```

由於使用了 `!==` 更嚴格的檢查方式，所以兩種情形必須判斷。但你知道， 若使用 `==` 會讓 `null` == `undefined` 變成 `true`, 所以只要使用 `!=` 較不嚴謹的判斷：

```js
const getMaybeNumber(num: ?number): number {
  if (num != null) {
    //...
  }
}
```

寫一次 `!=` 即可來判斷非 `null` 或 `undefined` 的情況，讓你順利使用原本的 `type`. 換句話說，你也可以逆向思考，從正向出發：

```js
const getMaybeNumber(num: ?number): number {
  if (num === 'number') {
    //...
  }
}
```

## Flow in React

`Flow Types 取代 PropTypes 或 prop-types`

## References

* [Official Repository](https://github.com/facebook/flow)
* [Official Website](https://flow.org/)
