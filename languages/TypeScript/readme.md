# TypeScript 學習筆記

## Module

一個 ts 檔案中只要包含關鍵字 `import` 或是 `export` 的話，都會被是為 Module! 換言之，倘若沒有這些關鍵字，都會自動變成 global scope。

TypeScript 中可同時使用 Es Module 和 commonJS 的寫法，但是寫法稍有差異。

### ES Modules

ES Module 在 TypeScript 中跟寫 一般的 ES6 毫無差異：

```ts
// utils.ts
export const foo = () => {};
export const bar = () => {};
export default () => {};
```

兩個 export 還有一個是 default, 對於 import 進來是毫無差異：

```ts
// index.ts
import EsUtil, { foo, bar } from './utils';
EsUtil(); // default anonymous function
foo();
bar();
```

注意： 當一個 module 沒有 default export 的時候必須寫：

```ts
import * as EsUtil from './utils';
```

### Common JS

在 common js 中有個概念是 `exports` 物件，所有的 module 都可以塞在裡面導出：

```js
exports.foo = () => {};
exports.bar = () => {};
```

`exports` 其實就是一個方便，他真正是指向 `module.exports`. 每一個 module 在 import 前其實都做了這樣的事情：

```js
  var exports = module.exports;
```

因此，除了使用 `exports` 這個物件之外，也可以直接使用 `module.exports`:

```js
module.exports = { foo, bar }
```

但是由於 `exports` 是指向 `module.exports` 所以兩者同時使用的時候 exports 物件所包含的 module 都會失效。

在 TypeScript 中，不可以直接寫 commonJS, 而是使用 `export =` 以及 `import module = require('./module')`

```ts
// util.ts
const foo = () => {}
const bar = () => {}
export = { foo, bar }; // 相當於 module.exports = { foo, bar }
```

在 import 的過程：

```ts
import Util = require('./Util');
```

以上的寫法相當於

```js
var commonUtil = require("./utils_commonjs");
```

## Built-in Declarations

在 TypeScript 2.0+ 新增了 lib 功能，也就是可以直接 import 一些內建的定義檔。使用方式是在 `tslint.config` 裡面新增 lib:

```json
  "compilerOptions": {
    "lib": ["es2015", "es5"] /* Specify library files to be included in the compilation. */
  }
```

像是 `TemplateStringsArray` 就是給 template strings 在用的 Type, 來自 **es5**.

更多的定義檔可參考[這裡](https://github.com/Microsoft/TypeScript/tree/master/lib)。

## References

* [TypeScript Deep Dive](https://legacy.gitbook.com/book/basarat/typescript/details)
* [TypeScript Handbook](https://zhongsp.gitbooks.io/typescript-handbook/)
* [TypeScript 入門教程](https://legacy.gitbook.com/book/xcatliu/typescript-tutorial/details)
* [swift-is-like-typescript](https://alhazmy13.github.io/swift-is-like-typescript/)
* [TypeScript Style Guide](https://basarat.gitbooks.io/typescript/content/docs/styleguide/styleguide.html)
* [TypeScript What's New](https://github.com/Microsoft/TypeScript/wiki/What's-new-in-TypeScript#including-built-in-type-declarations-with---lib)
* [TypeScript 2.0+ lib 內建定義檔](https://github.com/Microsoft/TypeScript/tree/master/lib)