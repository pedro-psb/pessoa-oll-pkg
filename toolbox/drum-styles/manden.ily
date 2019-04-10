\version "2.19.82"
% TODO implement registerStyle kinda of thing (like registerTemplate etc)

drumStyleRoot = local.definitions.drum-styles
#(define-public getStyleOpt
   (define-scheme-function (style) (list?)
     "Convenient way to get style from the root style folder"
     (getOption `(,@drumStyleRoot ,@style))))

setMods = 
#(define-scheme-function (opts)(list?)
   (let ((style (ly:assoc-get 'style opts))
         (style (ly:assoc-get 'style opts)))
     #{
       \with {
         drumStyleTable = #(alist->hash-table style)
         drumPitchTable = #(alist->hash-table midiDrumPitches)
       }
     #}))

% drumMods = \setMods \getStyleOpt manden-default


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	Style-Defs	%%%

\registerOption \drumStyleRoot.manden-default.melodia
#'((style . ((kkopen	default	#f   3)
             (kkrim	cross	"marcato"   3)
             (kkmute	cross	#f   3)

             (sgopen	default	#f   0)
             (sgrim	cross	"marcato"   0)
             (sgmute	cross	#f   0)

             (dnopen	default	#f   -3)
             (dnrim	cross	"marcato"   -3)
             (dnmute	cross	#f   -3)))
   (staff-lines . (3 0 -3)))

\registerOption \drumStyleRoot.manden-default.dundun
#'((style . ((kkopen	default	#f   0)
             (kkrim	cross	,"marcato"   0)
             (kkmute	cross	#f   0)

             (sgopen	default	#f   0)
             (sgrim	cross	,"marcato"   0)
             (sgmute	cross	#f   0)

             (dnopen	default	#f   0)
             (dnrim	cross	,"marcato"   0)
             (dnmute	cross	#f   0)))
   (staff-lines . (0)))

\registerOption \drumStyleRoot.manden-default.two-dundun
#'((style . ((kkopen	default	#f   2)
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

\registerOption \drumStyleRoot.manden-default.djembe
#'((style . ((djslap		default	#f		3)
             (djslapmute	default	"staccato"	3)
             
             (djopen		default	#f		0)
             (djopenmute	default	"staccato"	0)
       
             (djbass		default	#f		-3)
             (djbassmute	default	"staccato"	-3)))
   (staff-lines . (3 0 -3)))

% \initStyle manden-default
%{ DEPRECATED 
   #(define-public initStyle
     (define-scheme-function (style-symbol)(symbol?)
       (let ((style (ly:parser-lookup style-symbol)))
         (for-each
          (lambda (k)
            (let ((v (ly:assoc-get k style #f #f)))
              (if (not (defined? k)) (ly:parser-define! k v))))
          (map (lambda (x) (car x)) style)))))

%}