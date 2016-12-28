# React Native Notes

> [Official Documentation](https://facebook.github.io/react-native/docs/getting-started.html)

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
