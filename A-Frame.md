# A-Frame 隨手筆記

Virtual Reality in the Web.

1. 使用 A-Frame 的優點：
  * 減少大量的 js 程式碼
  * 使用 ``Custom Element`` 類似 React Component 的語法去實作

    ```html
      <a-scene>
        <a-box position="1 0 0" rotation="..." />
      </a-scene>
    ```

2. 運作原理：
  * 透過設定 DOM element 的 attribute (宣告式語法)

3. 常用 primitives:

    ```html
      <a-scene></a-scene>
      <a-animation></a-animation>
      <a-light></a-light>
      <a-camera></a-camera>  
    ```

## References
* [Awesome-A-Frame](https://github.com/aframevr/awesome-aframe)
* [A-Frame Documentation](https://aframe.io/docs/0.5.0/introduction/getting-started.html)
* [A-Frame Intro](https://aframe.io/docs/0.5.0/introduction/)
* [aframe-react](https://github.com/aframevr/aframe-react)
* [WebGL and A-Frame](https://solutiondesign.com/blog/-/blogs/63714)
* [A-Frame + React + Redux](https://medium.com/immersion-for-the-win/hands-on-with-virtual-reality-using-a-frame-react-and-redux-bc66240834f7)