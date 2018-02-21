-- Type
{-
  在 GHCi 中使用 :t 指令來判斷資料類型
  例如> :t 'A'
  得到 'A' :: Char
  :: 讀做 “它的型態是”
-}

onlyLowerCase :: String -> String
onlyLowerCase cases = [ c | c <- cases, c `elem` ['a'..'z']]
-- onlyLowerCase :: [Char] -> [Char]
-- onlyLowerCase :: String -> String 兩者等價
-- 代表 函數的映射