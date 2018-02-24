square x = x * x

-- Simple conditions
posOrNeg x =
  if x >= 0
  then "Positive number"
  else "Negative Number"

-- use pattern matching v.s if-else confitions

factorial n =
  if n == 0
  then 1
  else n * factorial (n - 1)

factorial' 0 = 1
factorial' x = x * factorial' (x-1)

-- use recursion to double list elements
doubleList x =
  if null x
  then []
  else (2 * head x) : (doubleList (tail x))

-- use pattern matching to double list elements
doubleList' [] = []
doubleList' (x : xs) = (2 * x) : (doubleList' xs)

-- use case expressions
doubleList'' x = case x of
  [] -> []
  (x: xs) -> (2 * x) : (doubleList'' xs)

-- attension: case expression cannot mix with guards

-- use recursion to remove odd numbers (safer)
removeOdds nums =
  if null nums
  then []
  else
    if mod (head nums) 2 == 1 -- odd
    then removeOdds (tail nums)
    else (head nums) : removeOdds (tail nums)

-- use pattern matching to remove odd numbers (safer)
removeOdds' [] = []
removeOdds' (x: xs) =
  if mod x 2 == 1
  then removeOdds' xs
  else x : removeOdds' xs

-- use pattern matching + guards
removeOdds'' [] = []
removeOdds'' (x: xs)
    | mod x 2 == 1 = removeOdds'' xs -- remove odd number
    | otherwise  = x : removeOdds'' xs



-- let binding (+ in)
-- (bottom-up approach)
fancySeven =
  let x = 3
      y = 4
  in x + y

fancyTen = (let a = 4 in 2 * (a + 1))

-- where binding
-- (top-down approach)
fancySeven'' = x + y
  where x = 3
        y = 4

fancyTen' = 2 * (a + 1)
  where a = 4