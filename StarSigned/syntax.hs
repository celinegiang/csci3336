module Syntax where
import Data.List (intercalate)

-- CONTEXT FREE GRAMMAR

{-

<program> -> <stmt> | <stmt> <program>

<stmt> -> <chart_decl> | <rule>

<chart_decl> -> chart <identifier> { <placements> }

<placements> -> <placement> | <placement> , <placements>

<placement> -> <planet> in <sign>

<planet> -> sun | moon | rising

<sign> -> Aries | Taurus | Gemini | Cancer
        | Leo | Virgo | Libra | Scorpio
        | Sagittarius | Capricorn
        | Aquarius | Pisces

<rule> -> when <condition> => <output>

<condition> -> <condition> or <and_cond> | <and_cond>

<and_cond> -> <and_cond> and <not_cond> | <not_cond>

<not_cond> -> not <not_cond> | <atom>

<atom> -> <identifier> . <planet> is <element>
        | <identifier> . <planet> in <sign>
        | ( <condition> )

<element> -> fire | earth | air | water

<output> -> say <string>

<identifier> -> <letter> | <letter> <identifier>

<string> -> " <characters> "

<characters> -> <character> <characters> | epsilon

<character> -> <letter> | <digit> | <space> | <symbol>

<space> -> " "

<letter> -> a | b | c | ... | z | A | B | C | ... | Z

<digit> -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

<symbol> -> . | , | ! | ? | ' | - | :

Precedence (weakest to strongest): or, and, not.
Parentheses can be used to group conditions differently.

-}

-- ABSTRACT SYNTAX TREE (AST)

type Program = [Stmt]

type Var = String

-- Planetary placements
data Planet
    = Sun
    | Moon
    | Rising
    deriving (Eq)

-- Zodiac signs
data Sign
    = Aries | Taurus | Gemini | Cancer
    | Leo | Virgo | Libra | Scorpio
    | Sagittarius | Capricorn
    | Aquarius | Pisces
    deriving (Eq)

-- Four astrological elements
data Element
    = Fire
    | Earth
    | Air
    | Water
    deriving (Eq)

-- A planetary placement
type Placement = (Planet, Sign)

-- Program statements
data Stmt
    = ChartDeclaration Var [Placement]
    | WhenRule Condition String
    deriving (Eq)

-- Horoscope conditions
data Condition
    = IsElement Var Planet Element      -- celine.sun is air
    | InSign Var Planet Sign            -- celine.moon in Cancer
    | And Condition Condition           -- c1 and c2
    | Or Condition Condition            -- c1 or c2
    | Not Condition                     -- not c
    deriving (Eq)

-- SHOW INSTANCES

instance Show Planet where
    show Sun = "sun"
    show Moon = "moon"
    show Rising = "rising"

instance Show Sign where
    show Aries = "Aries"
    show Taurus = "Taurus"
    show Gemini = "Gemini"
    show Cancer = "Cancer"
    show Leo = "Leo"
    show Virgo = "Virgo"
    show Libra = "Libra"
    show Scorpio = "Scorpio"
    show Sagittarius = "Sagittarius"
    show Capricorn = "Capricorn"
    show Aquarius = "Aquarius"
    show Pisces = "Pisces"

instance Show Element where
    show Fire = "fire"
    show Earth = "earth"
    show Air = "air"
    show Water = "water"

instance Show Condition where
    show c = showCond 0 c

-- showCond level c prints condition c.
-- level says what c is sitting inside of:
--   0 = nothing, 1 = an "or", 2 = an "and", 3 = a "not"
-- Parentheses are added only when they are needed to keep the meaning.
showCond :: Int -> Condition -> String
showCond level (Or c1 c2) =
    addParens (level > 1) (showCond 1 c1 ++ " or " ++ showCond 2 c2)
showCond level (And c1 c2) =
    addParens (level > 2) (showCond 2 c1 ++ " and " ++ showCond 3 c2)
showCond level (Not c) =
    addParens (level > 3) ("not " ++ showCond 3 c)
showCond _ (IsElement name planet element) =
    name ++ "." ++ show planet ++ " is " ++ show element
showCond _ (InSign name planet sign) =
    name ++ "." ++ show planet ++ " in " ++ show sign

addParens :: Bool -> String -> String
addParens True s = "(" ++ s ++ ")"
addParens False s = s

instance Show Stmt where

    show (ChartDeclaration name ps) =
        "chart " ++ name ++ " {\n"
        ++ printPlacements ps
        ++ "\n}"

    show (WhenRule condition message) =
        "when " ++ show condition ++ " =>\n"
        ++ "    say \"" ++ message ++ "\""


-- HELPER FUNCTIONS

printPlacement :: Placement -> String
printPlacement (planet, sign) =
    "    " ++ show planet ++ " in " ++ show sign

printPlacements :: [Placement] -> String
printPlacements ps =
    intercalate ",\n" (map printPlacement ps)

printProgram :: Program -> IO ()
printProgram p =
    putStrLn (intercalate "\n\n" (map show p))