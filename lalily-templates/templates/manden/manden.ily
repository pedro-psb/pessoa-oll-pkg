\version "2.19.82"
\include "oll-core/package.ily"
\loadPackage lalily-templates
#(ly:set-option 'relative-includes #t)
\include "manden-drum-defs.ily"
\include "manden-styles.ily"

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%        Todo		%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Refactor to use manden.staff as a common staff for the various kind of staffs.

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     Structure	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% manden/
% 	/staff/$TYPE
% 	/staff/$TYPE/style
% 	/group/$TYPE
% 	/score/$TYPE
% 	/book/$TYPE
% 	/set/style/$SETS

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Staves	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dundun-melodia
% dundun-normal
% dundun-sg-dn
% djembe-normal
%
% Parâmetro comuns:
% _estilo
%


\registerTemplate manden.staff
#(define-music-function (mus opts)(list? list?)
   "DrumStaff com mods"
   #{
     \new DrumStaff \with{ #mods }
     <<
       \getMusic #'()
     >>
   #})

\registerTemplate manden.staff.melodia-dundun
#(define-music-function (mus opts)(list? list?)
   "1 DrumVoice: melodia"
   (let ((_style (get-option '_style melodia_default #f))
         (_staff-lines (get-option '_staff-lines melodia_default #f))
         (use-meta (get-option 'use-meta opts #t)))
     #{
       \new DrumStaff \with {
         drumStyleTable = #(alist->hash-table _style)
         drumPitchTable = #(alist->hash-table midiDrumPitches)
         \consists "Instrument_name_engraver"
         instrumentName = "Mel"
       }
       <<
         \override Staff.BarLine.bar-extent = #'(-2 . 2)
         \override Staff.StaffSymbol.line-positions = #_staff-lines
         
         #(get-music `(,mandeRoot global)) % Gets music with absolute path
         #(if (rel-has-music? '(meta))
              (if use-meta
                  #{ \getMusicDeep meta #}))
         \getMusic mel
       >>
     #}))

\registerTemplate manden.staff.djembe
#(define-music-function (mus opts)(list? list?)
   "1 DrumVoice: djembe"
   (let* ((_order (get-option '_order opts 'I))
          (_style (get-option '_style djembe_default #f))
          (_staff-lines (get-option '_staff-lines djembe_default #f))
          (direction (get-option 'direction opts 'up))
          (_name (cond
                  ((equal? _order 'I) "Dje I")
                  ((equal? _order 'II) "Dje II")
                  ((equal? _order 'III) "Dje III")))
          (use-meta (get-option 'use-meta opts #t)))
     #{
       \new DrumStaff \with {
         drumStyleTable = #(alist->hash-table _style)
         drumPitchTable = #(alist->hash-table midiDrumPitches)
         \consists "Instrument_name_engraver"
         instrumentName = #_name
       }
       <<
         \override Staff.BarLine.bar-extent = #'(-2 . 2)
         \override Staff.StaffSymbol.line-positions = #_staff-lines         
         <<
           #(if (equal? direction 'up)
                #{ \stemUp #}
                #{ \stemDown #})
           
           #(get-music `(,mandeRoot global))
           #(if (rel-has-music? '(meta))
                (if use-meta
                    #{ \getMusicDeep meta #}))
           \getMusic #(flatten-list (list 'dje _order))
         >>
       >>
     #}))


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Dunduns	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dundun
% -- dundun.normal
% -- dundun.duplo
%
% TODO
% O duplo Não suporta qualquer combinação.
% Tem que parametrizar estilos, nomes, etc.
% Como não é um caso comum, deixar pra depois.

\registerTemplate manden.staff.dundun
#(define-music-function (mus opts)(list? list?)
   "2 DrumVoice: drum e glock."
   (let* ((_order (get-option '_order opts #f))
          (_style (get-option '_style dundun_default #f))
          (_staff-lines (get-option '_staff-lines opts #f))
          (_voice (get-option '_voice opts #f)))
     (if _order
         #{
           <<
             \override Staff.BarLine.bar-extent = #'(-2 . 2)
             \override Staff.StaffSymbol.line-positions = #_staff-lines
             \override DrumStaff.Stem.details.beamed-lengths = #'(2)
           
             \new DrumVoice \with { \hide NoteHead} {
               #(if (equal? _voice 'I) #{\voiceOne#} #{\voiceTwo#})
               \getMusic #(flatten-list (list 'dun _order 'glock))
             }             
             \new DrumVoice \with {
               \remove "Stem_engraver"
               \remove "Dots_engraver"
               \remove "Rest_engraver"
               \remove "Rhythmic_column_engraver" 
             }<<
               #(if (equal? _voice 'I) #{\voiceOne#} #{\voiceTwo#})
               \getMusicDeep meta
               \getMusic #(flatten-list (list 'dun _order 'drum))
             >>
           >>
         #}
         #{ {} #(display "[manden] No dundun specified") #}
         )))

\registerTemplate manden.staff.dundun.normal
#(define-music-function (mus opts)(list? list?)
   "Create a dundun. Needs order to specify which dundun to create."
   (let* ((_order (get-option '_order opts #f))
          (_style (get-option '_style dundun_default #f))
          (_staff-lines (get-option '_staff-lines dundun_default #f))
          (_name (cond
                  ((equal? _order 'kk) "Kk")
                  ((equal? _order 'sg) "Sg")
                  ((equal? _order 'dn) "Dn")))
          (_voice (get-option '_voice opts 'I)))
     (set! opts (assoc-set! opts '_voice _voice))
     (set! opts (assoc-set! opts '_staff-lines _staff-lines))
     (if _order
         #{
           \new DrumStaff \with{
             drumStyleTable = #(alist->hash-table _style)
             drumPitchTable = #(alist->hash-table midiDrumPitches)
             \consists "Instrument_name_engraver"
             instrumentName = #_name
           }
           <<
             \callTemplate #'(..) #'() #opts
           >>
         #}
         #{ {} #(display "[manden] No dundun specified") #}
         )))

\registerTemplate manden.staff.dundun.duplo
#(define-music-function (mus opts)(list? list?)
   "DrumStaff com mods"
   (let* ((_order (get-option '_order opts #f))
          (_style (get-option '_style two-dundun_default #f))
          (_staff-lines (get-option '_staff-lines two-dundun_default #f))
          (_name "Sg/Dn"))
     (set! opts (assoc-set! opts '_staff-lines _staff-lines))
     #{
       \new DrumStaff \with{
         drumStyleTable = #(alist->hash-table _style)
         drumPitchTable = #(alist->hash-table midiDrumPitches)
         \consists "Instrument_name_engraver"
         instrumentName = #_name
       }
       <<
         \callTemplate #'(..) #'() #(append opts '((_order . sg) (_voice . I)))
         \callTemplate #'(..) #'() #(append opts '((_order . dn) (_voice . II)))
       >>
     #}))


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Groups	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% djembe-acc
% dundun-trio
% break
% solo

\registerTemplate manden.group.djembe-acc
#(define-music-function (mus opts)(list? list?)
   "Todos os djembes (entrar manualmente).TODO: ler todos os disponíveis."
   (let ((dje-list (get-option 'dje-list opts '(I II III))))
     #{
       \new StaffGroup <<
         $(make-music 'SimultaneousMusic 'elements
            (map (lambda (num)
                   #{
                     \callTemplate #'(..)
                     #(flatten-list (list 'dje num))
                     #'()
                   #})
              dje-list))
       >>
     #}))


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Front-End	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\registerTemplate manden.main.default
#(define-music-function (mus opts)(list? list?)
   "Template para a música principal do mandén. Usar condicional para variações, ao invéz de criar manden.main.I manden.main.II etc"
   (let ((lvl '(LY_UP LY_UP)))
     #{
       <<
         \callTemplate #`(,@lvl staff melodia-dundun) #'() #'()
         \new StaffGroup <<
           \callTemplate #`(,@lvl staff dundun normal) #'()
           #'((_order . kk)
              (_voice . I))
           \callTemplate #`(,@lvl staff dundun duplo) #'() #'()
         >>
    
         \new StaffGroup <<
           \callTemplate #`(,@lvl staff djembe) #'() #'((_order . I))
           \callTemplate #`(,@lvl staff djembe) #'() #'((_order . II))
           \callTemplate #`(,@lvl staff djembe) #'() #'((_order . III))
         >>
       >>
     #}))

\registerTemplate manden.break.default
#(define-music-function (mus opts)(list? list?)
   "Template para a os breaks do mandén. Usar condicional para variações, ao invéz de criar manden.main.I manden.main.II etc"
   (let ((lvl '(LY_UP LY_UP)))
     #{
       <<
         \new StaffGroup <<
           \callTemplate #`(,@lvl staff melodia-dundun) #'() #'()
           \callTemplate #`(,@lvl staff djembe) #'() #'((_order . I))
         >>
       >>
     #}))

\registerTemplate manden.solo.default
#(define-music-function (mus opts)(list? list?)
   "Template para a os breaks do mandén. Usar condicional para variações, ao invéz de criar manden.main.I manden.main.II etc"
   (let ((lvl '(LY_UP LY_UP)))
     #{
       <<
         \callTemplate #`(,@lvl staff melodia-dundun) #'(LY_UP LY_UP base main I)
         #'((use-meta . #f))
       
         \callTemplate #`(,@lvl staff djembe) #'()
         #'((_order . I))       
       >>
     #}
     ))

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	   Misc		%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% General Names %%
#(define mandeRoot (string->symbol (ly:parser-output-name)))
#(define mandeRootStr ly:parser-output-name)

%% Helper Functions %%
#(define-public (rel-has-music? path)
   "Check if relative path has music."
   (has-music? (append (get-current-music) path)))

#(define-public (abs-manden-path path)
   "Absolute manden path (relative to the root level Rhythm)."
   (append (list (car (musicPath '()))) path))

%% Secondary %%
#(define-public (temp-printer a b c)
   "<Var> at <this fun> is: <value>"
   (format #t "\n\n'~A' at ~A is:\n'~A'"
     a b c))

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	Printing	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #(format #t "~A\n" music-tree)	
% #(format #t "~A\n" (get-music-keys '()))

% #(display-music-pieces)
% #(display-templates)

% #(display (get-current-music))
% #(display (getCurrentMusic))

% #(display (get-current-template))
% #(display (getTemplate))

% #(display (get-music-folder-options))
% #(display (getScoreOptions))

% #(get-current-template)
% #(display-default-music)
% #(display (musicPath '(foo)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	Experimentar	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
   \registerTemplate vocal.group
   #(define-music-function (parser location my-path-to-choir options)(list? list?)
     (let ((staff-list (assoc-get 'staff-list options '())))
       #{
         \new ChoirStaff $(make-music 'SimultaneousMusic 'elements
                            (map (lambda (staff) #{\callTemplate #'(..) #(list (car staff)) #(cdr staff) #}) staff-list))
       #}))

   % create vocal staffs for Soprano, Alto, Tenore and Basso
   \registerTemplate vocal.group.SATB
   #(define-music-function (parser location my-path-to-choir options)(list? list?)
     (let ((opts (assoc-set! options 'staff-list '(
                                                    (soprano . ((clef . "G")))
                                                    (alto . ((clef . "G")))
                                                    (tenore . ((clef . "G_8")))
                                                    (basso . ((clef . "bass")))
                                                    ))))
       #{ \callTemplate #'(..) #'() #opts #}))
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	  Olhar		%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (call-template (create-template-path #f '(.. ..)) piece
% (assoc-set-all! options `((name . "saxbar")