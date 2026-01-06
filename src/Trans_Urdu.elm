module Trans_Urdu exposing (transl)

import Dict

latUrdu : Dict.Dict String String
latUrdu = Dict.fromList [ ("|" , "\u{0627}")
                        ,("b" , "\u{0628}"), ("b'", "\u{0628}\u{06BE}")
                        ,("p" , "\u{067E}"), ("p'", "\u{067E}\u{06BE}")
                        ,("t" , "\u{062A}"), ("t'", "\u{062A}\u{06BE}")
                        ,("T" , "\u{0679}"), ("T'", "\u{0679}\u{06BE}")
                        ,("j" , "\u{062C}"), ("j'", "\u{062C}\u{06BE}")
                        ,("c" , "\u{0686}"), ("c'", "\u{0686}\u{06BE}")
                        ,("H" , "\u{062D}")
                        ,("x" , "\u{062E}")
                        ,("d" , "\u{062F}"), ("d'", "\u{062F}\u{06BE}")
                        ,("D" , "\u{0688}"), ("D'", "\u{0688}\u{06BE}")
                        ,("r" , "\u{0631}")
                        ,("R" , "\u{0691}"), ("R'", "\u{0691}\u{06BE}")
                        ,("z" , "\u{0632}")
                        ,("s" , "\u{0633}")
                        ,("A" , "\u{0639}")
                        ,("f" , "\u{0641}")
                        ,("q" , "\u{0642}")
                        ,("k" , "\u{06A9}"), ("k'", "\u{06A9}\u{06BE}")
                        ,("g" , "\u{06AF}"), ("g'", "\u{06AF}\u{06BE}")
                        ,("l" , "\u{0644}")
                        ,("m" , "\u{0645}")
                        ,("n" , "\u{0646}"),("n'" , "\u{06BA}")
                        ,("w" , "\u{0648}")
                        ,("h" , "\u{06C1}")
                        ,("y" , "\u{06CC}")
                        ,("e" , "\u{06D2}")
                        ,("`" , "\u{0626}")
                        ,("&" , "\u{0621}")
                        ,("a" , "\u{06C3}")
                        ,("i" , "\u{0626}")
                        ,("u" , "\u{0624}")
                        ,("ê" , "\u{06D3}")
                        ,("1" , "\u{06F1}"),("2" , "\u{06F2}"),("3" , "\u{06F3}"),("4" , "\u{06F4}"),("5" , "\u{06F5}")
                        ,("6" , "\u{06F6}"),("7" , "\u{06F7}"),("8" , "\u{06F8}"),("9" , "\u{06F9}"),("0" , "\u{06F0}")
                        ,("." , "\u{06D4}")
                        ,("?" , "\u{061F}")
                        ,("$" , "\u{0651}")
                        ,("," , "\u{060C}")
                        , ("_" , "") -- filter _
                        ]

latUrdu_ : Dict.Dict String String -- characters to be preceded by _ (underscore)
latUrdu_= Dict.fromList  [ ("t" , "\u{062B}") -- yev --
                         ,("d" , "\u{0630}") -- TZA --
                         ,("z" , "\u{0698}")
                         ,("s" , "\u{0634}")
                         ,("S" , "\u{0635}")
                         ,("D" , "\u{0636}")
                         ,("T" , "\u{0637}")
                         ,("Z" , "\u{0638}")
                         ,("g" , "\u{063A}")
                         ,("a" , "\u{0622}")
                         ]

diacritics : List String
diacritics = ["'"]

subst : String -> (Dict.Dict String String) -> String -- substitute one char (or char + diacritics) on the basis of dictionary
subst car dict =
  Maybe.withDefault car (Dict.get car dict) -- if car is in dict, substitute, else keep car

subst_ : (String,String) -> String -- select dictionary on the basis of previous char : _ or not _, and substitute char
subst_ dble =
  let
     (carac, sub) = dble
  in
    if sub == "_" then subst carac latUrdu_ else subst carac latUrdu

szip : List String -> List (String,String) -- zip s with a right shift of itself
szip s =
    List.map2 Tuple.pair s ("&" :: s)

foldp : List String -> List String -> List String -- concatenate letters with their diacritics, if any
foldp acc list =
  case list of
    [] ->
      acc
    x::xs ->
      case xs of
        [] ->
          x::acc
        y::ys ->
          if List.member y diacritics then -- 1 diacritic
            case ys of
              [] ->
                (x++y)::acc
              _ ->
                foldp ((x++y)::acc) ys
          else
            foldp (x::acc) xs

trich : String -> String -- sort diacritics, if more than 1 present
trich s =
  if String.length s < 3 then s -- 0 or 1 diacritic, no need to sort
  else
    let
      h = String.slice 0 1 s -- head character
      b = String.slice 1 5 s -- b contains the diacritics, which will be sorted according to Unicode value
    in
      h ++ (b |> String.toList |> List.map String.fromChar |> List.sort |> List.foldr (++) "")

transl : String -> String
transl chaine =
    chaine
    |> String.toList
    |> List.map String.fromChar
    |> foldp []
    |> List.reverse
    |> List.map trich
    |> szip
    |> List.map subst_
    |> List.foldr (++) ""
