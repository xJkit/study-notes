# Reason React

### Before you begin

* Global Binaries (reason CLI):

  * [Global Installation](https://reasonml.github.io/docs/en/global-installation.html)
    ```sh
    # Mac User
    npm install -g https://github.com/reasonml/reason-cli/archive/3.0.4-bin-darwin.tar.gz
    ```
  * Or you can use `opam` for OCaml developers.
  * You can check [reason-cli](https://github.com/reasonml/reason-cli) for more detail.
  * When you globally install `react-cli`, the following tools are included:
    * ocamlmerlin
    * ocamlmerlin-reason
    * refmt
    * ocamlrun
    * ocamlc/ocamlopt
    * ocamlfind

* Editor Plugin:
  * VSCode: [vscode-reasonml](https://github.com/reasonml-editor/vscode-reasonml)
  * Other editors check [Official Guide](https://reasonml.github.io/docs/en/editor-plugins.html)

### Project Bootstrap

You can use `create-react-app` with reason scripts like so:

```sh
  npx create-react-app --scripts-version reason-scripts
```

## References

* [a-first-reason-react-app-for-js-developers](https://jamesfriend.com.au/a-first-reason-react-app-for-js-developers)
