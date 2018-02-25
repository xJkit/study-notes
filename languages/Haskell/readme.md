# Haskell 學習筆記

Haskell 基本特色：

1. Purely Functional
  - functions are values
  - values never changes
2. Lazy
3. Statically Typed

## 一些基本的東西

### Installation

Mac OS:

```sh
brew cask install haskell-platform
```

check more about [installation guide](https://www.haskell.org/platform/mac.html#osx-homebrewcask) for more platforms.

### 基本概念

* Pure Functions
  * all functions are pure
  * cannot modify state
  * cannot depend on state
  * same input get same output

不是 Pure Function 的例子：
  * print string to a console: modifies external state
  * read a file: depends on external state at different times
  * get the current time: 不同時間回傳不同數值
  * get a random number: 每次都回傳不同數值

是 Pure Function 的例子：
  * 計算字串長度

* Recursion
在 Haskell 中沒有 Loop 只有 Recursion.

* List
  - 基本宣告：[1, 2, 3]
  - Homogeneous List: 必須相同型別
  - [1, 2, 3] 為語法糖，真正長相是 1 : 2 : 3 : []
  - "This" 字串 String 語法糖，真正長相是 'T':'h':'i':'s':[]
  - 所以 String 的 type 為 [Char]
  - 常用 list functions:
    - head 取得第一個元素
    - tail 取得最後一個
    - null 判別是否為空 list

* Tuple
  - 基本宣告： (1, "Hello", 'c', [1,2,3])
  - 不限制相同型別
  - pair: 只有兩個元素，如 (1,2), ("Hi", 3.14).
  - 常用 tuple functions:
    - fst 取 pair 第一個
    - snd 取 pair 第二個


Tuple | List
---------|---------
 (...) | [...]
 可以不同型別 | 必須相同型別
 固定長度(fixed length) | unbounded length


* Pattern Matching
  - different cases for a function
  - guards: `|`
  - case expression: `case of` (cannot mix case with guards)

* `Let` binding

* `Where` binding

* White spaces
  - 千萬不要使用 tab 縮排，務必使用空白。
  - Haskell 頗注重縮排，像是 let binding 中多個變數綁定必須縮排一直線才行。

* Lazy evaluation
  - 有用到才會計算
  - Lazy infinite list

Functions are `values`.
Operators are `functions`.

* Higher-order functions
  - pass a function as an argument, then return another function
  - 例子：
  ```haskell
    pass3 f = f 3
    add4 = (+) 4 -- 參數沒代滿
    add4 3 -- 將會是 7
  ```
  - map, filter, fold, zipWith

* Partial Application
 - 在 Haskell 中 function 的參數沒代滿是合法的。
 - 未代滿的參數回傳另一個 function 等著剩下的參數代入
 - 由於有 Partical Application, 參數的 `順序` 格外重要。
 - 以加法為例：
  ```haskell
    add1 = (+) 1
    add1' = (1+)
    add1'' = (+1)
    -- 以上三者等價
  ```

* Operators
  - +, *, :, ++ 這些 operator 在 Haskell 中其實都是 function.
  ```haskell
    3 + 4 -- 7
    (+) 3 4 -- 7 (等價寫法)
  ```
  - 將任意 function 轉成 operator: 使用兩個 `backticks`:
  ```haskell
    mod 7 5 -- 答案為 2
    7 `mod` 5 -- 等價寫法
  ```

* Map
  - `map :: (a -> b) -> [a] -> [b]`
  - 常搭配 partial application 做第一個參數使用：
  ```haskell
    map (1+) [1,2,3] -- [2,3,4]
    map (5*) [2,3,4] -- [10,15,20]
  ```

* Filter
  - `filter :: (a -> Bool) -> [a] -> [a]`
  - 搭配 where 蠻好用的:
  ```haskell
    removeOdd = filter (isEven) where isEven x = x `mod` 2 == 0
    remove [1..10] -- 得到 [2,4,6,8,10]
  ```
  - 還可以搭配 Map 和 Pair 的操作：
  ```haskell
    getTrueItemFromPair (pairs) = map snd (filter fst pairs)
    getTrueItemFromPair [(True, 1), (False, 2), (True, 3)] -- [1,3]
  ```
* Foldl 與 Foldr
  - `foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b`
  - `foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b`
  - 類似 JavaScript 中的 `reduce` 與 `reduceRight`
  - foldl 從 左邊開始計算， foldr 從右邊開始計算，在 `減法` 情形下是有差別的：
  ```haskell
    foldl (-) 0 [1,2,3] -- -6
    foldr (-) 0 [1,2,3] -- 2
  ```
  - `foldl` 比 `foldr` 速度稍微快一點
  - `foldl` 無法用於 infinite list 但是 `foldr` 可以 (多虧 lazy)

* zip / zipWit·h / zipWith3

* Lambda Expressions
  - 宣告： `(\x -> 2 * x)`
  - 就像是 JavaScript 的 anonymous function
  - 當然跟 `map`, `filter` 等 結合就會很強大
  ```haskell
    map (\x -> x * 2) [2,3,4] -- [4, 6, 8]
  ```

* Function Composition
  - `.`: 使用 dot sign 來 compose functions
  ```haskell
    strLength nums = length (show nums)
    strLength' = length . show
    -- 以上兩者等價

    notNull = not . null
  ```
  - function 必須 **只能有一個 argument** 才能 compose

* Function Application
  - `$`: 使用 dollar sign 表示將右邊 function 的執行結果代入左邊
  - 使用時機：當 compose 很多 functions
  ```haskell
    f $ g x = f (g x)
    f $ g $ h $ k x = f( g (h (k x)) )
  ```

  - 使用時機：higher-order functions
  ```haskell
  ($3) = (\f -> f 3)

  -- 以下兩者等價
  ops = map (\f -> f 3) [(+1), (\x -> 2*x + 3), (*2)]
  ops' = map ($3) [(+1), (\x -> 2*x + 3), (*2)]
  ```


### 開發工具

1. GHC
  - 最受歡迎的 Haskell Compiler
  - GHCi：Haskell REPL
2. Stack

### Fundamentals

使用 GHCi 打開後透過指令 `:l example.hs` 載入模組。再次載入可以使用 `:r`.

#### Ready To Go

```haskell
-- This is one line comment
{-
  multi line comments
  multi line comments
-}

--Char
-- Haskell 中 Char 是字元， String String == [Char] (Strng is a list of Char)
-- 'a', 'b', 'c' 都是字元, 用 single quote
-- "Hello", "world" 是 [Char], 用 double quote 只是語法糖

-- functions
-- 不可大寫字母開頭
-- 沒有參數的函數叫做"定義", 宣告後不可變。

doubleMe x = x + x
doubleUs x y = x*2 + y*2
doubleUs' x y = doubleMe x + doubleMe y
doubleSmalleNum x = if x < 100 then x else doubleMe x

-- Functions
doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNum x = if x > 100 then x else doubleMe x

-- List
-- list 內容必須為相同型別

primeNum = [2,3,5,7,11]
strConcat = "hello " ++ "world!"
listConcat = [1, 2, 3, 4] ++ [5, 6, 7] -- 效率較差，++ 左邊會被 iterate, 當左邊非常大時很慢

-- 使用 ： 插入第一個元素
strInsert = 'H' : "ello" -- 一次只能插入一個字元
listInsert = 1 : [2, 3, 4]

-- !! 用來取得 list 的元素，起始值 0
primeNum5 = primeNum !! 2

-- 可以比較大小，依元素順序比較, 可使用 >, <, ==
compareList = [3, 4, 5] > [3, 2] -- True
equalList = [1, 2, 3] == [1, 2, 3] -- True

-- 使用 head, last, tail, init 對 List 操作
testHead = head [2, 3, 4, 5] -- 2
testLast = last [2, 3, 4, 5] -- 5
testTail = tail [2, 3, 4, 5] -- [3, 4, 5]
testInit = init [2, 3, 4, 5] -- [2, 3, 4]
-- head, last, tail, init 不能用於空 List，因此可用於判別 List 是否為空。

-- 判別空 List: 使用 null 會更好
isNullList = null [] -- True
isNotNullList = null [1, 2] -- False

-- 計算 List 長度
lengthList = length [1, 2, 3] -- 3

-- reverse 反轉 List
reverse123 = reverse [1, 2, 3] -- [3, 2, 1]

-- take numbers of List
take2From123 = take 2 [1, 2, 3] -- [1, 2]
take5From123 = take 5 [1, 2, 3] -- [1, 2, 3]
take0 = take 0 [1, 2, 3] -- []

-- drop 剛好是 take 的相反
drop2 = drop 2 [1, 2, 3, 4] -- [3, 4]
drop5 = drop 5 [1, 2, 3] -- []
drop0 = drop 0 [1, 2, 3] -- [1, 2, 3]

-- maximum/minimum
getMax = maximum [1, 2, 3, 4, 5] -- 5
getMin = minimum [2, 3, 4, 1, 5] -- 1

-- sum 計算和， product 計算積
sumAll = sum [1, 2, 3] -- 6
productAll = product [1, 2, 3, 4] -- 24

-- elem 判別是否在 List 裡面
is5inList = 5 `elem` [1, 2, 3, 4] -- False
is2InList = 2 `elem` [1, 2, 3, 4] -- True

-- Range 列出可枚舉之 List, 包含數字和字母
-- 不要在 range 中使用浮點數，會得到糟糕的結果
nums = [4..10] -- [4,5,6,7,8,9,10]
evenNum = [4, 8..40] -- [4,8,12,16,20,24,28,32,36,40]
take5FromLongList = take 5 [13, 26..13*20] -- [13,26,39,52,65]

-- range 可以無上限
take5FromInfinityList = take 5 [11, 33..] -- [11,33,55,77,99]
-- 由於 Haskell 是 lazy, 它不會真的生成無限大長度，而是取到哪算到哪

-- cycle: [x, y] -> [x, y, x, y, x, y, ...]
take7FormCycleList = take 7 (cycle [4, 2, 6]) -- [4,2,6,4,2,6,4]
take7FromCycleStr = take 7 (cycle "Hello") -- "HelloHe" 因為字串也是 List

-- repeat： x -> [x, x..]
take7FromRepeat5 = take 7 (repeat 5) -- [5,5,5,5,5,5,5]
take5FromRepeatStr = take 5 (repeat "Hi") -- ["Hi","Hi","Hi","Hi","Hi"]

-- replicate： take + repeat
-- replicate 3 10 == take 3 (repeat 10)
repHi = replicate 3 "Hi" -- ["Hi","Hi","Hi"]
rep10 = replicate 3 10 -- [10,10,10]

-- List Comprehension
-- [expression | List, predicate]
-- 相當於數學中一個 集合 按照規矩產生一個新集合，還可加入多個 predicate (限制條件)
show10to100 = [x * 10 | x <- [1..10]] -- [10,20,30,40,50,60,70,80,90,100]
getEvenDuring20 = [x | x <- [1..100], x <= 20 ] -- [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
getOddWithout5 = [x*3 | x <- [1..30], x `mod` 5 /= 0, x <= 30]
bingBang = [if odd x then "BING" else "BANG" | x <- [1..10],  x <= 5] -- ["BING","BANG","BING","BANG","BING"]

-- 可以多維 + predicate
listProduct = [x*y | x <- [1,2,3], y <- [4, 5]] -- [4,5,8,10,12,15]
listProductLess10 = [x*y | x <- [1,2,3], y <- [4, 5], x*y <= 10] -- [4,5,8,10]

-- Tuple
-- Tuple 可以放入多個資料型態； Tuple 必須清楚定義, 不能使用 range
position = [(1,2), (3,4), (5,6)]
-- [(1,2), (3,4,5), (5,6)] 是違法的，因為中間的 Tuple 跟其他不同
-- [(1,2), (3,"hi"), (5,6)] 是違法的，因為中間的 Tuple 跟其他不同

-- zip: list list -> [tuple]
zipTest = zip [1,2,3] [4,5,6] -- [(1,4),(2,5),(3,6)]
zipTest' = zip [1,2] [3,4,5] -- [(1,3),(2,4)]
zipTest'' = zip [1,2,3] [4,5] -- [(1,4),(2,5)]

-- 函數式程式語言的一般思路：先取一個初始的集合併將其變形，執行過濾條件，最終取得正確的結果。
```

### Types

在 GHCi 中可以使用指令 `:t` 來查看 types.

* Char 一個字元
* String 字串（等價於 [Char]）
* Int 整數（有界）-2147483648~2147483647
* Integer 整數（無界）非常大但效能較差
* Float 單精度浮點數 (ex. 25.132742)
* Double 雙精度浮點數 (ex. 25.132741228718345)
* Bool 布林值(True/False)

### Type Variables

型別變數類似 OO 中的 generic, 可以是任意型別。
[a] -> a

### Typeclasses

測試一下等號的型別：

```sh
ghci> :t (==)
(==) :: (Eq a) => a -> a -> Bool
```

`=>` 左邊為型別約束， `Eq` 這一 Typeclass 提供了判斷相等性的介面，凡是可比較相等性的型別必屬於 `Eq` class.

常見的 Typeclasses:


Typeclass | 意義 | 實現函數 | 範圍
---------|----------|--------- |----
 Eq | 包含可判斷相等性的型別 | `==`, `/=` | 除函數以外的所有型別都屬於 Eq
 Ord | 包含可比較大小的型別 | `<, >, <=, >=` | 除了函數以外，我們目前所談到的所有型別都屬於 Ord 類; 型別若要成為Ord的成員，必先加入Eq家族。
 Show | 可用字串表示的型別 | show | 除函數以外的所有型別都是 Show 的成員
 Read | 與 Show 相反 | read | -
 Enum | 成員都是連續的型別 -- 也就是可枚舉 | - | 包含 ( ), Bool, Char, Ordering, Int, Integer, Float 和 Double
Bounded | 成員都有一個上限和下限
Num | 表示數字 | - | 包含所有的數字：實數和整數
Integral | 表示數字 | - | 僅包含整數, 其中的成員型別有 Int 和 Integer
Floating | 僅包含浮點型別 | - | 包含 Float 和 Double
## 參考資料：

* [Haskell 趣學指南](https://learnyoua.haskell.sg/content/zh-tw)