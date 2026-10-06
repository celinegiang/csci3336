module Example where
    import Syntax

{-
x : bin = 0110
print x

if x == 0110 then
    print 6
else
    print 7
-}

p1 :: Program
p1 = [
    Assign "x" Bin (B [ZBin, OBin, OBin, ZBin])
]