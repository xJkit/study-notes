# Webpack 打包工具筆記

Webpack 是前端非常好用的必備打包工具，所有神奇的事情都發生在一個設定檔 ``webpack.config.js``中。但是由於 Webpack 太過強大，讓第一次看見設定檔的工程師嚇得漏尿，就算花大量精力看懂，時間一久也是漸漸淡忘。因此 J 在此做個筆記以紀錄我對 webpack 的理解。

Webpack 解決痛點：

1. 傳統前端通過 ``<script />`` 引入太多第三方函式庫，相依難以管理，又不方便更新，智障才一個個引入。
2. 承上，包含 ``css`` 甚至是所有的圖片與其他資產都能打包在一起。
  * 在 React 開發時 ``<img>`` 於 .js 檔中使用 ``import`` 而 ``background-image`` 中 url 是在 css 中設定
3. 統一使用 ``npm`` 管理所有 js 套件，並搭配 ``webpack``與強大 loaders 群與 plugins 外掛工具來打包一切。

### Reference
* [深入了解 Webpack Plugins](https://rhadow.github.io/2015/05/30/webpack-loaders-and-plugins/)
* [如何與 Webpack Environment Variables 成為好友](http://mz026.logdown.com/posts/385999-webpack-environment-variables)
* [webpack 常用插件](http://www.jianshu.com/p/1eefaeaf6874)

### 深入了解 Plug-ins
* Hot Module Replacement Plugin
* CommonsChunkPlugin
  * ``new webpack.optimize.CommonsChunkPlugin(options)``
  * 讓 entry 有多個而最終成為 bundle.js 之前提出所有共用模組並放在另外一個 .js 檔案中（必須在 index.html 中另外引入，不然共用模塊就看不到啦）。
  * [參考說明文件](https://webpack.toobug.net/zh-cn/chapter3/common-chunks-plugin.html)
  * 適用場景：
    * 分離第三方套件與專案內部程式碼。由於專案內部程式碼會不斷做更新，而第三方套件一般來說修改的頻率較低，如果沒有與第三方套件分開打包的話，使用者在每一次更新後都必須下載第三方套件加上專案內部程式碼的一整包檔案，使專案運行起來的速度變慢，並降低使用者體驗。
  * 範例：

    ```js
      var path = require('path');
      var webpack = require('webpack');
      var node_modules_dir = path.resolve(__dirname, 'node_modules');

      var config = {
        entry: {
          app: path.resolve(__dirname, 'app/main.js'),
          vendors: ['react', 'jquery', 'bootstrap']
        },
        output: {
          path: path.resolve(__dirname, 'dist'),
          filename: 'app.js'
        },
        module: {
          loaders: [{
            test: /\.js$/,
            exclude: [node_modules_dir],
            loader: 'babel'
          }]
        },
        plugins: [
          // 第一個參數對應到 entry 內的屬性名
          // 第二個參數是輸出檔案的名稱
          new webpack.optimize.CommonsChunkPlugin('vendors', 'vendors.js')
        ]
      };

      module.exports = config;
    ```
    以上設定會打包成 ``app.js`` 與 ``vendors.js`` 兩個檔案
* ProvidePlugin
  * ``new webpack.ProvidePlugin(definitions)``
  * 類似 webpack alias，透過 ``definitions`` 定義變數並自動加載模組
  * 常用於 jQuery, Bootstrap 或 Foundation 等第三方函式庫或框架
  * 範例：

    ```js
      new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: 'jquery',
        'window.jQuery': 'jquery',
        'root.jQuery': 'jquery',
      })
    ```

* NoErrorsPlugin
  * ``new webpack.NoErrorsPlugin()``
  * 跳過編譯時有錯誤的程式碼，保證打包結果不會出錯。
* Extract Text Plugin
  * ``new ExtractTextPlugin([id: string], filename: string, [options])``
  * id: 唯一識別變數，自動生成。
  * filename: 輸出的檔案名稱，可以通過 ``[name]``/``[id]``/``[contenthash]``自定義
* UglifyJsPlugin
  * ``new webpack.optimize.UglifyJsPlugin([options])`` 更多 options(https://github.com/mishoo/UglifyJS2#usage)
  * 解析、壓縮並醜化所有的 js
* [DefinePlugin](https://webpack.github.io/docs/list-of-plugins.html#defineplugin)
  * 負責處理環境變數的問題
  * 環境變數適合在 webpack 打包時丟入，而不是透過 node 的執行階段才丟。
  * 使用 webpack 打包過的 ``bundle.js`` 在執行期間透過 node 丟入變數是不會理你的，必須透過此 plugin 在打包時 pass 進去。
* DedupePlugin
  * ``new webpack.optimize.DedupePlugin()``
  * 第三方函式庫有自己的相依套件，彼此也可能交互相依，透過此 plugin 找出並刪除重複

* [HtmlWebpackPlugin](https://github.com/jantimon/html-webpack-plugin)
  * 動態產生 index.html 並支援 Extract Text Plugin 自動將打包完後的 js 與 css 檔加入
  * 可自訂 HTML 如 index.template.html 透過樣版引擎設定變數。

* [FaviconsWebpackPlugin](https://github.com/jantimon/favicons-webpack-plugin)
  * 將 png 圖檔為各大行動平台自動產生 favicons
  * 可搭配 html webpack plugins 風味更佳