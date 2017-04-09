# Webpack 2 學習筆記

1. Web page 兩大形式：
  * Server Side Templating
   * 伺服器渲染完整 HTML page
   * 少量 JavaScript
  * Single Page Application
    * 大量 JavaScript 渲染畫面
    * 和 Server 以 RESTful 或 GraphQL 傳值

2. Webpack 解決痛點：
  * 大量模組化的 js 有讀區順序的問題，不需確保 loading order 並且有彼此相依
  * 讀取一個網頁而有多個 requests 外連 js scripts 對於行動裝置來說會降低網頁效能

3. JavaScript 模組化系統三大方式：
  * Common.js - 使用 require, module.exports (npm 實作)
  * AMD - 使用 require, define
  * ES2015(ES6) - 使用 import, export

### Webpack 2 v.s 1
  * es6 support
    * 不需要 babel 轉譯成 commonJS (require 無法最佳化)
    * 在 ``.babelrc`` 中 presets -> env -> modules -> false
  * tree shaking 最佳化
    * 打包時將你用不到的程式碼標記起來 -> 經過 ``UglifyJS``後會被丟掉 (減少 bundle size)
    * commonJS 的 require 不 work (因此建議使用 import)
    * PS: 在 import 時為了縮小 bundle size, 建議不要 import entry

      ```js
        import { sum } from 'lodash'; //會增加 bundle size
        import sum from 'lodash/sum'; // 建議作法
      ```
  * performance 強化
    * 可參考 webpakc 1 to 2 migration
  * dynamic code splitting
    * 動態 import()
    * 在 SPA 時不需要 import 整個相關的 libraries, 有用到時在 import
    * 參考： ``react-async-component`` 也做到類似的事情


## Webpack 2 config:

注意：``use`` 相當於 ``loader``, 但是當你必須要設定 ``options``給 loader時， ``loader`` 會在 ``use``之下。

``use`` 接單數相當於 ``loader``, 參數擺字串； 而接複數則擺 array, 相當於 ``loaders``.

```js
const path = require('path);
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const config = {
  entry: './src/index.js',
  output: {
    path: path.resolve(__dirname, 'build),
    filename: 'bundle.js,
    publicPath: 'build/'
  },
  module: {
    rules: [
      {
        use: 'babel-loader',
        test: /\.js$/,
      },
      {
        use: ['style-loader', 'css-loader'],
        test: /\.css$/,
      },
      {
        use: [ // 設定 options, 在此 use 相當於 loaders
          {
            loader: 'url-loader',
            options: { limit: 40000 }
          },
          'image-webpack-loader'
        ]
        test: /\.(jpe?g|png|gif|svg)$/
      }
    ]
  }
}
```

## Handling Project Assets

* Loaders:
  * 處理 CSS：
    * css-loader: 了解如何去處理 css imports
    * style-loader: 把 css imports 加入 html
  * 處理圖片：
    * image-webpack-loader: 壓縮圖片
    * url-loader: 
      * 圖片很大 -> include raw images in the output directory
      * 圖片很小 -> include raw images in bundle.js
  * 有關 ``output.publicPath``:
    * loader 在打包資產時，除了原本的 url, 還會另外把 ``output.publicPath`` 加在前面


* plugins:
  * extract-text-webpack-plugin: 將 css 從 js 獨立出 .css 檔案
  * 


## FAQ
* Q: Webpack 在 nodejs 中 dependencies 與 devDependencies 中存在的意義？
  * 

## References

* [Webpack Official Documentation](https://webpack.js.org/configuration/)


