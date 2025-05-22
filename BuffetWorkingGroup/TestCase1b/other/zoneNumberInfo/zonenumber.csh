#!/bin/csh -f

##########################################
### Grid Level
##########################################
if ( 1 == 1 ) then
   set grids = ( 1 2 3 4 5 6 7 8 9 10 11 )
   foreach grid ( $grids )
      grep -i -n "GRID ${grid}" zonenumber.dat >&! zonenumber-${grid}.out
   end
endif

if ( 1 == 1 ) then
   set grids = ( 1 2 3 4 5 6 7 8 9 10 11 )
   foreach grid ( $grids )
      printf "\n\n\n%s\n\n" $grid
      cat zonenumber-${grid}.out | cut -d: -f1 | xargs printf "%s, "
   end
endif
printf "\n"



##########################################
### Alpha
##########################################
if ( 1 == 1 ) then
   set alphas = ( 1.36 1.5 2.5 3.0 3.1 3.2 3.4 3.5 3.6 3.9 )
   foreach alpha ( $alphas )
     #printf "\n\n\n%s\n\n" $alpha
      grep -i -n "ALPHA ${alpha}" zonenumber.dat >&! zonenumber-${alpha}.out
   end
endif

if ( 1 == 1 ) then
   set alphas = ( 1.36 1.5 2.5 3.0 3.1 3.2 3.4 3.5 3.6 3.9 )
   foreach alpha ( $alphas )
      printf "\n\n\n%s\n" $alpha
      cat zonenumber-${alpha}.out | cut -d: -f1 | xargs printf "%s, "
   end
endif


printf "\n"
