#!MC 1410

#-------------------------------------------------


#-------------------------------------------------
# Turbulence Model Variants
$!VarSet |ALL_Maps|        = "1,2,3,4,5,6,7"
$!VarSet |SaUrans_Maps|   = "   3,4        "
$!VarSet |SaZdes_Maps|    = "1,2           "
$!VarSet |Wmles_Maps|      = "        5,6,7"

#-------------------------------------------------

$!LineMap  [|SaUrans_Maps|] Lines   { Color = Red   } Symbols { Color = Red   FillColor = Red   } 
$!LineMap  [|SaZdes_Maps|]  Lines   { Color = Green } Symbols { Color = Green FillColor = Green } 
$!LineMap  [|Wmles_Maps|]   Lines   { Color = Black } Symbols { Color = Black FillColor = Black } 










#$!LineMap  [1]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
#$!LineMap  [2]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\a'}}}
#$!LineMap  [3]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\A'}}}
#$!LineMap  [4]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\a'}}}
#$!LineMap  [5]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\A'}}}


#$!LineMap  [|SA_Maps|]  Lines   { Color = Red   } Symbols { Color = Red   FillColor = Red   } 
#$!LineMap  [|SAQ_Maps|] Lines   { Color = Green } Symbols { Color = Green FillColor = Green } 
#$!LineMap  [|SST_Maps|] Lines   { Color = Black } Symbols { Color = Black FillColor = Black } 
