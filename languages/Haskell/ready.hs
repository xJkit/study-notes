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