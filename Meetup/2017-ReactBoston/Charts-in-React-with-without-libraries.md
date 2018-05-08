# Charts in React w/ & w/o libs

> @Christina Hsu Holland

Use libraries? Which browser drawing API?

Custom        | ----------    | Standard
--------------|---------------|----------------
Low level lib | Roll your own | High level lib


## High-level Libraries

for standard cases:

* Highcharts, Flot, C3, NVD3, Plotly, etc...
* React-specific: Victory, Recharts
* 無須重造輪子

## Low-level Libraries

for flexibility:

* d3
* power tools to create complex interactive & animated data vix

## Roll your own charts

* Concepts not standard enough for a high-level lib
* Don't need power of D3 (animations, math helpers)
* Timing:
  * Chart interact w/ other things on the page
    - maybe integrate with React
  * To minimize dependencies
    - bundle sizes & maintenance worries
  * Learn some web graphics fundamentals

## Which browser drawing api?

paradigm    | example
------------|---------------------------------
declarative |
            | regular html (div and such)
            | SVG (vector-based DOM elements)
            | Canvas (raster-based)
            | WebGL (super low-level)
imperative  |

### regular html

* basic html elements
  * mostly, divs. (直方圖)
* great in hostigrams (only rectangles)
  * x/y axes are annoying as hell
  * use libs instead of reinventing the wheel badly...
* Pros & Cons:
  * Pros:
    - First-class support in `React`!
    - interactivity and accessibility are much simpler
    - HTML was born to do text
  * Cons:
    - You can only draw rectangles! (circle? triangle? you genius....)
    - Thousands of DOM elements will choke performance

### SVG (Scalable Vector Graphics)

* A bunch of shapes that are DOM elements
* Pros:
  - Each item is a DOM elements, can be recognized by React & incorporated into virtual DOM diffing
  - Selection & mouse events are easy.
  - Accessibility is doable, but may take some extra efforts
* Cons:
  - Text is more bothersome than with divs (positioning), less bothersome than with Canvas
  - DOM elements! large number = performance issues

<P.S> 一頁 12 個訊號圖（每一個都是超級多的直方圖，每隔都放上 tooltip 顯示數值）使用 SVG 花費 5 分鐘渲染，然而 Canvas 只需要花 10 秒。

### Canvas

A JavaScript-driven Microsoft paint window(小畫家)

* Pros
  - Draw as many `items` as you want
  - not individual objects in memory but only `pixels`.
* Cons:
  - no awareness of different `elements` after they're drawn, which makes interaction tricky.
  - Canvas draw commands are `imperative`, and nothing inside \<canvas\> is recognized by React. (need to manually track its state and handle when to render/update)
  - Text is just pixels, so... no font optimizations!

### WebGL

* Pros
  - Pretty much draw anything you can imagine (2D & 3D)
  - Best performance
* Cons
  - Same as Canvas
  - Very challenging to work with.
  - Overkill for most common cases.
    - always special cases
    - more useful on VR

## Libraries + React conflicts

Modify React components is easy, but modifying library charts can be `tricky`! You always work around with chart libraries' one way flow.

* Chart libraries:
  - often could be modified by custom APIs
  - often built with `one-way` flow in mind (data -> drawing)
  - manipulate the DOM outside of React (would anger React!)
  - can be mitigated/avoided by a React library wrapping the charting library (inception!)

* Articles & References:
  - [How (and why) to use D3 with React](https://hackernoon.com/how-and-why-to-use-d3-with-react-d239eb1ea274)
  - [How to integrate React and D3 – The right way](http://www.adeveloperdiary.com/react-js/integrate-react-and-d3/)
  - [playing-with-react-and-d3](https://github.com/freddyrangel/playing-with-react-and-d3)

### work around DOM manipulation conflicts

D3 modifies the DOM (like jQuery) because most cases libraries require both calculating & drawing and would anger React.

There are approaches:

1. Chart library draws
  * black-box components
  * React only renders container (root svg), chart library creates the rest in `componentDidUpdate`
  * Block chart updates with `shouldComponentUpdate`
  * Pros:
    - Make use of original chart library APIs
    - Works fine
    - Easiest when visualization is already implemented
  * Cons
    - Harder for React to know what's going on inside.
    - not idiomatic on React
    - a bit nasty
2. React draws
  * D3 for the Math, React for the DOM
    * Library 只負責 calculations (computation only) and formats
  * React rules and renders all DOM elements (divs or SVGs) in JSX and relevant attributes (for chart library use)
  * Pros
    - make use of React. Consistent with React way
    - easy to manage elements' states
  * Cons
    - a lot of hard work and refactors (chart library reimplementations)
    - lose out on lots of automated drawing
    - only work for SVG and HTML
3. React-based libraries
  * do mostly `Approach 2`. library takes care of you
  * Recharts, Victory (both wrap D3)
  * Pros
    - get robust working product out in a timely manner
  * Cons
    - lose the joy of discovery

D3 sub-modules

* Non-DOM related modules
  * Arrays (d3-array)
  * Chords (d3-chord)
  * Collections (d3-collection)
  * Colors (d3-color)
  * Dispatches (d3-dispatch)
  * Forces (d3-force)
  * Easings (d3-ease)
  * Number Formats (d3-format)
  * Hierarchies (d3-hierarchy)
* DOM-related modules
  * Selections (d3-selection)
  * Transitions (d3-transition)
  * Axes (d3-axis)
  * Zooming (d3-zoom)
  * Dragging (d3-drag)
  * Brushes (d3-brush)
  * Geographies (d3-geo)
  * Shapes (d3-shape)
* React related d3 libraries
  * Victory
    - easy to get started
    - zoom & voronoi
    - React Native option
  * Recharts
    - Really well tested
    - Charts plus legend, tooltip and brush
    - great documentations
  * [React Vis](https://github.com/uber/react-vis)
    - Uber project
    - react-motion animations