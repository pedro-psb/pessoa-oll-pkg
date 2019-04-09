\version "2.19.82"
\include "custom-include/changePitch.ily"

body=
#(define-music-function (obj)(list?)
   #{
     \score {
       \new DrumStaff <<
         \cP \padrao \melodia
         \\
         \annotations
       >>
     }
   #})