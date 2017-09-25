# Recompose

* React 版本的 Lodash

why

* 多寫一些 pure component (F.P)
* easy to test

prerequisite

* curry function
* function composition
* higher order function (& component)
  * 吃 function 回傳 function -> HOF
  * 吃 component 回傳 function -> HOC
  * `connect()`, `withRouter()`, `withTheme()` 都是 HOC
  * Recompose 幾乎都是 HOC

常用的 API:

* pure
* mapProps
* withState
* withHandlers
* withStateHandlers
* mapPropsStream (observable)

scenario:

* form validation (HOC)
  * 表單驗證的 local state 不用先傳到 store 直接在 local state 驗證
  * pure functional component, 無須 component class
* apollo