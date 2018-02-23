# REASON 學習筆記

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

執行 REASON (副檔名 .re) 的方式有兩種：
1. 使用 REASON-to-JavaScirpt Compiler:  [BuckleScript](https://github.com/BuckleScript/bucklescript)
  ```sh
    npm install --global bs-platform
    bsb -init hello-reason-app -theme basic-reason
  ```
2. 使用 OCaml 與 `OPAM`:
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

```reason
let greeting = "hello!";
```

## References

* [官方 QuickStart](https://reasonml.github.io/guide/javascript/quickstart)
* [BuckleScript](https://github.com/BuckleScript/bucklescript)
* [OPAM](https://github.com/ocaml/opam)

### Videos

* [Mixing ReasonML into your React apps, Robbie McCorkell - React London September 2017](https://www.youtube.com/watch?v=gZweJw_egaE&list=PLW6ORi0XZU0BL3Up9mXpP75ilJBDOjMsQ&utm_content=buffera6439&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer)