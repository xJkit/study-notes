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

* **expression**
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

## References

* [官方 QuickStart](https://reasonml.github.io/guide/javascript/quickstart)
* [BuckleScript](https://github.com/BuckleScript/bucklescript)
* [OPAM](https://github.com/ocaml/opam)

### Videos

* [Mixing ReasonML into your React apps, Robbie McCorkell - React London September 2017](https://www.youtube.com/watch?v=gZweJw_egaE&list=PLW6ORi0XZU0BL3Up9mXpP75ilJBDOjMsQ&utm_content=buffera6439&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer)