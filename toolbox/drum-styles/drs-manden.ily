\version "2.19.82"
drum-style-name = manden
% Why I need this?
% drum-style-root = local.definitions.drum-styles

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	Style-Defs	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drum-style		alist used inside "\new Drumstaff \with { }"
% staff-line	override used in ???

\registerOption \drum-style-root.manden-default.melodia
#'((drum-style . ((kkopen	default	#f   3)
                  (kkrim	cross	"marcato"   3)
                  (kkmute	cross	#f   3)

                  (sgopen	default	#f   0)
                  (sgrim	cross	"marcato"   0)
                  (sgmute	cross	#f   0)

                  (dnopen	default	#f   -3)
                  (dnrim	cross	"marcato"   -3)
                  (dnmute	cross	#f   -3)))
   (staff-lines . (3 0 -3)))

\registerOption \drum-style-root.manden-default.dundun
#'((drum-style . ((kkopen	default	#f   0)
                  (kkrim	cross	,"marcato"   0)
                  (kkmute	cross	#f   0)

                  (sgopen	default	#f   0)
                  (sgrim	cross	,"marcato"   0)
                  (sgmute	cross	#f   0)

                  (dnopen	default	#f   0)
                  (dnrim	cross	,"marcato"   0)
                  (dnmute	cross	#f   0)))
   (staff-lines . (0)))

\registerOption \drum-style-root.manden-default.two-dundun
#'((drum-style . ((kkopen	default	#f   2)
                  (kkrim	cross	,"marcato"   2)
                  (kkmute	cross	#f   2)
                  (kkglock	cross	#f   2)

                  (sgopen	default	#f   2)
                  (sgrim	cross	,"marcato"   2)
                  (sgmute	cross	#f   2)
                  (sgglock	cross	#f   2)

                  (dnopen	default	#f   -2)
                  (dnrim	cross	,"marcato"   -2)
                  (dnmute	cross	#f   -2)
                  (dnglock	cross	#f   -2)))
   (staff-lines . (2 -2)))

\registerOption \drum-style-root.manden-default.djembe
#'((drum-style . ((djslap		default	#f		3)
                  (djslapmute	default	"staccato"	3)
             
                  (djopen		default	#f		0)
                  (djopenmute	default	"staccato"	0)
       
                  (djbass		default	#f		-3)
                  (djbassmute	default	"staccato"	-3)))
   (staff-lines . (3 0 -3)))