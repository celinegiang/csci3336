module Main where
import Syntax

-- PROGRAM 1: PERSONAL HOROSCOPE
-- Features: one chart, "is <element>", "in <sign>", "and"

{-

chart celine {
    sun in Gemini,
    moon in Cancer,
    rising in Libra
}

when celine.sun is air =>
    say "Curious mind today."

when celine.moon in Cancer =>
    say "Stay in tonight and recharge."

when celine.sun is air and celine.moon is water =>
    say "Head and heart are pulling in different directions."

-}

p1 :: Program
p1 =
    [ ChartDeclaration "celine"
        [ (Sun, Gemini)
        , (Moon, Cancer)
        , (Rising, Libra)
        ]

    , WhenRule
        (IsElement "celine" Sun Air)
        "Curious mind today."

    , WhenRule
        (InSign "celine" Moon Cancer)
        "Stay in tonight and recharge."

    , WhenRule
        (And (IsElement "celine" Sun Air) (IsElement "celine" Moon Water))
        "Head and heart are pulling in different directions."
    ]

-- PROGRAM 2: FRIENDSHIP READING
-- Features: two charts, "or", "not", parentheses for grouping

{-

chart jorge {
    sun in Leo,
    moon in Scorpio,
    rising in Taurus
}

chart celine {
    sun in Gemini,
    moon in Cancer,
    rising in Libra
}

when jorge.moon is water or celine.moon is water =>
    say "One of you is the emotional anchor of this friendship."

when not jorge.rising is air =>
    say "Jorge comes across as calm and steady."

when (jorge.sun is fire or jorge.sun is air) and not celine.sun in Leo =>
    say "Jorge brings the spark, Celine keeps the conversation going."

-}

p2 :: Program
p2 =
    [ ChartDeclaration "jorge"
        [ (Sun, Leo)
        , (Moon, Scorpio)
        , (Rising, Taurus)
        ]

    , ChartDeclaration "celine"
        [ (Sun, Gemini)
        , (Moon, Cancer)
        , (Rising, Libra)
        ]

    , WhenRule
        (Or (IsElement "jorge" Moon Water) (IsElement "celine" Moon Water))
        "One of you is the emotional anchor of this friendship."

    , WhenRule
        (Not (IsElement "jorge" Rising Air))
        "Jorge comes across as calm and steady."

    , WhenRule
        (And (Or (IsElement "jorge" Sun Fire) (IsElement "jorge" Sun Air))
             (Not (InSign "celine" Sun Leo)))
        "Jorge brings the spark, Celine keeps the conversation going."
    ]


-- MAIN

main :: IO ()
main = do

    putStrLn "PROGRAM 1: PERSONAL HOROSCOPE"
    putStrLn "-----------------------------"
    printProgram p1

    putStrLn "\nPROGRAM 2: FRIENDSHIP READING"
    putStrLn "-----------------------------"
    printProgram p2
