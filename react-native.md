# React Native Notes

> [Official Documentation](https://facebook.github.io/react-native/docs/getting-started.html)

### Development Dependencies & Setup
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
    3. npm install --save-dev ``esllint-config-rallycoding``
    4. Add ``.eslintrc`` file:
      * Paste a config object:
      ```json
        {
          "extends": "rallycoding"
        }
      ```
  * __``Sublime Text``__
  * __``VSCode``__



### Get Started
```shell
  react-native init ProjectName # Change ProjectName at your will
  cd ProjectName
  react-native run-ios # Kick off iOS app
```
