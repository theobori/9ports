DIRS=\
	catclock\
	sudoku\
	juggle\
	festoon\
	sokoban\
	mahjongg\
	life\
	xs\

TARG=$DIRS

<$PLAN9/src/mkdirs

CLEANFILES=$CLEANFILES bc.tab.[ch] units.tab.[ch] delatex.c
