
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

<condition> -> <identifier> . <planet> is <element>

<element> -> fire | earth | air | water

<output> -> say <string>

<identifier> -> <letter> | <letter> <identifier>

<string> -> " <characters> "

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
    = IsElement Var Planet Element
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
    show (IsElement name planet element) =
        name ++ "." ++ show planet
        ++ " is " ++ show element

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
