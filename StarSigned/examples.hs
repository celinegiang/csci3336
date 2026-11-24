
module Examples where
import Syntax

-- PROGRAM 1: PERSONAL HOROSCOPE

{-

chart celine {
    sun in Gemini,
    moon in Cancer,
    rising in Libra
}

when celine.sun is air =>
    say "Curious mind today."

when celine.moon is water =>
    say "Trust your emotions today."

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
        (IsElement "celine" Moon Water)
        "Trust your emotions today."
    ]

-- PROGRAM 2: MULTIPLE HOROSCOPE CHARTS

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

when jorge.sun is fire =>
    say "Your confidence is attracting new opportunities."

when jorge.moon is water =>
    say "Take time to understand your feelings."

when celine.rising is air =>
    say "Your social energy is especially strong today."

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
        (IsElement "jorge" Sun Fire)
        "Your confidence is attracting new opportunities."

    , WhenRule
        (IsElement "jorge" Moon Water)
        "Take time to understand your feelings."

    , WhenRule
        (IsElement "celine" Rising Air)
        "Your social energy is especially strong today."
    ]


-- MAIN

main :: IO ()
main = do

    putStrLn "PROGRAM 1: PERSONAL HOROSCOPE"
    putStrLn "-----------------------------"
    printProgram p1

    putStrLn "\nPROGRAM 2: MULTIPLE HOROSCOPE CHARTS"
    putStrLn "------------------------------------"
    printProgram p2
