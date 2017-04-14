# React Native Notes
  * [Official Documentation](https://facebook.github.io/react-native/docs/getting-started.html)
  * [大陸人翻譯好的好讀版文件](http://reactnative.cn/)
  * [各種別人寫好的元件](https://github.com/jondot/awesome-react-native)
  * [F8 2016 App 官方的完整範例](http://makeitopen.com/)
  * [React Native Taiwan 社群](https://www.facebook.com/groups/1084440818288147/)
  * [React Native Community 社群](https://www.facebook.com/groups/react.native.community/?fref=ts)

## Development Dependencies & Setup
1. ``XCode``
  * Apple Official IDE for iOS devices
  * used for packaging the code + react-native library
2. ``Node`` & ``npm``
3. ``HomeBrew``
4. ``Watchman``
  * watch files on the HDD and wait for them to change.
  * install via ``brew``:
  ```shell
    brew install watchman
  ```
5. ``RN-cli``
  * used to generate new React Native projects.
  * install __globally__ via ``npm``:
  ```shell
    npm install -g react-native-cli
  ```
6. __ESLint__ setup:
  * __``Atom``__:
    1. Base on the original lint system: ``linter``
    2. Use Atom preference to install ``linter`` and ``linter-eslint``
    3. npm install --save-dev ``eslint-config-rallycoding``
    4. Add ``.eslintrc`` file:
      * Paste a config object:
      ```json
        {
          "extends": "rallycoding"
        }
      ```
  * __``Sublime Text``__
  * __``VSCode``__



## Get Started
```shell
  react-native init ProjectName # Change ProjectName at your will
  cd ProjectName
  react-native run-ios # Kick off iOS app
```

##### Directory Structure:
```shell
.
├── __tests__
├── android
├── index.android.js
├── index.ios.js
├── ios
├── node_modules
├── package.json
└── yarn.lock
```
where ``index.ios.js`` and ``index.android.js`` are the entry files for the ``ios`` and ``android`` directories respectively.

#### React and React Native libraries
1. ``React``:
  * Knows how a component should behave
  * Knows how to take a bunch of components and make them work together
2. ``React Native``:
  * Knows how to take the output from a component and place it on the screen
  * Provides default core components(image, text, ...)
In the matter of fact, ``React Native`` code looks like the ``React``.

#### Difference between ``React`` and ``React Native``
1. Render to the screen:
  * ``React`` 使用 ``ReactDOM`` 而 ``ReactNative`` 則為 ``AppRegistry.registerComponent``:
  ```js
    AppRegistry.registerComponent('moduleName', () => App);
    // moduleName is supposed to be the same name as the project folder.
  ```
  相同的是，都只有 Root Component 需要 AppRegistry(或 ReactDOM.render)
2. Styling:
  * ``React`` 上分為 inline, block 與 inline-block, 幾乎適用所有 CSS styles.
  * ``React Native`` 上的 UI 元件有各自適用的 Styles, 並非套用網頁的規則。
   * 使用 camelCasing 而不是 dash-casing 的方式
   * 使用 flex box 來做排版
   * 沒有分開的 CSS 檔案，而是直接寫在相同檔案的一個物件
   * 使用類似 ``CSS Modules`` 的方式作為 inline-css, 透過 component 統一 props: ``style``(單數)
3. ``React Native`` 的 flex box:
  * style 屬性物件使用 camelCasing，value使用 __string__ 或 **number**
  * 不需要宣告 {``display: 'flex'``},預設就是以 flex box 作為排版引擎
  * Default 數值的不同：
    * 在 React Native 中基本上使用 ``flexDirection``, ``alignItems``, ``justifyContent`` 已經滿足大家的需求
    * 預設 ``flexDirection``: **'column'** (而不是 **'row'**)
    * 預設 ``alignItems``: **'stretch'** (而不是 **'flex-start'**) --> cross axis 排版
    * ``flex``: 只能填入一個數值(意義為 ``flex-grow``)
  * [更多官方佈局說明請點這裡](http://reactnative.cn/docs/0.36/layout-with-flexbox.html)
4. iOS 獨特的 Styles:
  * [shadow props](https://facebook.github.io/react-native/docs/shadow-props.html)
  * elevation
5. Debugging:
  * `React` 為網頁應用程式，使用 ``console.log`` 或是 ``debugger;``設定中斷點，在 Chrome DevTools 中操作非常方便。搭配 ``React``, ``Redux DevTools`` 等 Chrome 外掛風味更佳，
  * ``React Native`` 在 iOS Simulator 上開發，必須使用瀏覽器 remotely 去偵測。在 Simulator 中使用 ``cmd + D`` 選擇 __``Debug JS Remotely``__ 並開啟瀏覽器 debug 視窗。後續與 ``React``方式相同。
6. Networking:
  * ``React``:
    * 網頁應用程式使用 __fetch api__ 需要安裝 [isomorphic-fetch](https://github.com/matthew-andrews/isomorphic-fetch)
    * 瀏覽器有 ``CORS`` 同源政策限制
  * ``React Native``:
    * 原生 React Native 提供 Fetch API, 毋需導入任何第三方函式庫
    * 直接使用 ``Fetch`` 會讓 eslint 發生抱怨，加入以下程式碼：
      ```json
      "env": {
        "browser": true
        }
      ```
    * Apple 原生有網路安全協議 ``NSAppTransportSecurity``,有一下三種解法：
      1. 修改 ``info.plist``, 允許 App 通過造訪任意的 __http__ 請求, 請參見 [React Native: Networking](https://facebook.github.io/react-native/docs/network.html)
      2. 改成 __https__ 協議

      > 開發時直接使用 localhost，比較方便。

7. TextInput 處理方式：
  * React 就像網頁一樣，使用者在 input 輸入， onChange 改變 state
  * ReactNative 的 TextInput 要明確指定 value 這個 props 等於 state 才行

8. Rendering the list:
  * React 使用 map function
  * React-Native 使用原生 ListView component

### React Native Style Tricks

1. [Image](https://facebook.github.io/react-native/docs/images.html) 的 tricks:
  * 使用 ``<Image />``
  * source 屬性丟入一個物件， uri 寫入檔案位置
  * 必須標示 width 與 height 圖片才會顯示
  * 要讓圖片 100% 放大，使用以下 tricks:
    1. height: 300 (先標示固定高度)
    2. flex: 1 (讓 flexbox item 膨脹)
    3. width: null (寬度代入 null)
2. [ScrollView](https://facebook.github.io/react-native/docs/using-a-scrollview.html)
  * 當內部內容溢出時需要
  * 先定義 ScrollView 的 component
    * 通常是使用 map 渲染清單的那個 component
    * 舊版 bug 是當你使用 scrollView 時 root component 必須代入 { flex: 1 } 的 style 修正
3. 製作 Button:
  * 不一定要用原生的 iOS ``<Button />``，可以自行製作
  * 使用 Touch＊ 等相關的 Component 來處理使用者 touch events:
    * [TouchableHighlight](https://facebook.github.io/react-native/docs/touchablehighlight.html)
    * [TouchableNativeFeedback](https://facebook.github.io/react-native/docs/touchablenativefeedback.html)
    * [TouchableOpacity](https://facebook.github.io/react-native/docs/touchableopacity.html)
    * [TouchableWithoutFeedback](https://facebook.github.io/react-native/docs/touchablewithoutfeedback.html)
