\version "2.19.82"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This file is user template for the Lalily-Template enginee. %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Manden Template.
% \loadLog

%{
\registerTemplate manden.instrument.dundun
#(define-music-function (piece options)(list? list?)
   (let ((mods (get-option 'dundun-mods options #f))
         (modsGl (get-option 'glock-mods options #f))
         (modsDr (get-option 'drum-mods options #f))
         (dundunName (get-option 'dundun-name options "Dundun"))
         )
     #{
       \new DrumStaff \with {
         $(if (ly:context-mod? mods) mods)
         \consists "Instrument_name_engraver"
         #(display (symbol->string (car dundunName)))
         instrumentName = $(symbol->string (car dundunName))
       } <<
         \new DrumVoice \with {
           $(if (ly:context-mod? modsGl) modsGl)
         } <<
           \getMusicDeep {} #'meta
           \getMusic {} global
           \voiceOne
           \getMusic glock
         >>
         %%{
         \new DrumVoice \with {
           $(if (ly:context-mod? modsDr) modsDr)
         } <<
           \getMusicDeep {} #'meta
           \getMusic {} global
           \voiceTwo
           \getMusic {} drum
         >>
         %}
         %{
         \new Dynamics \with {
           $(if (ly:context-mod? dmods) dmods)
         } { \getMusic {} dynamics }
       >>
     #}))

\optionsInit manden_single-dundun
\optionsAddL manden_single-dundun "_template" group
\optionsAddL manden_single-dundun sangban."_template" manden.instrument.dundun
\optionsAddL manden_single-dundun sangban.dundun-name "Sangban"
\optionsAddL manden_single-dundun dundunba."_template" manden.instrument.dundun
\optionsAddL manden_single-dundun dundunba.dundun-name "Dundunba"

\registerTemplate manden.ensambles.sgDn
#(define-music-function (piece options)(list? list?)
   (let ((mods (get-option 'dundun-mods options #f))
         (modsGl (get-option 'glock-mods options #f))
         (modsDr (get-option 'drum-mods options #f))
         (dundunName (get-option 'dundun-name options "Dundun"))
         )
     #{
       \new DrumStaff \with {
         $(if (ly:context-mod? mods) mods)
         \consists "Instrument_name_engraver"
         %#(display (symbol->string (car dundunName)))
         % instrumentName = $(symbol->string (car dundunName))
       } <<
         \new DrumVoice \with {
           $(if (ly:context-mod? modsGl) modsGl)
         } <<
           \getMusicDeep {} #'meta
           \getMusic {} global
           \voiceOne
           \getMusic #'()
         >>
         %%{
         \new DrumVoice \with {
           $(if (ly:context-mod? modsDr) modsDr)
         } <<
           \getMusicDeep {} #'meta
           \getMusic {} global
           \voiceTwo
           \getMusic {} drum
         >>
         %}
         %{
         \new Dynamics \with {
           $(if (ly:context-mod? dmods) dmods)
         } { \getMusic {} dynamics }
       >>
     #}))
\optionsInit manden_ensamble-sgDn
\optionsAddL manden_ensamble-sgDn "_template" group
\optionsAddL manden_ensamble-sgDn SgDnVoice."_template" manden.ensambles.sgDn
\optionsAddL manden_ensamble-sgDn SgDnVoice."_order" sangban.dundunba

\registerTemplate manden.foobar
#(define-music-function (piece options)(list? list?)
   #{
     #(newline)
     #(display "mande-template >> mande.instrument.sangban called")
     \new DrumStaff <<
       \getMusicDeep {} #'meta
       \getMusic {} global
       \getMusic glock
     >>
   #})
%{
\registerTemplate lalily.instrument
#(define-music-function (piece options)(list? list?)
   (let ((staff-context (get-option 'staff-context options "Staff"))
         (voice-context (get-option 'voice-context options "Voice"))
         (name (get-option 'name options "instrument"))
         (instrument-name (get-option 'instrument-name options #f))
         (short-name (get-option 'short-name options #f))
         (init-voice (get-option 'init-voice options #f))
         (clef (get-option 'clef options #f))
         (transp (get-option 'transposition options (ly:make-pitch 0 0 0)))
         (natpit (get-option 'naturalize options #f))
         (input-concert-pitch (get-option 'input-concert-pitch options #t))
         (output-concert-pitch (get-option 'output-concert-pitch options #t))
         (staff-mods (get-option 'staff-mods options #f))
         (voice-mods (get-option 'voice-mods options #f))
         (midi-instrument (get-option 'midi-instrument options #f))
         (meta (get-music-deep piece 'meta #f))
         )
     (define (natmus mus) (if natpit (naturalize mus) mus))
     (if (string? clef)
         (set! meta (make-music 'SimultaneousMusic
                      'elements (list #{ \clef #clef #} meta)))
         )
     #{
       \new $staff-context = $name \with {
         $(if (ly:context-mod? staff-mods) staff-mods)
         \consists \editionEngraver $piece
         $(if (string? midi-instrument) #{ \with { midiInstrument = #midi-instrument } #} #{ \with {} #})
         %$(if (string? instrument-name) #{ \with { instrumentName = #instrument-name } #} #{ \with {} #})
         %$(if (string? short-name) #{ \with { instrumentName = #short-name } #} #{ \with {} #})
       } \new $voice-context = $name \with {
         $(if (ly:context-mod? voice-mods) voice-mods)
       } {
         $(if (not output-concert-pitch) #{ \transposition $transp #})
         $(cond
           ((and input-concert-pitch (not output-concert-pitch))
            (natmus #{
              \transpose $transp c' <<
                { #meta }
                { \getMusicDeep {} #(glue-symbol (list name 'global) "-") $(if (ly:music? init-voice) init-voice) \getMusic #'() }
              >>
              #}))
           ((and (not input-concert-pitch) output-concert-pitch)
            (natmus #{
              <<
                { #meta }
                \transpose c' $transp { \getMusicDeep {} #(glue-symbol (list name 'global) "-") $(if (ly:music? init-voice) init-voice) \getMusic #'() }
              >>
              #}))
           ((and (not input-concert-pitch) (not output-concert-pitch))
            #{
              <<
                \transpose c' $transp { #meta }
                { \getMusicDeep {} #(glue-symbol (list name 'global) "-") $(if (ly:music? init-voice) init-voice) \getMusic #'() }
              >>
            #})
           (else
            #{
              <<
                { #meta }
                { \getMusicDeep {} #(glue-symbol (list name 'global) "-") $(if (ly:music? init-voice) init-voice) \getMusic #'() }
              >>
            #})
           )
       }
     #}))

\registerTemplate lalily.piano
#(define-music-function (piece options)(list? list?)
   (let ((mods (assoc-get 'context-mods options #f #f))
         (smods (assoc-get 'staff-mods options #f #f))
         (rmods (assoc-get 'right-mods options #f #f))
         (lmods (assoc-get 'left-mods options #f #f))
         (dmods (assoc-get 'dynamic-mods options #f #f))
         (pmods (assoc-get 'pedal-mods options #f #f))
         (rclef (assoc-get 'right-clef options "G" #f))
         (lclef (assoc-get 'left-clef options "bass" #f))
         (right-name (assoc-get 'right-name options "right" #f))
         (left-name (assoc-get 'left-name options "left" #f))
         )
     #{
       \new PianoStaff \with {
         \editionID ##f $piece
         $(if (ly:context-mod? mods) mods)
       } <<
         \new Staff = $right-name \with {
           \editionID right
           $(if (ly:context-mod? smods) smods)
           $(if (ly:context-mod? rmods) rmods)
         } <<
           \keepWithTag #'piano-right \getMusicDeep {} #'meta
           \keepWithTag #'piano-right { \getMusic {} global \getMusic right }
         >>
         \new Dynamics \with {
           \editionID dynamics
           \override DynamicText.padding = #1
           $(if (ly:context-mod? dmods) dmods)
         } { \getMusic {} dynamics }
         \new Staff = $left-name \with {
           \editionID left
           $(if (ly:context-mod? smods) smods)
           $(if (ly:context-mod? lmods) lmods)
         } <<
           \keepWithTag #'piano-left \getMusicDeep {} #'meta
           \keepWithTag #'piano-left { \getMusic {} global \clef $lclef \getMusic left }
         >>
         \new Dynamics \with {
           \editionID pedal
           $(if (ly:context-mod? pmods) pmods)
         } \getMusic {} pedal
       >>
     #}))
%}