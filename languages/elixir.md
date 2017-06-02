# Elixir 學習筆記

1. Install

```sh
  brew update
  brew install elixir
```
2. command line tools:
  * mix
  * iex (interactive elixir shell)

3. Mix
  * elixir command line tool
  * 功能：
    * Create Projects
    * Compiles projects
    * Run 'Tasks'
    * Manages Dependencies

4. iex
  * iex -S mix
  * recompile

5. `defmodule`
  * a collection of methods and functions
  * define a function using `def` (使用 underscore 開頭的 function 將被隱藏)

6. Variables:
  * 可以直接指定，不需宣告資料性別
  * 有一些 reversed words
  * interpolation: **#{}**

7. Data Types:
  * Numerical types
    - Integers, Floats

    ```elixir
      42 # 10進位
      0o52 # Octao, 42 (prefix: 0o)
      0xF1 # Hex, 241 (prefix: 0x)
      0b1101 # Bin, 13 (prefix: 0b)
    ```
  * Atoms
    - 就是 constant. name 就是 value
    - 使用 colon(:) 宣告

    ```elixir
      :hello
    ```
  * Boolean
    - 跟 atoms 宣告方法相同
    
    ```elixir
      :true
      :false
    ```

  * Strings
    - 使用 double quotes 

    ```elixir

      "Hello, world"
      
      """
        Hello
        World
      """
    ```
 Collecitions

  * Binary
    - 使用 ``<< >>``
    - 逗號區隔不同數值

    ```elixir
      <<65, 36, 21>>
      <<65, 255, 289::size(15)>>
    ```

  * Lists
    - 就像陣列

    ```elixir
      [42, "Hello, world", :bowwow, << 32 >>, true]
    ```

  * Tuples
    - 就像 object

    ```elixir
      {
        1,
        "Hello, World",
        :bowwow
        true
      }
    ```

### 釐清 Object-Oriented v.s Functional Programming Approach

以 撲克牌為例：

#### Object Oriented Approach

有 Card 以及 Deck 兩個 classes:

  1. Card Class
    * this.suit <String>
    * this.value <String>
  2. Deck Class
    * Deck Instance
      * this.cards < [Card] ... >
      * shuffle <Function>
      * save <Function>
      * load <Function>

  ```sh
    deck = new Deck; # <Deck>
    deck.cards # [ <Card1>, <Card2>, <Card3> ]
    deck.shuffle # [ <Card2>, <Card1>, <Card3>]
    deck.deal # <Deck[ <Card1>]>
  ```


#### Functional Programmming Approach (以 elixir 為例)
沒有 instance, class 的概念, 使用 ``Cards Module``.

<String>, <[ String ]> ... ---> **``Cards Module``** ---> <String>, <[ String ]> ...



