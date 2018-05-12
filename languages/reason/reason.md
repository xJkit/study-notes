# REASON 學習筆記
> [Reason REPL Online Playground](https://reasonml.github.io/en/try.html?rrjsx=true&reason=Q)
> [ReasonReact Playground](https://reason.surge.sh/)

> [BuckScript 官方文檔](https://bucklescript.github.io/docs/en/what-why.html)
> [Reason 官方文檔](https://reasonml.github.io/)
> [ReasonReact 官方文檔](https://reasonml.github.io/reason-react/docs/en/what-and-why.html)
>
REASON 是一個搭建在 `OCaml` 上的函數式程式語言，將 OCaml 的語法修飾成 JavaScript 開發者所習慣的方式。

## Features

* Functional

  ```reason
  /* composition */
  let increment x => x + 1;
  let double x => x + x;
  let eleven = increment (double 5);
  ```

* Strong inferred type system
  * 不需要每一個都明定資歷類型， Reason 預設會幫你定義最適合的 type
  ```reason
    /* same type */
    let myInt = 5;
    let myInt: imt = 5;

  ```

* Algebraic data types
  ```reason
    type myResponseVariant =
      | Yes
      | No
      | PrettyMuch;
    let areYouCrushingIt = Yes;
  ```
* Pattern Matching
  ```reason
    /* powerful version of Switch in Reason */
    let message =
      switch areYouCrushingIt {
        | No => "No worries"
        | Yes => "Great!"
        | PrettyMuch => "Nice!"
      };
    /* message is "great" */
  ```

## Installation
> [Official REASON Installation Guide](https://reasonml.github.io/docs/en/global-installation.html)
> [Official ReasonReact Installation Guide](https://reasonml.github.io/reason-react/docs/en/installation.html)

要使用 Reason(ML) 必須搭配 Tool chain 才能成功使用：

  ```js
    npm install --global reason-cli@3.1.0-darwin
  ```

[reason-cli](https://github.com/reasonml/reason-cli) 不是一個 library, 只是一個方便 npm 的使用者安裝 OCaml tool chain 的 Makefile.

OCaml tool chain for Reason:

* ocamlmerlin
* ocamlmerlin-reason
* refmt (Reason G=版本的 prettier)
* rtop (reason cli, 如同 Haskell 的 ghci)
* ocamlrun
* ocamlc/ocamlopt
* ocamlfind


執行 REASON (副檔名 .re) 的方式有兩種：
1. 使用 REASON-to-JavaScirpt Compiler:  [BuckleScript](https://github.com/BuckleScript/bucklescript)

  ```sh
    npm install --global bs-platform
    bsb -init hello-reason-app -theme basic-reason
  ```

* 使用 OCaml 與 `OPAM`:
  * opam 是 OCaml Package Manager, 使用他來安裝 REASON
  * 執行 reason 必須使用 compiler 版本為 4.02.3
  ```sh
    opam switch 4.02.3
  ```
  * more detail: [Native QuickStart](https://reasonml.github.io/guide/native/quickstart)
  * REPL 測試工具：
    * `utop` for OCaml
    * `rtop` for Reason

## Language Basics

* [Overview](https://reasonml.github.io/guide/language/overview)
  * Overview 秀出一些基本的 operator 寫法
  * 大部分都跟 JavaScript 很像，比較不同者：
    1. 字串只能用 double quotes
        ```reason
          "this is string"
        ```
    2. 有分 `int` 和 `float`, 在計算上與 JavaScript 不同：
        ```reason
          let calcFlot = 2.0 +. 3.0 *. 4.2 /. 1.8;
          let calcInt = 2 + 3 / 4 * 8;
        ```
    3. 陣列分為 `List`(不可變) 和 `Array`:
        ```reason
          let immutalbleList = [1, 2, 3]; /* yes */
          let mutalbleArray = [|1, 2, 3|];
        ```
    4. 物件叫做 `Record`, 使用 **type** 宣告, 要先宣告後才能丟 **value** 進去：
        ```reason
          type person = {
            age: int,
            name: string
          };

          let me = {
            age: 5,
            name: "Jay Chung"
          };
          /* 一樣使用 dot notation 來 access */
          let myName = me.name;
        ```

* **let** binding
  * let `<name>`: `<type>` = `<expression>`;

  ```reason
    let greeting: string = "Hello, REASON!";
    let jim = "JIM"; // type inference
  ```

  * 綁定後的數值原生 **immutable**, 但是可以重新綁定：

  ```reason
  let hello = "hi";
  > let hello: string = "hi";
  hello = "reason";
  > Error: The value hello is not an instance variable
  let hello = "reason";
  ```

* **Type** alias

  ```reason
    Reason # type score = int;
    type score = int;
    Reason # let x: score = 40;
    let x: score = 40;
    Reason # 60;
    - : score = 60
    Reason # type scores = list(score);
    type scores = list(score);
    Reason # [60, 70, 80];
    - : list(score) = [60, 70, 80]
  ```

* **Scoping**
  * Lexical Scope

  ```reason
    Reason # let foo = "FOO";
    let foo: name = "FOO";
    Reason #
    {
      let foo = "bar";
      foo;
    };
    - : name = "bar"
    Reason # foo;
    - : name = "FOO"
  ```

* **Expression**
  * 每一個 block 回傳最後一個 statement

  ```reason
    Reason # let fullName = {
      let fname = "Jay";
      let lname = "Chung";
      fname ++ lname;
    };
    let fullName: string = "JayChung";
  ```

  * 也就是說要得到一個複雜運算的數值不一定要宣告**函數**，可以使用 expression 即可

**expression** 在 Reason 中非常好用，因為 expression 自動 return 最後的 statement, 很多時候你可以不需要寫 function 就可以使用 let binding.

在 JavaScript 中 expression 無法被 assign:

```js
  var greeting = if (true) {"Hello"} else {"Hi"};
  // Uncaught SyntaxError: Unexpected token if
  // 必須改寫成 ternary operator:
  var greeting = true ? "Hello" : "Hi";

```

在 reason 中 expression 可以合法做 let binding：

```reason
  let greeting = if (true) {"Hello"} else {"Hi"}
  > let greeting: string = "hello";
  let greeting = true ? "Hello" : "hi";
  /* REASON 中 if-else 的語法糖跟 JavaScript 雷同 */
```

雖然 **expression** 非常好用，但是在 Reason 中 **if-else** 兩個 branch 必須回傳 **相同型別**. 以下是 JavaScript 合法而 Reason 卻不合法的例子：

valid JavaScript:

```js
  var result = false ? "haha this is true" : 100;
  // result 即為 100;
```

invalid reason:

```reason
  let result = if(false) {"haha this is true"} else {100};
  > Error: This expression has type int but an expression was expected of type string
  let result = if(true) {"haha"};
  > Error: This expression has type string but an expression was expected of type unit
  let result = if(true) {"haha"} else {()};
  > Error: This expression has type unit but an expression was expected of type string
```

當你宣告 if 卻沒有宣告 else 的時候， Reason 自動加上 () unit type. 因此只有宣告 if 沒有宣告 else 是不合法的，**除非你執行 side effect** 像是 `print_endline`. 因為這個 function 本身沒有回傳（或說回傳 unit; 沒有寫的 else{()} 也是 unit， 因此這個 expression 是合法的。

```reason
if (true) {print_endline("hahaha")};
> - : unit = ()
```

* **Pattern Matching**

在 Reason 中 if-else 是比較少用的 expression,通常只有兩個 case (true/false) 的時候才會用，一般最常用的武器是 pattern matching.

在這邊先簡單版講解 pattern matching:

```text
switch(<value>) {
  | <pattern1> => <case1>
  | <pattern2> => <case2>
  | other => <expression>
}
```

```reason
let lang = "en";

let greeting =
  switch (lang) {
  | "en" => "Hello"
  | "tw" => "你好"
  | other =>
    let myCountry = "Taiwan";
    "I am from " ++ myCountry ++ ", where are " ++ other ++ " from?"
  };

```

就像是 JavaScript 的 switch case, 最後面是 default case. **other** 就像是 function argument 般直接取得 value 的數值。

以上編譯為以下 JavaScript code:

```js
var greeting;
switch (lang) {
  case "en" :
      greeting = "Hello";
      break;
  case "tw" :
      greeting = "你好";
      break;
  default:
    greeting = "I am from Taiwan, where are en from?";
}
```

* **Record**

Record 就像是 JavaScript Object, 多了一些不同點：
  1. Record 天生 **Immutable**. (例外：除非你使用 **mutable**)
  2. Record 的 field 必須遵照 `type` 定義欄位(fixed in field names & types). (例外：除非你使用 **pub**)
  3. 其他：更快，更輕...

 Record 在 Reason 中最大的不同就是你**無法在定義 record 的 type 之前 恣意宣告任意型態的 record**，無法像在 JavaScript 中恣意宣告物件一樣。一開始對於 JavaScript 開發者可能會綁手綁腳，不過也許這就是靜態語言的優點？

```reason
type person = {
  name: string,
  age: int,
};

let me = { /* me 自動被 inferred 為 person type */
  name: "jay",
  age: 30
}; /* 必須與 person 有相同欄位 */

```

Records 一樣可以使用 let binding, 搭配以往 JavaScript 的 destructuring 與 **punning** (shorthand syntax)

新增一個 Record, 可以透過 **Immutable Update** 或是 **Mutable Update**, 請看以下範例：

```reason
type person = {
  name: string,
  mutable age: int, /* 可改變之 field */
};

let {name: myName, age: myAge} = me; /* let binding name to myName */

/*  new record created by immutable update  */
let faye = {
  name: "Faye",
  age: myAge
};

/* immutable update with spread operator */
let meNextYear = {
  ...me,
  age: me.age + 1
};

/* mutable update */
me.age = 12;

/* punning */
let {name} = me;
let meLastYear = {
  name, /* syntax shorthand here */
  age: myAge - 1,
}
```

**punning**

punning 除了用在 record 以外，也可以運用到 type:

```reason
type coordinate = {
  x: int,
  y: int,
};

type circle = {
  coordinate, /* punning here */
  radius: int,
};

let drawCircle = {
  coordinate: {
    x: 3,
    y: 4
  },
  radius: 5,
};
```

直接亂揮灑未定義 type 的 record 你會得到這種錯誤：

```reason
let Andy = {
  name: "Andy",
  company: "QNAP",
};
/* The record field name can't be found. */
```

例外：在鮮少情況你無法預先定義 record 的 type. 要像 JavaScript 一樣亂揮灑 object 的方式就是使用 **pub**, 讀取欄位使用 sharp **#**:

```reason
let andy = {
  pub name = "技術長";
  pub age = 40;
  pub company = "QNAP";
  pub position = "DevOps engineer";
};

let andyPosition = andy#position;
```

特別注意：使用 **pub** 宣告的 record 是透過等號( = ) 和分號(；) 來創建的.

* **Variants**
> [參考文章：ReasonML: variant types @Dr. Axel Rauschmayer](http://2ality.com/2017/12/variants-reasonml.html)

Variant 使用 **大寫開頭** 的 **constructor** 來宣告, 類似 C 語系家族的 enum, 對於 **switch** 與 **Pattern Matching** 非常有用：

```reason
type day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday;

/* 或是垂直排列 */
type day =
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  | Sunday;

let today = Tuesday;

switch(today) {
| Friday => "Yah! Weekend! Let's party."
| Saturday | Sunday => "Holiday! Go on vacation now."
| _ => "Weekdays...no!" /* 最強 default pattern */
};

/* 多個 patterns 相同輸出也可以垂直排列, 跟 JS 語法類似： */
switch (today) {
| Friday => "Yah! Weekend!"
| Saturday
| Sunday => "Holiday! On vacation now"
| _ => "weekdays... no"
};
```

在 Variant 中的 Constructor 也可以帶入參數，就像是伴隨著的 Tuple.

```reason
type item =
| Notes(string)
| Course(string, bool);

let myItem = Course("Reason React", false);

switch(myItem) {
| Notes(text) => text
| Course(text, ok) =>
  "The course " ++ text ++ " is done? " ++ string_of_bool(ok)
};
```

Variant 最迷人的地方就是狀態控制非常完美，減少很多 bug 的產生。在 http request/response 中以下程式碼可能會有弱點：

```reason
/* 定義 http request 類型 */
type request = {
  loading: bool,
  error: bool,
  name: string,
};

/* 現實中三種可能的類別 */
let loadingRequest = {
  loading: true,
  error: false,
  name: "",
};

let successResponse = {
  loading: false,
  error: false,
  name: "Jay Chung",
};

let failureResponse = {
  loading: false,
  error: true,
  name: "",
};

/* UI 根據三種苦可能的回應來顯示 UI */
if (myRequest.loading) {
  "Loading..."
} else if (myRequest.error) {
  "Something went wrong"
} else {
  "Welcome, " ++ myRequest.name
};
```

你以為你完成需求了嗎？ Bug 總是在意想不到的情形下發生（*PM 太天真？還是工程師太老實？*），也就是 loading 和 error 同時發生：

```reason
let impossibleResponse = {
  loading: true,
  error: true,
  name: "",
};
```

依照剛剛的邏輯 UI 卻顯示 **"Loading..."**, 邏輯錯誤已經發生。
還有更多意想不到的情形，包含 error true 但有 name, loading true 也有 name 的情形，還有 成功 response 但沒有 name 的情形（這種情形會造成 UI broken）。

* **Variants with Pattern Matching**

使用 pattern matching 改寫以上程式碼：

```reason
type request =
| Loading
| Error
| Success(string);

/* response status let binding */
let request = Success("Jay");

switch (request) {
| Loading => "Loading..."
| Error => "Something went wrong"
| Success(name) => "Welcome, " ++ name
};
```

萬一沒有 cover 到所有的 state？ compiler 會抱怨：

```reason
switch (request) {
| Loading => "Loading..."
| Success(name) => "Welcome, " ++ name
};
/* Warning 8: this pattern-matching is not exhaustive.
Here is an example of a value that is not matched:
Error */
```

萬一 Success 沒有名字？ 加上這個 case:

```reason
switch (request) {
| Loading => "Loading..."
| Error => "Something went wrong"
| Success("") => "Your name is missing"
| Success(name) => "Welcome, " ++ name
};
```

* More on Variant: the **option** type

Reason 當中沒有 `Null` 這種類型，也沒有 `Any`, 使用以下兩個 constructor, **None** 以及 **Some** :

```reason
let noOne = None;
/* let noOne: option('a) = None; */
let someOne = Some("Jay Chung");
/* let someOne: option(string) = Some("Jay Chung"); */
let someInt = Some(42);
/* - : option(int) = Some(42) */
```

他們骨子裡都是 `option` type.

* **function**

宣告 function 跟 JavaScript 非常類似：

```reason
() => 3;
/* - : unit => int = <fun> */

let add = (x, y) => x + y;
/* - : (int, int) => int = <fun> */
```

Reason 會自動幫你做 type inference, 不用明確宣告，骨子裡長這樣：

```reason
let add = (x: int, y: int): int => x + y;
```

你也可以在 let binding 裡面寫 expression, 編譯器會根據運算內容來決定 parameter 的參數類型：

```reason
/* 根據以下運算內容可以得到 x: float, y: int */
let add = (x, y) => {
  let z = float_of_int(y);
  z +. x;
};
/* let add: (float, int) => float = <fun> */
```

注意：在 Reason 中 **沒有 early return**, 也沒有 **return** 寫法，而是自動 return block 中的最後一個 expression.

* **Partial Application**

在 Reason 中所有 function 都是 **curry** function:

```reason
let add = (x, y) => x + y;
/* let add: (int, int) => int = <fun>; */
let addFive = add(5);
/* let addFive: int => int = <fun>; */
addFive(10);
/* - : int = 15 */
```

由於 curry function, 以下兩者寫法相同：

```reason
let someAdd = (x, y) => x + y * 10;

/* 寫法等價 */
someAdd(3, 4) /* 43 */
someAdd(3)(4) /* 43 */

/* 寫法等價 */
(x, y) => x + y;
x => y => x + y;

/* 寫法等價 */
let multiply = (x, y, z) => x * y * z;
multiply(1, 2, 3); /* 6 */
multiply(1, 2)(3); /* 6 */
multiply(1)(2, 3); /* 6 */
multiply(1)(2)(3); /* 6 */
```

partial application 常用於 List 運算， 搭配 `map` function:

```reason
let add = (x, y) => x + y;
let num = [1, 2, 3, 4, 5];
List.map(add(10), num);
/* - : list(int) = [11, 12, 13, 14, 15] */
```

* **Label Parameters**

Label parameter 可以任意指定參數代入（無須依照順序），搭配 partial application 也是非常好用。

```reason
let name = (~firstName, ~lastName) => {
  firstName ++ " " ++ lastName;
};

name(~firstName="Jay", ~lastName="Chung");
/* "Jay Chung" */

name(~lastName="Chung", ~firstName="Jay");
/* "Jay Chung" */

name(~lastName="Chung")(~firstName="Jay"); /* Partial Application */
/* "Jay Chung" */

```

## References

* [官方 QuickStart](https://reasonml.github.io/guide/javascript/quickstart)
* [BuckleScript](https://github.com/BuckleScri·pt/bucklescript)
* [OPAM](https://github.com/ocaml/opam)

### Videos

* [Mixing ReasonML into your React apps, Robbie McCorkell - React London September 2017](https://www.youtube.com/watch?v=gZweJw_egaE&list=PLW6ORi0XZU0BL3Up9mXpP75ilJBDOjMsQ&utm_content=buffera6439&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer)