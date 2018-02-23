# OCaml 起步走

OCaml 原名 Objective Caml, 是 ML (functional language) 的一種方言，主要是函數式編程，但也可以寫成物件導向。

要在你的電腦運行 OCaml, 先安裝 `ocaml` 以及 `opam` 再說吧！

以 Mac 為例：

```sh
brew install opam ocaml
```

For other installation guide, please check this [OCaml Installation Guide](https://ocaml.org/docs/install.html).

## 一些基本的先知

* `opam`
  - OCaml 的套件管理系統
  - 常用指令：
  ```sh
    opam install <package> # 安裝新程式或套件
    opam switch <compiler-version> # 切換 ocaml 編譯器版本
    eval (opam config env) # opam 安裝完套件後必須執行此程式以將新的套件程式加入路徑中
  ```
  - 要運行 OCaml 先安裝 compiler, 例如：
  ```sh
    opam switch 4.06.1
  ```

* `ocamlfind`
  - a program that predates `ocamlc` & `ocamlopt`
* `ocamlbuild`
  - a tool that help OCaml programs.
* `oasis`
  - a tool that helps abstract usage of `ocamlfind` & `ocamlbuild`.
  - 減少寫 Makefile. 直接用 `oasis` 會方便很多!
* `merlin`
  - a program for OCaml code completion
  - add `.merlin` file to do so
  ```sh
    opam install merlin
  ```
* `utop`
  - 一種強化版本的 ocaml repl.
  - 比原生的 repl 好用很多,包含自動補齊、歷史導航等等。
  ```sh
    opam install utop
  ```


### References

* [OCaml tutorials](https://ocaml.org/learn/tutorials/)
* [OCaml 入門教程](https://zh.wikibooks.org/zh-tw/User:Gqqnb/OCaml%E5%85%A5%E9%97%A8%E6%95%99%E7%A8%8B/%EF%BC%88%E4%B8%80%EF%BC%89%E7%AE%80%E4%BB%8B)